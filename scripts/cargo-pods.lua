local Public = {}

local CARGO_POD_ITEM = "recycled-cargo-pod"
local BOOSTER_ITEM = "recycled-rocket-booster"

Public.QUALITY_LEVELS = { "normal", "uncommon", "rare", "epic", "legendary" }

local function init_storage()
	storage.booster_pods = storage.booster_pods or {}
end

script.on_init(init_storage)
script.on_configuration_changed(init_storage)

-- Find the main inventory of whatever a cargo pod is headed to: a hub, a surface's landing pad, or a platform's hub
local function get_destination_inventory(destination)
	if not destination then
		return nil
	end

	local entity = nil
	if destination.type == defines.cargo_destination.station then
		entity = destination.station
	elseif destination.type == defines.cargo_destination.surface then
		local surface = destination.surface
		if surface and surface.valid then
			entity = surface.find_entities_filtered({ name = "cargo-landing-pad", limit = 1 })[1]
		end
	elseif destination.type == defines.cargo_destination.space_platform then
		local platform = destination.space_platform
		if platform and platform.valid then
			entity = platform.hub
		end
	end

	if not (entity and entity.valid) then
		return nil
	end

	local inventory = entity.get_inventory(defines.inventory.hub_main)
	if inventory and inventory.valid then
		return inventory
	end
end

-- Returns the quality of the first cargo pod item found in the inventory, or nil
local function find_cargo_pod_quality(inventory)
	for _, quality in pairs(Public.QUALITY_LEVELS) do
		if inventory.get_item_count({ name = CARGO_POD_ITEM, quality = quality }) > 0 then
			return quality
		end
	end
end

-- Is the only thing in this pod a single rocket booster?
local function is_booster_pod(pod)
	if storage.booster_pods[pod.unit_number] then
		return true
	end

	local inventory = pod.get_inventory(defines.inventory.cargo_unit)
	if not (inventory and inventory.valid) then
		return false
	end

	local contents = inventory.get_contents()
	return #contents == 1 and contents[1].name == BOOSTER_ITEM and contents[1].count == 1
end

-- Sends a pod holding a single rocket booster back to the surface's landing pad
local function create_cargo_pod(surface, position)
	local pad = surface.find_entities_filtered({ name = "cargo-landing-pad", limit = 1 })[1]
	if not (pad and pad.valid) then
		return
	end

	local pod = surface.create_entity({ name = "cargo-pod", position = position, force = pad.force })
	if not (pod and pod.valid) then
		return
	end

	local inventory = pod.get_inventory(defines.inventory.cargo_unit)
	if inventory and inventory.valid then
		inventory.insert({ name = BOOSTER_ITEM, count = 1 })
	end

	pod.cargo_pod_destination = { type = defines.cargo_destination.station, station = pad }
	storage.booster_pods[pod.unit_number] = true
end

-- Take a cargo pod item out of the pod's origin to use as this shipment's pod. Returns false if there is none.
local function consume_cargo_pod(pod)
	local origin = pod.cargo_pod_origin
	if origin and origin.valid then
		local inventory = origin.get_inventory(defines.inventory.hub_main)
		if inventory and inventory.valid then
			local quality = find_cargo_pod_quality(inventory)
			if quality then
				inventory.remove({ name = CARGO_POD_ITEM, count = 1, quality = quality })
				return true
			end
		end
	end

	-- If the user is dropping cargo pods, we use one of those as the cargo pod
	local pod_inventory = pod.get_inventory(defines.inventory.cargo_unit)
	if pod_inventory and pod_inventory.valid then
		local quality = find_cargo_pod_quality(pod_inventory)
		if quality then
			pod_inventory.remove({ name = CARGO_POD_ITEM, count = 1, quality = quality })
			return true
		end
	end

	return false
end

-- No cargo pod was available: return the items to where they came from and tell the player
local function cancel_shipment(pod)
	local origin = pod.cargo_pod_origin
	local destination = pod.cargo_pod_destination

	local pod_inventory = pod.get_inventory(defines.inventory.cargo_unit)
	if origin and origin.valid and pod_inventory and pod_inventory.valid then
		local origin_inventory = origin.get_inventory(defines.inventory.hub_main)
		if origin_inventory and origin_inventory.valid then
			for _, item in pairs(pod_inventory.get_contents()) do
				origin_inventory.insert(item)
			end
		end
	end

	if origin and origin.valid then
		local location = "?"
		if destination and destination.type == defines.cargo_destination.space_platform and destination.space_platform then
			location = destination.space_platform.name
		elseif destination and destination.surface then
			location = destination.surface.name
		end

		for _, player in pairs(game.players) do
			player.add_custom_alert(
				origin,
				{ type = "item", name = CARGO_POD_ITEM },
				{ "recycled-rocket.missing-cargo-pod", location },
				true)
		end
	end

	pod.destroy()
end

script.on_event(defines.events.on_cargo_pod_started_ascending, function(event)
	local pod = event.cargo_pod
	if not (pod and pod.valid) then
		return
	end

	-- A rocket already consumed its cargo pod when it was built, and boosters don't need one
	if event.launched_by_rocket or is_booster_pod(pod) then
		return
	end

	if not consume_cargo_pod(pod) then
		cancel_shipment(pod)
	end
end)

script.on_event(defines.events.on_cargo_pod_finished_ascending, function(event)
	if not event.launched_by_rocket then
		return
	end

	local pod = event.cargo_pod
	if not (pod and pod.valid) then
		return
	end

	-- Simulate the rocket's booster returning
	create_cargo_pod(pod.surface, pod.position)
end)

script.on_event(defines.events.on_cargo_pod_delivered_cargo, function(event)
	local pod = event.cargo_pod
	if not (pod and pod.valid) then
		return
	end

	-- A returning booster is not a cargo pod
	local is_booster = is_booster_pod(pod)
	storage.booster_pods[pod.unit_number] = nil
	if is_booster then
		return
	end

	local item = { name = CARGO_POD_ITEM, count = 1 }

	local inventory = get_destination_inventory(pod.cargo_pod_destination)
	if not inventory then
		-- Fall back to wherever the pod actually landed
		local surface = pod.surface
		local entity = nil
		if surface.platform and surface.platform.valid then
			entity = surface.platform.hub
		else
			entity = surface.find_entities_filtered({ name = "cargo-landing-pad", limit = 1 })[1]
		end
		if entity and entity.valid then
			inventory = entity.get_inventory(defines.inventory.hub_main)
		end
	end

	if inventory and inventory.valid and inventory.insert(item) > 0 then
		return
	end

	-- Nowhere to put it (no hub, or it's full), so don't lose the pod
	pod.surface.spill_item_stack({ position = pod.position, stack = item })
end)

return Public

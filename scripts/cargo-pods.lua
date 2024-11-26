local Public = {}

local warning_color = { r = 255, g = 60, b = 60 }
Public.QUALITY_LEVELS = { "normal", "uncommon", "rare", "epic", "legendary" }

script.on_nth_tick(60, function()
	if not storage.recycle_cargo_pods then
		storage.recycle_cargo_pods = {}
	end

	local existing_pods = {}

	for surface_name, surface in pairs(game.surfaces) do
		local cargo_pods = surface.find_entities_filtered({ name = "cargo-pod" })
		for _, pod in pairs(cargo_pods) do
			if not (pod and pod.valid) then
				break
			end

			-- Store this cargo pod
			existing_pods[pod.unit_number] = true
			if not storage.recycle_cargo_pods[pod.unit_number] then
				storage.recycle_cargo_pods[pod.unit_number] = { 
					planet = false, 
					platform = false, 
					arriving = false, 
					departure_surface_name = surface_name,
					arrival_surface_name = nil
				}
			end

			local platform = surface.platform

			-- pull my pair
			local seen_on = storage.recycle_cargo_pods[pod.unit_number]

			-- Are we currently in space?
			if platform and platform.valid then
				-- Detect if we're coming or going based on where we've been
				if seen_on.planet then
					storage.recycle_cargo_pods[pod.unit_number].arriving = true
					storage.recycle_cargo_pods[pod.unit_number].arrival_surface_name = surface_name
					-- if pod.procession_tick > 60 * 12 or pod.procession_tick < 60 * 5.5 then break end
					--Public.handle_cargo_pod_arriving_on_platform(pod, platform)
				else
					Public.handle_cargo_pod_departing_platform(pod, platform)
				end
			-- We must be on a planet!
			else
				-- Detect if we're coming or going based on where we've been
				if seen_on.platform then
					storage.recycle_cargo_pods[pod.unit_number].arriving = true
					storage.recycle_cargo_pods[pod.unit_number].arrival_surface_name = surface_name
					--if pod.procession_tick > 60 * 14 or pod.procession_tick < 60 * 5.5 then break end
					--Public.handle_cargo_pod_arriving_on_planet(pod)
				else
					Public.handle_cargo_pod_departing_planet(pod)
				end
			end
		end
	end

	-- Now we handle arriving and clear out our storage
	for unit_number, seen_on in pairs(storage.recycle_cargo_pods) do
		if existing_pods[unit_number] then
			goto continue
		end

		-- If we're arriving, and the pod is "gone" IE it landed and is deleted, we need to run our arriving logic
		-- Notice the place we are "seen_on" is our departure location 
		if seen_on.arriving then
			if seen_on.planet then
				Public.handle_cargo_pod_arriving_on_platform(unit_number)
			else
				Public.handle_cargo_pod_arriving_on_planet(unit_number)
			end
		else
			-- This happens when the pod is destroyed, and we need to return the items to the hub
		end

		-- Clear out the pod
		storage.recycle_cargo_pods[unit_number] = nil
		::continue::
	end
end)

function Public.handle_cargo_pod_arriving_on_platform(unit_number)
	local pod = storage.recycle_cargo_pods[unit_number]
	if not (pod and pod.arrival_surface_name) then
		--game.print("Platform: No arrival surface name")
		return
	end

	local surface = game.surfaces[pod.arrival_surface_name]
	if not (surface and surface.valid) then
		--game.print("Platform: No valid surface")
		return
	end

	local platform = surface.platform
	if not (platform and platform.valid) then
		--game.print("Platform: No valid platform")
		return
	end
	if not (platform.space_location
			and platform.space_location.valid
			and platform.space_location
			and platform.space_location.valid
			and platform.space_location.name) then
		--game.print("Platform: No valid space location")
		return
	end

	local hub = platform.hub
	if not (hub and hub.valid) then
		--game.print("Platform: No valid hub")
		return
	end

	local hub_inventory = hub.get_inventory(defines.inventory.hub_main)
	if not (hub_inventory and hub_inventory.valid) then
		--game.print("Platform: No valid hub inventory")
		return
	end

	-- Attempt to find the hub, and insert ourselves into it.
	hub_inventory.insert({ name = "recycled-cargo-pod", count = 1 })	
	storage.recycle_cargo_pods[unit_number] = nil
end

function Public.handle_cargo_pod_arriving_on_planet(unit_number)
	local pod = storage.recycle_cargo_pods[unit_number]
	if not (pod and pod.arrival_surface_name) then
		--game.print("Planet: No arrival surface name")
		return
	end

	local surface = game.surfaces[pod.arrival_surface_name]
	if not (surface and surface.valid) then
		--game.print("Planet: No valid surface")
		return
	end

	if not (surface.planet
			and surface.planet.valid
			and surface.planet.name) then
		--game.print("Planet: No valid planet")
		return
	end

	-- Attempt to find the hub, and insert ourselves into it.
	local cargo_landing_pads = surface.find_entities_filtered({ name = "cargo-landing-pad" })
	for _, cargo_landing_pad in pairs(cargo_landing_pads) do
		local landing_inventory = cargo_landing_pad.get_inventory(defines.inventory.hub_main)
		if landing_inventory and landing_inventory.valid then
			landing_inventory.insert({ name = "recycled-cargo-pod", count = 1 })	
			--game.print("Planet: Inserted cargo pod")
			return
		end
	end

	--game.print("Planet: No valid cargo landing pad")
end

function Public.handle_cargo_pod_departing_platform(pod, platform)
	if not ( platform.space_location
			and platform.space_location.valid
			and platform.space_location
			and platform.space_location.valid
			and platform.space_location.name) then
		return
	end

	-- We have already removed the cargo pod from the platform.
	if storage.recycle_cargo_pods[pod.unit_number].platform then
		return
	end

	local planet_name = platform.space_location.name

	local hub = platform.hub
	if not (hub and hub.valid) then
		return
	end

	local hub_inventory = hub.get_inventory(defines.inventory.hub_main)
	if not (hub_inventory and hub_inventory.valid) then
		return
	end

	-- Attempt to find the cargo pod in the hub, and remove it.
	local cargo_name = "recycled-cargo-pod"
	for _, quality in pairs(Public.QUALITY_LEVELS) do
		if hub_inventory.get_item_count({ name = cargo_name, quality = quality }) > 0 then
			storage.recycle_cargo_pods[pod.unit_number].platform = true
			hub_inventory.remove({ name = cargo_name, count = 1, quality = quality })
			return -- success state
		end
	end

	--game.print("Attempting to send cargo without a cargo pod")

	-- If we didn't find any cargo pods, we should destroy the cargo pod and return the items
	local pod_inventory = pod.get_inventory(defines.inventory.cargo_wagon)
	if not (pod_inventory and pod_inventory.valid) then
		--game.print("Couldn't get pod inventory")
		return
	end

	-- If the user is dropping cargo pods, we want to remove 1 and use that as the cargo pod
	for _, quality in pairs(Public.QUALITY_LEVELS) do
		if pod_inventory.get_item_count({ name = cargo_name, quality = quality }) > 0 then
			--game.print("Reducing stack size to send full stack")
			storage.recycle_cargo_pods[pod.unit_number].platform = true
			pod_inventory.remove({ name = cargo_name, count = 1, quality = quality })
			return -- success state
		end
	end

	-- ERROR: We couldn't find the cargo pod in the pod's inventory, return the items to the hub

	-- Insert the items back into the hub	
	local pod_contents = pod_inventory.get_contents()
	if pod_contents then
		--game.print("Returning cargo pod items to hub")
		for _, item in pairs(pod_contents) do
			hub_inventory.insert( item)
		end
	end

	-- Tell the user that the cargo pod was destroyed
	for _, player in pairs(game.players) do
		player.add_custom_alert(
			hub, 
			{type = "item", name = "recycled-cargo-pod"},
			{ "recycled-rocket.missing-cargo-pod", planet_name }, 
			true)
	end
	--pod.force.print({ "recycled-rocket.missing-cargo-pod", planet_name, }, { color = warning_color })

	--game.print("Destroying cargo pod that doesn't actually exist")
	pod.destroy()
end

function Public.handle_cargo_pod_departing_planet(pod)
	-- Marks that we are ascending
	storage.recycle_cargo_pods[pod.unit_number].planet = true
end

return Public

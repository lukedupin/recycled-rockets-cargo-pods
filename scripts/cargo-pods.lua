local Public = {}

local warning_color = { r = 255, g = 60, b = 60 }
Public.QUALITY_LEVELS = { "normal", "uncommon", "rare", "epic", "legendary" }

script.on_nth_tick(60, function()
	if not storage.recycle_cargo_pods_planet then
		storage.recycle_cargo_pods_planet = {}
	end
	if not storage.recycle_cargo_pods_platform then
		storage.recycle_cargo_pods_platform = {}
	end

	for _, surface in pairs(game.surfaces) do
		local cargo_pods = surface.find_entities_filtered({ name = "cargo-pod" })
		for _, pod in pairs(cargo_pods) do
			if not (pod and pod.valid) then
				break
			end

			local platform = surface.platform

			local seen_platform = storage.recycle_cargo_pods_platform[pod.unit_number]
			local seen_planet = storage.recycle_cargo_pods_planet[pod.unit_number]

			-- Are we currently in space?
			if platform and platform.valid then
				-- Detect if we're coming or going based on where we've been
				if seen_planet then
					if pod.procession_tick > 60 * 12 or pod.procession_tick < 60 * 5.5 then
						break
					end
					Public.handle_cargo_pod_arriving_on_platform(pod, platform)
				else
					Public.handle_cargo_pod_departing_platform(pod, platform)
				end
			-- We must be on a planet!
			else
				-- Detect if we're coming or going based on where we've been
				if seen_platform then
					if pod.procession_tick > 60 * 14 or pod.procession_tick < 60 * 5.5 then
						break
					end
					Public.handle_cargo_pod_arriving_on_planet(pod)
				else
					Public.handle_cargo_pod_departing_planet(pod)
				end
			end
		end
	end
end)

function Public.handle_cargo_pod_arriving_on_platform(pod, platform)
	if not (
			platform.space_location
			and platform.space_location.valid
			and platform.space_location
			and platform.space_location.valid
			and platform.space_location.name
		)
	then
		return
	end

	-- We have already removed the cargo pod from the platform.
	if storage.recycle_cargo_pods_platform[pod.unit_number] then
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


	-- Attempt to find the hub, and insert ourselves into it.
	hub_inventory.insert({ name = "recycled-cargo-pod", count = 1 })	
	storage.recycle_cargo_pods_platform[pod.unit_number] = true
end

function Public.handle_cargo_pod_departing_platform(pod, platform)
	if not (
			platform.space_location
			and platform.space_location.valid
			and platform.space_location
			and platform.space_location.valid
			and platform.space_location.name
		)
	then
		return
	end

	-- We have already removed the cargo pod from the platform.
	if storage.recycle_cargo_pods_platform[pod.unit_number] then
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


	local cargo_name = "recycled-cargo-pod"
	local available_count = 0
	for _, quality in pairs(Public.QUALITY_LEVELS) do
		available_count = available_count + hub_inventory.get_item_count({ name = cargo_name, quality = quality })
		if available_count > 0 then
			storage.recycle_cargo_pods_platform[pod.unit_number] = true
			hub_inventory.remove({ name = cargo_name, count = 1, quality = quality })
			break
		end
	end

	-- If we didn't find any cargo pods, we should destroy the cargo pod and return the items
	if available_count <= 0 then
		local pod_contents = pod.get_inventory(defines.inventory.cargo_unit).get_contents()
		for _, item in pairs(pod_contents) do
			hub_inventory.insert( item)
		end

		-- Tell the user that the cargo pod was destroyed
		for _, player in pairs(game.players) do
			player.add_custom_alert(
				hub, 
      			{type = "item", name = "recycled-cargo-pod"},
				{ "recycled-rocket.missing-cargo-pod", planet_name }, 
				true)
		end
		--local player = game.get_player(1)
		--if player then
			--player.add_custom_alert(platorm, nil, {
				--"recycled-rocket.missing-cargo-pod",
				--planet_name,
			--}, true)
		--end
		--pod.force.print({ "recycled-rocket.missing-cargo-pod", planet_name, }, { color = warning_color })

		pod.destroy()
	end
end

function Public.handle_cargo_pod_arriving_on_planet(pod)
	if
		not (
			pod.surface
			and pod.surface.valid
			and pod.surface.planet
			and pod.surface.planet.valid
			and pod.surface.planet.name
			and pod.force
			and pod.force.valid
		)
	then
		return
	end

	-- We have already removed the cargo pod from the platform.
	if storage.recycle_cargo_pods_planet[pod.unit_number] then
		return
	end

	-- Attempt to find the hub, and insert ourselves into it.
	local cargo_landing_pads = pod.surface.find_entities_filtered({ name = "cargo-landing-pad" })
	for _, cargo_landing_pad in pairs(cargo_landing_pads) do
		local landing_inventory = cargo_landing_pad.get_inventory(defines.inventory.hub_main)
		if landing_inventory and landing_inventory.valid then
			landing_inventory.insert({ name = "recycled-cargo-pod", count = 1 })	
			storage.recycle_cargo_pods_planet[pod.unit_number] = true
			break
		end
	end
end

function Public.handle_cargo_pod_departing_planet(pod)
	-- Marks that we are ascending
	storage.recycle_cargo_pods_planet[pod.unit_number] = true
end

return Public

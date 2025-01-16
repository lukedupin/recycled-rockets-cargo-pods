local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

-- Cargo Pod --

-- CargoPod item
local recycledCargoPodItem = {
	type = "item",
	name = "recycled-cargo-pod",
	icon = "__recycled-rockets-cargo-pods__/graphics/cargo-pod.png",
	subgroup = "space-related",
	order = "d[rocket-silo]",
	inventory_move_sound = space_age_item_sounds.mechanical_large_inventory_move,
	pick_sound = space_age_item_sounds.mechanical_large_inventory_pickup,
	drop_sound = space_age_item_sounds.mechanical_large_inventory_move,
	weight = 0.05 * tons,
	stack_size = 20
}

-- Create the recycled rocket pod
local recycledCargoPodRecipe = {
	type = "recipe",
	name = "recycled-cargo-pod",
	energy_required = 10,
	enabled = false,
	category = "crafting",
    ingredients =
    {
	  {type = "item", name = "processing-unit", amount = 5},
      {type = "item", name = 'low-density-structure', amount = 5},
      {type = "item", name = 'thruster', amount = 1}
    },
	results = {{type="item", name="recycled-cargo-pod", amount=1}}
}

-- The Recycled Rocket --

-- RecycledRocket item
local recycledRocketBoosterItem = {
	type = "item",
	name = "recycled-rocket-booster",
	icon = "__recycled-rockets-cargo-pods__/graphics/recycled-rocket-booster.png",
	subgroup = "space-related",
	order = "d[rocket-silo]",
	inventory_move_sound = space_age_item_sounds.mechanical_large_inventory_move,
	pick_sound = space_age_item_sounds.mechanical_large_inventory_pickup,
	drop_sound = space_age_item_sounds.mechanical_large_inventory_move,
	weight = 1 * tons,
	stack_size = 1
}

-- Create the recycled rocket pod
local recycledRocketBoosterRecipe = {
	type = "recipe",
	name = "recycled-rocket-booster",
	energy_required = 10,
	enabled = false,
	category = "crafting",
    ingredients =
    {
      {type = "item", name = 'thruster', amount = 15},
	  {type = "item", name = "processing-unit", amount = 100},
      {type = "item", name = 'low-density-structure', amount = 100}
    },
	results = {{type="item", name="recycled-rocket-booster", amount=1}}
}

-- The Recycled Fuel Pod --

-- RecycledFuelPod item
local recycledFuelPodItem = {
	type = "item",
	name = "recycled-fuel-pod",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-fuel.png",
	subgroup = "space-related",
	order = "b[recycled-cargo-pod]",
	inventory_move_sound = space_age_item_sounds.mechanical_large_inventory_move,
	pick_sound = space_age_item_sounds.mechanical_large_inventory_pickup,
	drop_sound = space_age_item_sounds.mechanical_large_inventory_move,
	weight = 0.01 * tons,
	stack_size = 20
}

-- Create the recycled rocket pod
--local recycledFuelPodRecipe = {
	--type = "recipe",
	--name = "recycled-fuel-pod",
	--energy_required = 30,
	--enabled = false,
	--category = "crafting",
    --ingredients =
    --{
	  --{type = "item", name = "processing-unit", amount = 1},
      --{type = "item", name = 'low-density-structure', amount = 2},
      --{type = "item", name = 'rocket-fuel', amount = 20}
    --},
	--results = {{type="item", name="recycled-fuel-pod", amount=20}}
--}



-- The basic recyclable rocket silo
local basicSiloPlaced = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
basicSiloPlaced.name = "basic-recycled-rocket-silo"
basicSiloPlaced.fixed_recipe = "basic-rocket-ship"
-- basicSiloPlaced.fixed_recipe = "" -- Wish this could work but it allows the original also, which breaks everything
basicSiloPlaced.rocket_parts_required = 1 -- Needs to be one since the output doesn't honor anything other than 1
basicSiloPlaced.icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-re-vulcanus.png"

-- Inventory item for the recycled rocket silo
local basicSiloItem = {
	type = "item",
	name = "basic-recycled-rocket-silo",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-re-vulcanus.png",
	subgroup = "space-related",
	order = "a[rocket-silo]",
	inventory_move_sound = space_age_item_sounds.mechanical_large_inventory_move,
	pick_sound = space_age_item_sounds.mechanical_large_inventory_pickup,
	drop_sound = space_age_item_sounds.mechanical_large_inventory_move,
	place_result = "basic-recycled-rocket-silo",
	weight = 2 * tons,
	stack_size = 1
}

-- Recipe for building the new silo
local basicRocketSiloRecipe = {
	type = "recipe",
	name = "basic-recycled-rocket-silo",
	enabled = false,
	ingredients =
	{
	  {type = "item", name = "rocket-silo", amount = 1},
	  {type = "item", name = "pipe", amount = 100},
	  {type = "item", name = "electric-engine-unit", amount = 50}
	},
	energy_required = 30,
	results = {{type="item", name="basic-recycled-rocket-silo", amount=1}},
	requester_paste_multiplier = 1
}


-- Rocket Ship --

-- Create a new recipe for the recycled rocket
local rocketRecipe = {
	type = "recipe",
	name = "basic-rocket-ship",
	energy_required = 25,
	enabled = false,
	hide_from_player_crafting = true,
	category = "rocket-building",
    ingredients =
    {
      {type = "item", name = "recycled-cargo-pod", amount = 1},
      {type = "item", name = "recycled-rocket-booster", amount = 1},
	  {type = "item", name = "rocket-fuel", amount = 100}
    },
	results = {{type="item", name="rocket-part", amount=1}},
	allow_productivity = true
}

-- Bug to fix the initial creation of a space platform not having a cargo pod
--local spspItem = table.deepcopy(data.raw["space-platform-starter-pack"]["space-platform-starter-pack"])
--spspItem.initial_items = {
	--{
		--amount = 10,
		--name = "space-platform-foundation",
		--type = "item"
	--},
	--{
		--amount = 1,
		--name = "recycled-cargo-pod",
		--type = "item"
	--}
--}


-- Create the technology for the recycled rocket
local recycledRocketTech = {
	type = "technology",
	name = "cargo-pod",
	icon = "__recycled-rockets-cargo-pods__/graphics/cargo-pod-tech.png",
	icon_size = 256,
	essential = true,
	effects = {
	  {
		type = "unlock-recipe",
		recipe = "basic-recycled-rocket-silo"
	  },
	  {
		type = "unlock-recipe",
		recipe = "basic-rocket-ship"
	  },
	  --{
		--type = "unlock-recipe",
		--recipe = "recycled-fuel-pod"
	  --},
	  {
		type = "unlock-recipe",
		recipe = "recycled-rocket-booster"
	  },
	  {
		type = "unlock-recipe",
		recipe = "recycled-cargo-pod"
	  }
	},
	prerequisites = {
	  "rocket-silo"
	},
	unit = {
	  count = 500,
	  ingredients =
	  {
		{"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"space-science-pack", 1}
	  },
	  time = 60
	}
}

data.extend({
	basicSiloPlaced,
	basicSiloItem,
	basicRocketSiloRecipe,

    recycledCargoPodItem,
    recycledCargoPodRecipe,

	recycledRocketBoosterItem,
	recycledRocketBoosterRecipe,

	recycledFuelPodItem,
	--recycledFuelPodRecipe,

    rocketRecipe,
    recycledRocketTech

	--spspItem
})
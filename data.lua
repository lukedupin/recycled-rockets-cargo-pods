require("prototypes.vulcanus")
require("prototypes.fulgora")

local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

-- Cargo Pod --

-- CargoPod item
local recycledCargoPodItem = {
	type = "item",
	name = "recycled-cargo-pod",
	icon = "__recycled-rockets-cargo-pods__/graphics/cargo-pod.png",
	subgroup = "space-related",
	order = "c[rocket-silo]",
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

-- replace factorio's rocket silo with the recycled one
local silo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
silo.fixed_recipe = "basic-rocket-ship"
silo.rocket_parts_required = 1 -- Needs to be one since the output doesn't honor anything other than 1


-- Rocket Ship --

-- Create a new recipe for the recycled rocket
local rocketRecipe = {
	type = "recipe",
	name = "basic-rocket-ship",
	energy_required = 60,
	enabled = false,
	hide_from_player_crafting = true,
	category = "rocket-building",
    ingredients =
    {
      {type = "item", name = "recycled-cargo-pod", amount = 1},
      {type = "item", name = 'thruster', amount = 5},
	  {type = "item", name = "processing-unit", amount = 50},
      {type = "item", name = 'low-density-structure', amount = 100},
      {type = "item", name = 'rocket-fuel', amount = 100}
    },
	results = {{type="item", name="rocket-part", amount=1}},
	allow_productivity = true
}

-- Fix soft lock of thrusters not being craftable
local sptTech = table.deepcopy(data.raw["technology"]["space-platform-thruster"])
sptTech.effects = {
	-- Remove the thruster, it now appears in the drop pod
	{
		type = "unlock-recipe",
		recipe = "ice-melting"
	},
	{
		type = "unlock-recipe",
		recipe = "thruster-fuel"
	},
	{
		type = "unlock-recipe",
		recipe = "thruster-oxidizer"
	}
}

-- Bug to fix the initial creation of a space platform not having a cargo pod
local spspItem = table.deepcopy(data.raw["space-platform-starter-pack"]["space-platform-starter-pack"])
spspItem.initial_items = {
	{
		amount = 10,
		name = "space-platform-foundation",
		type = "item"
	},
	{
		amount = 1,
		name = "recycled-cargo-pod",
		type = "item"
	}
}


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
		recipe = "basic-rocket-ship"
	  },
	  {
		type = "unlock-recipe",
		recipe = "thruster"
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
	  count = 200,
	  ingredients =
	  {
		{"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
	  },
	  time = 60
	}
}

data.extend({
    silo,
    recycledCargoPodItem,
    recycledCargoPodRecipe,

    rocketRecipe,
    recycledRocketTech,

	-- Fix soft lock of thrusters not being craftable
	sptTech,
	spspItem
})


local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



-- The advanced recyclable rocket silo
local advancedSiloPlaced = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
advancedSiloPlaced.name = "advanced-recycled-rocket-silo"
advancedSiloPlaced.fixed_recipe = "advanced-rocket-ship"
-- advancedSiloPlaced.fixed_recipe = "" -- Wish this could work but it allows the original also, which breaks everything
advancedSiloPlaced.rocket_parts_required = 1 -- Needs to be one since the output doesn't honor anything other than 1
advancedSiloPlaced.icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-re-fulgora.png"

-- Inventory item for the recycled rocket silo
local advancedSiloItem = {
	type = "item",
	name = "advanced-recycled-rocket-silo",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-re-fulgora.png",
	subgroup = "space-related",
	order = "b[rocket-silo]",
	inventory_move_sound = space_age_item_sounds.mechanical_large_inventory_move,
	pick_sound = space_age_item_sounds.mechanical_large_inventory_pickup,
	drop_sound = space_age_item_sounds.mechanical_large_inventory_move,
	place_result = "advanced-recycled-rocket-silo",
	weight = 2 * tons,
	stack_size = 1
}

-- Recipe for building the new silo
local advancedRocketSiloRecipe = {
	type = "recipe",
	name = "advanced-recycled-rocket-silo",
	enabled = false,
	ingredients =
	{
	  {type = "item", name = "basic-recycled-rocket-silo", amount = 1},
	  {type = "item", name = "low-density-structure", amount = 200},
	},
	energy_required = 30,
	results = {{type="item", name="advanced-recycled-rocket-silo", amount=1}},
	requester_paste_multiplier = 1
}


-- Rocket Ship --

-- Create a new recipe for the recycled rocket
local advancedRocketRecipe = {
	type = "recipe",
	name = "advanced-rocket-ship",
	energy_required = 8,
	enabled = false,
	hide_from_player_crafting = true,
	category = "rocket-building",
    ingredients =
    {
      {type = "item", name = "recycled-cargo-pod", amount = 1},
      {type = "item", name = "recycled-rocket-booster", amount = 1},
	  {type = "item", name = "recycled-fuel-pod", amount = 100}
    },
	results = {{type="item", name="rocket-part", amount=1}},
	allow_productivity = true
}


-- The Recycled Fuel Pod --

-- Create the recycled rocket pod
local nuclearFuelPodRecipe = {
	type = "recipe",
	name = "nuclear-fuel-pod",
	energy_required = 32,
	enabled = false,
	category = "centrifuging",
	order = "c[rocket-silo]",
    ingredients =
    {
	  {type = "item", name = "uranium-fuel-cell", amount = 1},
	  {type = "item", name = "low-density-structure", amount = 5},
      {type = "item", name = 'rocket-fuel', amount = 20}
    },
	results = {{type="item", name="recycled-fuel-pod", amount=50}}
}

-- Tech --

-- Create the technology for the nuclear rocket
local nuclearRocketTech = {
	type = "technology",
	name = "nuclear-rocket-ship",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-tech-nuclear.png",
	icon_size = 256,
	essential = false,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "nuclear-fuel-pod"
	  },
	  {
		type = "unlock-recipe",
		recipe = "advanced-recycled-rocket-silo"
	  },
	  {
		type = "unlock-recipe",
		recipe = "advanced-rocket-ship"
	  }
	},
	prerequisites =
	{
	  "rocket-silo",
	  "cargo-pod",
	  "nuclear-power"
	},
	unit =
	{
	  count = 500,

	  ingredients =
	  {
		{"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"utility-science-pack", 1},
		{"space-science-pack", 1}
	  },
	  time = 60
	}
}

data:extend({
	advancedSiloPlaced,
	advancedSiloItem,
	advancedRocketSiloRecipe,
	advancedRocketRecipe,

	nuclearFuelPodRecipe,
	nuclearRocketTech
})
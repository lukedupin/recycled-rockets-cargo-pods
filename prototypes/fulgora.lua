local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

-- Silo --

-- Duplicate the rocket silo and rocket recipe to make a recycled rocket silo and rocket
local recycledRocketSiloPlaced = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
recycledRocketSiloPlaced.name = "recycled-mag-rocket-silo"
recycledRocketSiloPlaced.fixed_recipe = "recycled-mag-rocket-ship"
-- recycledRocketSiloPlaced.fixed_recipe = "" -- Wish this could work but it allows the original also, which breaks everything
recycledRocketSiloPlaced.rocket_parts_required = 1 -- Needs to be one since the output doesn't honor anything other than 1
recycledRocketSiloPlaced.icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-re-fulgora.png"

-- Inventory item for the recycled rocket silo
local recycledRocketSiloItem = {
	type = "item",
	name = "recycled-mag-rocket-silo",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-re-fulgora.png",
	subgroup = "space-related",
	order = "b[rocket-silo]",
	inventory_move_sound = space_age_item_sounds.mechanical_large_inventory_move,
	pick_sound = space_age_item_sounds.mechanical_large_inventory_pickup,
	drop_sound = space_age_item_sounds.mechanical_large_inventory_move,
	place_result = "recycled-mag-rocket-silo",
	weight = 10 * tons,
	stack_size = 1
}

-- Recipe for building the new silo
local recycledRocketSiloRecipe = {
	type = "recipe",
	name = "recycled-mag-rocket-silo",
	enabled = false,
	ingredients =
	{
	  {type = "item", name = "recycled-rocket-silo", amount = 1},
	  {type = "item", name = "holmium-plate", amount = 100},
	  {type = "item", name = "superconductor", amount = 50},
	},
	energy_required = 30,
	results = {{type="item", name="recycled-mag-rocket-silo", amount=1}},
	requester_paste_multiplier = 1
}

-- Rocket Ship --

-- Create a new recipe for the recycled rocket
local recycledRocketRecipe = {
	type = "recipe",
	name = "recycled-mag-rocket-ship",
	energy_required = 10,
	enabled = false,
	hide_from_player_crafting = true,
	category = "rocket-building",
    ingredients = {
      {type = "item", name = "recycled-cargo-pod", amount = 1},
	  {type = "item", name = "steel-plate", amount = 20},
      {type = "item", name = "recycled-mag-fuel", amount = 5}
    },
	results = {{type="item", name="rocket-part", amount=1}},
	allow_productivity = true
}


-- Cargo Pod --

-- CargoPod item
local recycledMagFuelItem = {
	type = "item",
	name = "recycled-mag-fuel",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-fuel.png",
	subgroup = "space-related",
	order = "d[rocket-silo]",
	inventory_move_sound = space_age_item_sounds.mechanical_large_inventory_move,
	pick_sound = space_age_item_sounds.mechanical_large_inventory_pickup,
	drop_sound = space_age_item_sounds.mechanical_large_inventory_move,
	weight = 0.01 * tons,
	stack_size = 20
}

-- Create the recycled rocket pod
local recycledMagFuelRecipe = {
	type = "recipe",
	name = "recycled-mag-fuel",
	energy_required = 40,
	enabled = false,
	category = "electromagnetics",
    ingredients =
    {
      {type = "item", name = "calcite", amount = 1},
	  {type = "item", name = "superconductor", amount = 1},
      {type = "item", name = 'rocket-fuel', amount = 80},
      {type = "fluid", name = 'heavy-oil', amount = 2000},
    },
	results = {{type="item", name="recycled-mag-fuel", amount=5}}
}


-- Tech --

-- Create the technology for the recycled rocket
local recycledRocketTech = {
	type = "technology",
	name = "recycled-mag-rocket-ship",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-tech-fulgora.png",
	icon_size = 256,
	essential = true,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "recycled-mag-rocket-silo"
	  },
	  {
		type = "unlock-recipe",
		recipe = "recycled-mag-rocket-ship"
	  },
	  {
		type = "unlock-recipe",
		recipe = "recycled-mag-fuel"
	  }
	},
	prerequisites =
	{
	  "rocket-silo",
	  "planet-discovery-fulgora"
	},
	unit =
	{
	  count = 1000,

	  ingredients =
	  {
		{"automation-science-pack", 1},
		{"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"utility-science-pack", 1},
	    {"electromagnetic-science-pack", 1},
		{"space-science-pack", 1}
	  },
	  time = 60
	}
}

data:extend({
	recycledRocketSiloPlaced,
	recycledRocketRecipe,
	recycledRocketSiloItem,
	recycledRocketSiloRecipe,

	recycledMagFuelItem,
	recycledMagFuelRecipe,

	recycledRocketTech
})

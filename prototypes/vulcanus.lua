local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


-- The Recycled Fuel Pod --


-- Create the recycled rocket pod
local vulcanusFuelPodRecipe = {
	type = "recipe",
	name = "vulcanus-fuel-pod",
	energy_required = 16,
	enabled = false,
	hide_from_player_crafting = true,
	category = "metallurgy",
	order = "c[rocket-silo]",
    ingredients =
    {
	  {type = "item", name = "tungsten-plate", amount = 1},
      {type = "item", name = 'calcite', amount = 1},
      {type = "fluid", name = 'sulfuric-acid', amount = 100}
    },
	surface_conditions = {
        {
          max = 4000,
          min = 4000,
          property = "pressure"
        }
    },
	results = {{type="item", name="recycled-fuel-pod", amount=5}}
}

-- Tech --

-- Create the technology for the vulcanus rocket
local vulcanusRocketTech = {
	type = "technology",
	name = "vulcanus-rocket-ship",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-tech-vulcanus.png",
	icon_size = 256,
	essential = false,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "vulcanus-fuel-pod"
	  }
	},
	prerequisites =
	{
	  "nuclear-rocket-ship",
	  "planet-discovery-vulcanus"
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
	--vulcanusFuelPodItem,
	vulcanusFuelPodRecipe,

	vulcanusRocketTech
})
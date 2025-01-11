local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


-- The Recycled Fuel Pod --

-- Create the recycled rocket pod
local nuclearFuelPodRecipe = {
	type = "recipe",
	name = "nuclear-fuel-pod",
	energy_required = 40,
	enabled = false,
	category = "centrifuging",
    ingredients =
    {
	  {type = "item", name = "uranium-fuel-cell", amount = 1},
	  {type = "item", name = "processing-unit", amount = 2},
	  {type = "item", name = "low-density-structure", amount = 5},
      {type = "item", name = 'rocket-fuel', amount = 10}
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
	  }
	},
	prerequisites =
	{
	  "rocket-silo",
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
	--nuclearFuelPodItem,
	nuclearFuelPodRecipe,

	nuclearRocketTech
})
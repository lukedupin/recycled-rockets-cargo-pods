local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



-- Magnetic fuel --

-- Create the recycled rocket pod
local recycledMagFuelRecipe = {
	type = "recipe",
	name = "recycled-mag-fuel",
	energy_required = 40,
	enabled = false,
	category = "electromagnetics",
    ingredients =
    {
	  {type = "item", name = "superconductor", amount = 1},
      {type = "item", name = 'solid-fuel', amount = 500},
    },
	results = {{type="item", name="recycled-fuel-pod", amount=50}}
}

-- Tech --

-- Create the technology for the recycled rocket
local recycledMagRocketTech = {
	type = "technology",
	name = "recycled-mag-rocket-ship",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-tech-fulgora.png",
	icon_size = 256,
	essential = false,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "recycled-mag-fuel"
	  }
	},
	prerequisites =
	{
	  "rocket-silo",
	  "cargo-pod",
	  "planet-discovery-fulgora"
	},
	unit =
	{
	  count = 200,

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
	recycledMagFuelRecipe,

	recycledMagRocketTech,
})

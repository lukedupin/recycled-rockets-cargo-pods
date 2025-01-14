local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



-- Magnetic fuel --

-- Create the recycled rocket pod
local recycledMagFuelRecipe = {
	type = "recipe",
	name = "recycled-mag-fuel",
	energy_required = 20,
	enabled = false,
	category = "electromagnetics",
	order = "c[rocket-silo]",
    ingredients =
    {
	  {type = "item", name = "superconductor", amount = 1},
      {type = "item", name = 'solid-fuel', amount = 1000},
    },
	surface_conditions = {
        {
          max = 99,
          min = 99,
          property = "magnetic-field"
		}
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
	  "nuclear-rocket-ship",
	  "planet-discovery-fulgora"
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
	recycledMagFuelRecipe,

	recycledMagRocketTech,
})

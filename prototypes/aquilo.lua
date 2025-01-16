local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


-- Aquilo fuel --

-- Create the recycled rocket pod
local recycledAquiloFuelRecipe = {
	type = "recipe",
	name = "recycled-cryo-fuel",
	energy_required = 2,
	enabled = false,
	category = "cryogenics",
	order = "c[rocket-silo]",
    ingredients =
    {
	  {type = "fluid", name = "fluoroketone-cold", amount = 10},
      {type = "item", name = 'rocket-fuel', amount = 1},
    },
	surface_conditions = {
        {
          max = 300,
          min = 300,
          property = "pressure"
        }
      },
	results = {
	  {type = "fluid", name = "fluoroketone-hot", amount=5},
	  {type="item", name="recycled-fuel-pod", amount=5}
	}
}

-- Tech --

-- Create the technology for the recycled rocket
local recycledAquiloRocketTech = {
	type = "technology",
	name = "recycled-cryo-rocket-ship",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-tech-aquilo.png",
	icon_size = 256,
	essential = false,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "recycled-cryo-fuel"
	  }
	},
	prerequisites =
	{
	  "nuclear-rocket-ship",
	  "planet-discovery-aquilo"
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
		{"space-science-pack", 1},
		{"agricultural-science-pack", 1},
		{"metallurgic-science-pack", 1},
		{"electromagnetic-science-pack", 1}
	  },
	  time = 60
	}
}

data:extend({
	recycledAquiloFuelRecipe,

	recycledAquiloRocketTech,
})

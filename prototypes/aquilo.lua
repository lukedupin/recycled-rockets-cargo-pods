local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


-- Aquilo fuel --

-- Create the recycled rocket pod
local recycledAquiloFuelRecipe = {
	type = "recipe",
	name = "recycled-aquilo-fuel",
	energy_required = 20,
	enabled = false,
	category = "cryogenics",
    ingredients =
    {
	  {type = "item", name = "lithium", amount = 1},
      {type = "item", name = 'rocket-fuel', amount = 20},
    },
	results = {{type="item", name="recycled-fuel-pod", amount=20}}
}

-- Tech --

-- Create the technology for the recycled rocket
local recycledAquiloRocketTech = {
	type = "technology",
	name = "recycled-mag-rocket-ship",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-tech-gleba.png",
	icon_size = 256,
	essential = false,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "recycled-aquilo-fuel"
	  }
	},
	prerequisites =
	{
	  "rocket-silo",
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
		{"space-science-pack", 1}
	  },
	  time = 60
	}
}

data:extend({
	recycledAquiloFuelRecipe,

	recycledAquiloRocketTech,
})

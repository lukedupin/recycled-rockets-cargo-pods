local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



-- Bio fuel --

-- Create the recycled rocket pod
local recycledBioFuelRecipe = {
	type = "recipe",
	name = "recycled-bio-fuel",
	energy_required = 40,
	enabled = false,
	category = "organic",
    ingredients =
    {
	  {type = "item", name = "pentapod-egg", amount = 1},
	  {type = "item", name = "iron-bacteria", amount = 1},
      {type = "item", name = 'rocket-fuel', amount = 20},
    },
	results = {{type="item", name="recycled-fuel-pod", amount=20}}
}

-- Tech --

-- Create the technology for the recycled rocket
local recycledBioRocketTech = {
	type = "technology",
	name = "recycled-mag-rocket-ship",
	icon = "__recycled-rockets-cargo-pods__/graphics/rocket-silo-tech-gleba.png",
	icon_size = 256,
	essential = false,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "recycled-bio-fuel"
	  }
	},
	prerequisites =
	{
	  "rocket-silo",
	  "planet-discovery-gleba"
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
	    {"agricultural-science-pack", 1},
		{"space-science-pack", 1}
	  },
	  time = 60
	}
}

data:extend({
	recycledBioFuelRecipe,

	recycledBioRocketTech,
})

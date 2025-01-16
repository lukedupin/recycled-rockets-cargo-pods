local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")



-- Bio fuel --

-- Create the recycled rocket pod
local recycledBioFuelRecipe = {
	type = "recipe",
	name = "recycled-bio-fuel",
	energy_required = 15,
	enabled = false,
	category = "organic",
	order = "c[rocket-silo]",
    ingredients =
    {
	  {type = "item", name = "pentapod-egg", amount = 1},
	  {type = "item", name = "iron-bacteria", amount = 1},
      {type = "item", name = 'rocket-fuel', amount = 10},
    },
	surface_conditions = {
        {
          max = 20,
          min = 20,
          property = "gravity"
        }
    },
	results = {{type="item", name="recycled-fuel-pod", amount=35}}
}

-- Tech --

-- Create the technology for the recycled rocket
local recycledBioRocketTech = {
	type = "technology",
	name = "recycled-bio-fuel",
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
	  "nuclear-rocket-ship",
	  "planet-discovery-gleba"
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
	recycledBioFuelRecipe,

	recycledBioRocketTech,
})

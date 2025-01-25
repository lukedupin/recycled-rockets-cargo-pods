# ModPage

https://mods.factorio.com/mod/recycled-rockets-cargo-pods

# What is this?

Adds CargoPods and Recycled Rockets to your factory with 2 new silos and specialized advanced rocket fuel themed for each planet. 

# YouTube video walkthrough

https://youtu.be/Umxu7Qk08Hk

# Changes at a glance
* SpacePlatforms now require CargoPods to drop resources down to planets. Each rocket (even stock) will deposit 1 CargoPod which can be used to drop items back down to the planet.
* CargoPods are created as units and reused
* CargoPods stay with the spaceship they were sent to, until materials are dropped down to the planet.
* RocketBoosters are created as units and reused
* RocketBoosters return immediately after launching.
* BasicRocket fuel can be used
* Optionally, each planet has its own uniquely themed advanced fuel type.

# Details on CargoPods

All rockets now include reusable CargoPods. CargoPods are built in assemblers with: 5x processing units, 5x low density and 1x thruster.

These requirements were chosen because the CargoPod looks about 5% of the size of a rocket, and there is clearly 1 rocket thruster.

To launch standard rockets, now you build 1x CargoPod, insert it into your rocket along with 5x Thrusters, 50x blue, 100x low density and 100x rocket fuel. All of these items are lost because the rocket isn't recyclable (excluding the CargoPod).

When a CargoPod lands on a platform, 1 CargoPod is added to your SpaceStation. When dropping items back to the planet, 1 CargoPod is removed. When a CargoPod lands at a landing platform on the planet, 1 CargoPod is added to your landing platform.

If no CargoPod is insider your SpaceStation, the drop will fail, resources will remain on the SpaceStation and an alert will be generated to the player.

If, for example, you have 20 CargoPods, and attempt to drop 20, 1 CargoPod will be used to drop down 19 CargoPods. A total of 20 will arrive on your planet.

If you drop a CargoPod down to planet that does't have a landing platform, the CargoPod will be destroyed.

# Details on Rocket booster stages

Rocket boosters are now made outside of the silo. Using 100 processing units, low density structure and 15x thrusters, a booster is created. The booster is loaded into a silo, and then fueled for launch (like in real-life).

Rocket boosters return after launching a payload immediately after encountering their target space platform. The rocket boosters uses its remaining fuel to land at your space port, at which point you collect it, and reload it into the silo.

# Tech Tree

### Basic recycled rockets

Gives you access to the Basic rocket silo, cargo pods and rocket boosters. The basic rocket silo creates launch ready rockets by using 100x rocket fuel, 1 cargo pod and 1 rocket booster. When this is researched, you will need to have cargo pods in your spaceship to drop resources down to the planet.

### Nuclear Advanced rocket fuel for Navis

Using nuclear fuel, 40x rocket fuel and a few low density structures to create a nuclear rocket which super heats the fuel, throwing out the propellant at a massively high rate of speed.

### Steam Calcite Tungsten Advanced rocket fuel for Vulcanus

Using Steam, Calcite and Tungsten foam to create a steam expansion reaction, throwing the tungsten bits out at a high rate of speed. The values for this fuel mirrors the steam expansion requirements.

### Electromagnetic Advanced rocket fuel for Fulgora

Leveraging Fulgora's heavy oil oceans to make solid fuel combined with superconductors and iron, a rail gun like system is created to launch rockets.

### Biological Advanced rocket fuel for Gleba

Leveraging the insane energy potentials from pentapod eggs and some rocket fuel, a biologically based rocket fuel is created.

### Fusion Advanced rocket fuel for Aquilo

Taking some rocket fuel, and hot/cold fluoroketone's you create fusion based fuel that is highly efficient and easier to create on Auilo.

# Made with love (The why)

Factorio is an amazing game and I love space age. I found that I wanted to have a bit more stream-lining for my rocket logistic network. Thus the recyclable rockets.

I wanted to have a bit more realism around "Where are these pods coming from?" I also didn't like the idea of creating a iron/ice SpacePlatform that could drop infinite resources from space. This small change of making CargoPods a reusable, easy to create but finite item to manage filled a mental gap for me.

If anyone wants to help out with art, find bugs, make the user experience better, please do. This mod is for the community.

# What could be better

Art work for the rocket silos.

I don't like the implementation of the rocket booster return. If you care to have details, ask me, but if someone wants to make a better rocket booster return stage experience, I'd love the pull request.
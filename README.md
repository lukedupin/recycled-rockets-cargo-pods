# What is this?

Adds CargoPods and Recycled Rockets to your factory and 4 new tech. tree unlockables! This mod is created with a desire to make reasonable, logical and balanced changes that increases the immersion of your factory.

# Changes at a glance
* SpacePlatforms now require CargoPods to drop resources down to planets. Each rocket (even stock) will deposit 1 CargoPod which can be used to drop items back down to the planet.
* The standard rocket silo still costs the ~same total items (100 blue, 100 frame, 100 fuel). However, now 50 of the blue circuits are allocated to 5 thrusters which are thrown away (not reusable).
* Vulcans recyclable rocket only require fuel (almost).
* Fulgora brings Anti-gravity magnetic fuel which drastically reduces the fuel requirements.

# Play your way

If you just want to add CargoPods and keep the standard rockets, no problem. Ignore the recycled rocket tech entries and just research CargoPods. CargoPods are still reusable, even though your launch stage rocket wont be.

# Details on CargoPods

All rockets now include reusable CargoPods. CargoPods are built in assemblers with: 5x processing units, 5x low density and 1x thruster.

These requirements were chosen because the CargoPod looks about 5% of the size of a rocket, and there is clearly 1 rocket thruster.

To launch standard rockets, now you build 1x CargoPod, insert it into your rocket along with 5x Thrusters, 50x blue, 100x low density and 100x rocket fuel. All of these items are lost because the rocket isn't recyclable (excluding the CargoPod).

When a CargoPod lands on a platform, 1 CargoPod is added to your SpaceStation. When dropping items back to the planet, 1 CargoPod is removed. When a CargoPod lands at a landing platform on the planet, 1 CargoPod is added to your landing platform.

If no CargoPod is insider your SpaceStation, the drop will fail, resources will remain on the SpaceStation and an alert will be generated to the player.

If, for example, you have 20 CargoPods, and attempt to drop 20, 1 CargoPod will be used to drop down 19 CargoPods. A total of 20 will arrive on your planet.

If you drop a CargoPod down to planet that does't have a landing platform, the CargoPod will be destroyed.

# Details on Standard Rocket Silos

Rocket Silos will play roughly the same. Keep in mind, existing RocketSilos made before this mod will stay untouched. If you change them in any way, their behavior will be updated to reflect this mod's recipes.

Instead of 100x rocket parts, there is now only 1x made per rocket. Creating a rocket now **costs: 1x CargoPod, 5x thrusters, 50x processing units, 100x low density, and 100x rocket fuel.**

If you only want to play like this, basically stock but with CargoPods, everything will work as expected.

# Details on Recycled Rockets

Creates a new rocket silo, the recycled rocket. The cost of this silo represents the 2x rockets you're going to build which will be reused. After an expensive initial investment, the rockets only consume fuel, a cargo pod, and one repair unit.

Recycled Rocket Silos **cost: 1x rocket-silo, 10x thrusters (5x for 2 rockets), 50x processing units, 100x low density and 100x tungsten.** These rockets use the much lighter weight tungsten material, which allows them to be more fuel efficient.

To launch of one these rockets, they require: **1x CargoPod, 1x tungsten plate, 80x rocket fuel (20x less than default).**

# Details on Recycled Mag Rockets

Creates a new and final rocket silo, the eltrocmagnetic anti-gravity silo. The cost of this silo represents the retro-fitting of the recycled rocket. 

Recycled Mag Rockets **Cost: 1x recycled-rocket-silo, 50x holmium plate and 50x superconductors.**

Launching one of these rockets requires: **1x CargoPod, 20x steel plate, 5x recycled-mag-fuel**. These rockets require a feric metal (steel) for the reaction to function.

Magnetic fuel is created exclusively inside Eltrocmagnetic assemblers. There is no requirement for the fuel to be created on Fuglora, but it is easier. The fuel **cost: 1x calcite (start the reaction), 1x superconductor, 42x rocket fuel.** 

The fuel has the odd property of being very light, 100x Mag fuel only weighs 1Ton. This makes it an ideal candidate for shipping the fuel from Fulgora to all of your other factories.

# Details on Recycled Mag Heavy Oil Fuel

Creates a new recipe for creating MagFuel which is very easy to do on Fuglora, and unreasonable anywhere else.

The updated **cost: 1x calcite, 1x holmium plate, 1x copper plate, 2048x heavy-oil, 10x water.**

The resulting fuel is identical. This roughly combines all the sub items into their raw components, in a way that is very convenient for people with an ocean of oil next to them.

# Tech Tree

### CargoPods

**Cost: 200x3 automation, logistics and chemical science.**

CargoPods are a standalone tech. This is implemented this way since many bases will already have silos researched. Compatible with existing bases.

### Recycled Rockets

**Cost: 1000x automation, logistics, chemical science, utility, space and metallurgic.*

Unlocked when you land on Vulcanus. This adds a new rocket silo, and recyclable rockets.

### Recycled Mag Rockets

**Cost: 1000x automation, logistics, chemical science, utility, space and  eltromagnetic.**

Unlocked when you land on Fulgora and have unlocked MK1 recycled rockets. This adds a new fuel type that can only be created in an Electromagnetic plant. The fuel is light (anti gravity), easy to send to other planets, but a bit resource intensive. This fuel could reasonable be created on any planet.

### Recycled Mag Heavy Oil Rocket Fuel

**Cost: 500x automation, logistics, chemical science, utility, space and  eltromagnetic.**

Enable a new recipe for mag fuel. Its much easier to make on Fulgora, but unrealistic to create anywhere without heavy oil oceans.

# Made with love (The why)

Factorio is an amazing game and I love space age. I found that I wanted to have a bit more stream-lining for my rocket logistic network. Thus the recyclable rockets.

I wanted to have a bit more realism around "Where are these pods coming from?" I also didn't like the idea of creating a iron/ice SpacePlatform that could drop infinite resources from space. This small change of making CargoPods a reusable, easy to create but finite item to manage filled a mental gap for me.

If anyone wants to help out with art, find bugs, make the user experience better, please do. This mod is for the community.
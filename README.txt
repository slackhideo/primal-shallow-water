### Primal Shallow Water ###
by slackhideo

Enhancements for the shallow water drinking from Primal Needs.

To use this mod, you MUST HAVE Primal Needs [1] (or AGM Primal Needs [2])
installed. This mod was tested with Primal Needs version 1.15.1 and AGM Primal
Needs version 4.1. If you have an older version, please update it first.


# Features #

1. Drink from really shallow water.
2. Bottle shallow water to drink later.
3. Stop the animations for the above actions gracefully.
4. Purify bottled shallow water to remove toxicity.
5. Drink and bottle water while swimming.


# More Details #

For more details, please visit the mod's page at Nexus:
https://www.nexusmods.com/witcher3/mods/7071
or the GitHub repository:
https://github.com/slackhideo/primal-shallow-water


# Installation #

I split the installation in two parts. Please, read them carefully.

== Part 1: Copying the mod files ==

To copy the mod files to your game folder, you have basically two options:

MANUAL METHOD: Extract the contents of the 7z file. Then copy (or cut) the
"modPrimalShallowWater" folder and paste it into the "mods" folder inside your
game's folder structure. It should be in the same folder as the
"modPrimalNeeds" folder. Also, copy (or cut) the "dlcPrimalShallowWater" folder
and paste it into the "dlc" folder inside your game's folder structure.

-OR-

AUTOMATIC METHOD: Use The Witcher 3 Mod Manager [3]. I did not test using
Nexus' Vortex.

== Part 2: Merging the mod files ==

After copying the mod files, you MUST merge them with other mods,
especially with Primal Needs. Use the Script Merger [4] for this.

The next steps are a bit different depending on the version you are installing.
Follow only the steps in 2.A (regular Primal Needs) or 2.B (AGM Primal Needs).

|| Part 2.A: Regular Primal Needs version ||

You should be presented with the following unsolved conflicts:

- "scripts/game/components/inventoryComponent.ws": Choose the version from
  "modPrimalShallowWater". It will be in the C panel, probably.
- "scripts/game/player/playerInput.ws": Idem.
- "scripts/local/PNAnimations.ws": From Script Merger's menus, select
  "Merge" -> "Choose B for All Unsolved Conflicts", assuming 
  "modPrimalShallowWater" is being displayed in the B panel. If not, replace
  "B" with the appropriate letter*.
- "scripts/local/PNData.ws": Idem.
- "scripts/local/PNFood.ws": Idem.
- "scripts/local/PNThirst.ws": Idem.

* This instruction assumes that you have unmodified Primal Needs' scripts.
If you have a mod that changed them or you have made some change yourself,
then you should go through each conflict, solving them one by one lest you
break the relevant mods.

I made a video-tutorial on how to merge the mod files. You can watch it here:
https://youtu.be/S6ifNODUXo4

|| Part 2.B: AGM Primal Needs version ||

You should be presented with the following unsolved conflicts:

- "scripts/game/components/inventoryComponent.ws": From Script Merger's menus,
  select "Merge" -> "Choose C Everywhere", assuming "modPrimalShallowWater"
  is being displayed in the C panel. If not, replace "C" with the appropriate
  letter*.
- "scripts/game/player/playerInput.ws": Choose the version from
  "modPrimalShallowWater". It will be in the C panel, probably.
- "scripts/local/PNAnimations.ws": From Script Merger's menus, select
  "Merge" -> "Choose B for All Unsolved Conflicts", assuming
  "modPrimalShallowWater" is being displayed in the B panel. If not, replace
  "B" with the appropriate letter*.
- "scripts/local/PNData.ws": Idem.
- "scripts/local/PNFood.ws": Idem.
- "scripts/local/PNThirst.ws": Idem.

* This instruction assumes that you have unmodified AGM Primal Needs' scripts.
If you have a mod that changed them or you have made some change yourself,
then you should merge the file manually.


# Uninstallation #

If you installed manually, remove the "modPrimalShallowWater" folder from your
"mods" folder and remove the "dlcPrimalShallowWater" folder from your "dlc"
folder. Then, run Script Merger to update your merged files.

If you installed with The Witcher 3 Mod Manager, use it to remove the mod and
run Script Merger to update your merged files.


# Acknowledgements #

Standing on the shoulders of these giants:

* CD PROJEKT RED for this great game series.
* stefan3372 [5] for the amazing Primal Needs.
* wghost81 [6] for permitting me to use her logic to hold a button to perform
a different action. Based on the superb Friendly HUD [7].
* Aeltoth [8] for helping me in processing toxicity.
* MerseyRockoff [9] and paulr0013 [10] for helping me find help.
* AnotherSymbiote [11] for help with Script Merger.
* Haldar1248 [12] for the AGM Primal Needs.


# Reference Links #

 [1] https://www.nexusmods.com/witcher3/mods/2547
 [2] https://www.nexusmods.com/witcher3/mods/4542
 [3] https://www.nexusmods.com/witcher3/mods/2678
 [4] https://www.nexusmods.com/witcher3/mods/484
 [5] https://www.nexusmods.com/witcher3/users/42512255
 [6] https://www.nexusmods.com/witcher3/users/905332
 [7] https://www.nexusmods.com/witcher3/mods/365
 [8] https://www.nexusmods.com/witcher3/users/89683013
 [9] https://www.nexusmods.com/witcher3/users/56064207
[10] https://www.nexusmods.com/witcher3/users/92248218
[11] https://www.nexusmods.com/witcher3/users/26045039
[12] https://www.nexusmods.com/witcher3/users/571271

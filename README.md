# Primal Shallow Water

This is a mod for The Witcher 3: Wild Hunt containing my enhancements for the
shallow water drinking from stefan3372's Primal Needs.

To use this mod, you **must have
[Primal Needs](https://www.nexusmods.com/witcher3/mods/2547)
installed**. This mod was tested with Primal Needs version 1.15.1. If you have
an older version, please update it first.

## Features Rundown

1. Drink from really shallow water.
1. Bottle shallow water to drink later.
1. Stop the animations for the above actions gracefully.
1. Purify bottled shallow water to remove toxicity.

## Features Explanation

1. In the original Primal Needs, you can only drink "river" (or ocean, lake,
   etc.) water from places where the game considers to be "shallow water". But
   that is not quite shallow, actually. It starts at about Geralt's waist level
   and end when he starts swimming.

   This mod relax this condition and makes it possible to drink from really
   shallow water. In fact, as long as Geralt is in water (and not swimming), he
   can drink water. This new possibility comes with a different animation as
   well, to reflect the lower water level.

1. Now you can fill up to 10 bottles using "river" water to drink later. As is
   the case when drinking directly, this water is polluted due to corpses being
   present in these water bodies in the context of the Third Nilfgaardian War.
   This means that drinking it will increase Geralt's toxicity level.

   The amount of toxicity per bottle is the same value from each sip when
   drinking directly from the "rivers" (thanks, Aeltoth!). This value is
   configurable in Primal Needs' settings menu. The amount of thirst
   replenishment per bottle is also the same value from each sip, and also
   configurable.

   To fill up the bottles, press and hold the button to drink from shallow
   water (thanks, wghost81!). You can do it under the same conditions of the
   previous bullet (i.e., in game's shallow water or in really shallow water).

1. In the original Primal Needs, the only way to stop drinking (as far as I
   know) is by pressing the jump button, which will abruptly interrupt the
   action. This behaviour is kept, but now you can also stop drinking or
   bottling water by pressing the drink button (i.e., the same button you
   pressed to start the action). This will stop the animation after the current
   loop iteration is finished, and correctly play the stopping animation.

1. A new recipe was created to allow boiling (and thus, magically purifying) the
   bottled polluted water to remove toxicity. The resulting item is Canteen
   Water, the same one from the original Primal Needs.

   You can buy the recipe only from the Crow's Perch's trader, to be consistent
   with [What's For Dinner](https://www.nexusmods.com/witcher3/mods/488),
   included in Primal Needs.

## Acknowledgements

* [CD PROJEKT RED](https://cdprojektred.com) for this great game series.
* [stefan3372](https://www.nexusmods.com/witcher3/users/42512255) for the
amazing Primal Needs.
* [wghost81](https://www.nexusmods.com/witcher3/users/905332) for permitting me
to use her logic to hold a button to perform a different action. Based on the
superb [Friendly HUD](https://www.nexusmods.com/witcher3/mods/365).
* [Aeltoth](https://www.nexusmods.com/witcher3/users/89683013) for helping me in
processing toxicity.
* [MerseyRockoff](https://www.nexusmods.com/witcher3/users/56064207) and
[paulr0013](https://www.nexusmods.com/witcher3/users/92248218) for helping me
find help.

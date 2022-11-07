# Primal Shallow Water

This is a mod for The Witcher 3: Wild Hunt containing my enhancements for the
shallow water drinking from stefan3372's Primal Needs.

To use this mod, you **must have
[Primal Needs](https://www.nexusmods.com/witcher3/mods/2547)
installed**. This mod was tested with Primal Needs version **1.15.1**. If you
have an older version, please update it first.

## Features Rundown

1. Drink from really shallow water.
1. Bottle shallow water to drink later.
1. Stop the animations for the above actions gracefully.
1. Purify bottled shallow water to remove toxicity.
1. [Extra] Drink and bottle ~~shallow~~ water while swimming.

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
   drinking directly from the "rivers" (thanks,
   [Aeltoth](https://www.nexusmods.com/witcher3/users/89683013)!). This value
   is configurable in Primal Needs' settings menu. The amount of thirst
   replenishment per bottle is also the same value from each sip, and also
   configurable.

   To fill up the bottles, press and hold the button to drink from shallow
   water (thanks, [wghost81](https://www.nexusmods.com/witcher3/users/905332)!).
   You can do it under the same conditions of the previous bullet (i.e., in
   game's shallow water or in really shallow water).

1. In the original Primal Needs, the only way to stop drinking (as far as I
   know) is by pressing the jump button, which will abruptly interrupt the
   action. This behaviour is kept, but now you can also stop drinking or
   bottling water by pressing the drink button (i.e., the same button you
   pressed to start the action). This will stop the animation after the current
   loop iteration is finished, and correctly play the stopping animation.

   Since, depending on the animation frame when you press the button, it could
   take some seconds for it to stop, one could think the stopping button didn't
   work. For this reason, I added a feedback message ("Stopping...") in the
   game's HUD. If you wish to play without this message, comment out the lines
   520 of `/content/scripts/local/PNAnimations.ws` and 65 of
   `/content/scripts/local/PSWShallowWater.ws`. The command to print the
   message is this:

   ```
   PNHudNotify(GetLocStringByKeyExt("psw_anim_stopping"));
   ```

1. A new recipe was created to allow boiling (and thus, magically purifying) the
   bottled polluted water to remove toxicity. The resulting item is Canteen
   Water, the same one from the original Primal Needs.

   You can buy the recipe only from the Crow's Perch's trader, to be consistent
   with [What's For Dinner](https://www.nexusmods.com/witcher3/mods/488),
   included in Primal Needs.

1. [Extra] Okay, this one is definitely not "shallow water", but hear me out.
   I've always found strange that we can't drink from "rivers" when swimming.
   Well, while making this mod I might have stumbled upon the answer: we cannot
   play those nice animations while swimming. But that didn't prevent me from
   adding the ability to drink and bottle ~~shallow~~ water while swimming.

   To make up for the lack of animations, I used the pseudo-animation of trying
   to dive when the water level is too low (you will understand when you see).
   This pseudo-animation plays when you start the action and also when it
   finishes or you ask nicely for it to stop (see feature number 3), to let you
   know it finished. While drinking or bottling ~~shallow~~ water, you cannot
   move (except for changing direction, for magical reasons), as is the case
   when drinking or bottling shallow water with proper animations.

## New Behaviour

I strived to keep the behaviour of other parts of Primal Needs untouched, but
I found two bugs that detract from our cherished immersion. The first one is
that you cannot eat or drink when under puking effect (intended behaviour) but
the animations play out the same. The second one is that you can drink shallow
water even when under puking effect.

So I tried to fix these bugs to increse immersion. Now, if you try to eat or
drink ("river" water included), Geralt will puke and the relevant message from
Primal Needs will appear in the game's HUD. The rationale for the puking is
that Geralt is nauseated when under puking effect, so if he tries to eat or
drink anything in this condition, he will feel the urge to puke again.

## Changed Files

<details>
<summary>List of changed files</summary>
From vanilla game:

```
scripts/game/components/inventoryComponent.ws
scripts/game/player/states/swimming.ws
scripts/game/player/playerInput.ws
scripts/game/player/r4Player.ws
```

From Primal Needs:

```
scripts/local/PNAnimations.ws
scripts/local/PNData.ws
scripts/local/PNFood.ws
scripts/local/PNThirst.ws
```

</details>

## Installation

I split the installation in two parts. Please, read them carefully.

### Part 1: Copying the mod files

To copy the mod files to your game folder, you have basically two options:

**Manual method**: Extract the contents of the 7z file. Then copy (or cut) the
`modPrimalShallowWater` folder and paste it into the `mods` folder inside your
game's folder structure. It should be in the same folder as the
`modPrimalNeeds` folder. Also, copy (or cut) the `dlcprimalshallowwater` folder
and paste it into the `dlc` folder inside your game's folder structure.

**OR**

**Automatic method**: Use [The Witcher 3 Mod
Manager](https://www.nexusmods.com/witcher3/mods/2678). I did not test using
Nexus' Vortex.

### Part 2: Merging the mod files

After copying the mod files, you **must** merge them with other mods,
especially with Primal Needs. Use the [Script
Merger](https://www.nexusmods.com/witcher3/mods/484) for this.

You should be presented with the following unsolved conflicts:

* `scripts/game/components/inventoryComponent.ws`: Choose the version from
  `modPrimalShallowWater`. It will be in the C panel, probably.
* `scripts/game/player/playerInput.ws`: Idem.
* `scripts/local/PNAnimations.ws`: From Script Merger's menus, select
  **Merge** -> **Choose B for All Unsolved Conflicts**, assuming 
  `modPrimalShallowWater` is being displayed in the B panel. If not, replace
  "B" with the appropriate letter.
* `scripts/local/PNData.ws`: Idem.
* `scripts/local/PNFood.ws`: Idem.
* `scripts/local/PNThirst.ws`: Idem.

## Uninstallation

If you installed manually, remove the `modPrimalShallowWater` folder from your
`mods` folder and remove the `dlcprimalshallowwater` folder from your `dlc`
folder. Then, run Script Merger to update your merged files.

If you installed with The Witcher 3 Mod Manager, use it to remove the mod and
run Script Merger to update your merged files.

## Packing the Mod Up

You can use the prepacked file from the "Releases" section to install it into
your game. But if you want to pack it yourself, then read on.

You will need the following tools:

* [wcc_lite](https://www.nexusmods.com/witcher3/news/12625) by CD PROJEKT RED,
  for packing XML files into `.bundle` files.
* [w3strings encoder](https://www.nexusmods.com/witcher3/mods/1055) by
  [rmemr](https://www.nexusmods.com/witcher3/users/29653850), for encoding CSV
  files into `.w3strings` files.

Open `modPrimalShallowWater/bundle.bat` with a text editor and edit lines 3, 4,
and 5 according to your environment.

* `wcc_lite_path` is the path to the folder containing wcc_lite's executable.
* `source` is the input path to the `/content/bundles` folder of this mod.
* `outdir` is the output path of the `.bundle` file.

Then, open `modPrimalShallowWater/strings.bat` with a text editor and edit
lines 3 and 4 according to your environment.

* `w3strings_path` is the path to the folder containing w3strings's executable.
* `input_dir` is the input path to the `localization` folder of this mod.

After editing the batch files, execute them both. And proceed to the
installation, as per the appropriate section. Before installing this mod, you
may want to change the encoding of the scripts to UTF-16. You can use the
`modPrimalShallowWater/convert_encoding.sh` shell script to do so, by simply
executing it.

## Mod Page on Nexus

[https://www.nexusmods.com/witcher3/mods/7071](https://www.nexusmods.com/witcher3/mods/7071)

## Acknowledgements

Standing on the shoulders of these giants:

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

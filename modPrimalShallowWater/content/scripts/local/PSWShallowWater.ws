/******************************************************************************/
/** 	Primal Shallow Water for THE WITCHER 3: Wild Hunt
/** 	© 2022 slackhideo
/** 	Patch for the awesome Primal Needs by stefan3372
/**
/**		THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/******************************************************************************/

/** Check if the player is in water */
function PSWIsInWater() : bool
{
	var pos	: Vector;
	var isInWater : bool;

	pos = thePlayer.GetWorldPosition();

	return pos.Z <= theGame.GetWorld().GetWaterLevel(pos, true);
}

/** Check if the player is drinking or bottling shallow water */
function PSWIsShallowWaterShenanigans() : bool
{
	return (thePlayer.PNanimType == "shallow")
	    || (thePlayer.PNanimType == "shallower")
	    || (thePlayer.PNanimType == "bottle1")
	    || (thePlayer.PNanimType == "bottle2");
}

/** Entry point of bottling shallow water */
function PSWBottleShallowWater()
{
	if (PNThirstOn())
	{
		if (PSWIsInWater())
		{
			PSWBottleShallowWaterAnim();
		}
		else
		{
			PNHudNotify(GetLocStringByKeyExt("HUDmessage_NoShallowWaterToDrink"));
		}
	}
}

/** Set up the animation for bottling shallow water */
function PSWBottleShallowWaterAnim()
{
	if (thePlayer.IsInShallowWater() && PNAnimationNotBeingPerformed())
	{
		PSWSetUpBottle();
		thePlayer.PNSetAnim("bottle1");
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
	else if (thePlayer.IsInWaterTrigger() && PNAnimationNotBeingPerformed())
	{
		PSWSetUpBottle();
		thePlayer.PNSetAnim("bottle2");
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
	/* Stop drinking or bottling shallow water */
	else if (PSWIsShallowWaterShenanigans())
	{
		thePlayer.PNSetLoop(false);
	}
}

/** Set up bottle on left hand */
function PSWSetUpBottle()
{
	var ids : array<SItemUniqueId>;

	thePlayer.SetBehaviorVariable('SelectedItemL', (int)UI_Torch, true);
	ids = thePlayer.inv.AddAnItem('mh107_czart_lure', 1, true);
	thePlayer.inv.MountItem(ids[0], true);
	thePlayer.RaiseEvent('ItemUseL');
}

/** Put the bottle away after using it */
function PSWPutAwayBottle()
{
	var ids : array<SItemUniqueId>;
	var theOne : SItemUniqueId;

	thePlayer.RaiseEvent('ItemUseL');
	ids = thePlayer.inv.GetItemsByName('mh107_czart_lure');
	theOne = ids[ids.Size() - 1];
	thePlayer.inv.UnmountItem(theOne, true);
	thePlayer.inv.RemoveItem(theOne, 1);
	thePlayer.SetBehaviorVariable('SelectedItemL', (int)UI_None, true);
}

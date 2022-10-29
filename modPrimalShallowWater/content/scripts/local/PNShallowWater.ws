/******************************************************************************/
/** 	Primal Shallow Water for THE WITCHER 3: Wild Hunt
/** 	© 2022 slackhideo
/** 	Patch for the awesome Primal Needs by stefan3372
/**
/**		THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/******************************************************************************/

function PNBottleShallowWater()
{
	if (PNThirstOn())
	{
		if (PNIsInWater())
		{
			PNHudNotify("yay");
			PNBottleShallowWaterAnim();
		}
		else
		{
			PNHudNotify(GetLocStringByKeyExt("HUDmessage_NoShallowWaterToDrink"));
		}
	}
}

function PNIsInWater() : bool
{
	var pos	: Vector;
	var isInWater : bool;

	pos = thePlayer.GetWorldPosition();

	return pos.Z <= theGame.GetWorld().GetWaterLevel(pos, true);
}

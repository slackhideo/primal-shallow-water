/******************************************************************************/
/** 	Primal Shallow Water for THE WITCHER 3: Wild Hunt
/** 	© 2022 slackhideo
/** 	Patch for the awesome Primal Needs by stefan3372
/**
/**		THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/******************************************************************************/

function PNRiseThirst( diff : int ) {
	if ( diff > 1 ) {
		if (!PNPeekMeditationFlag()) {
			if (diff / PNGetThirstCounter() >= PNGetThirstMaxFastTravel()) {
				diff = PNGetThirstMaxFastTravel() * PNGetThirstCounter();
			}
		}
		PNDrink( RoundMath(((float) diff / (float) PNGetThirstCounter()) * ( -1 ) * PNGetThirstMeditationMult()));
	} else {
		PNDecThirstCnt( PNGetThirstInc() );
	}
}

function PNGetThirstInc() : float {
	var combatadd : float;
	var healthadd : float;
	var totaladd : float;
	var staminaadd : float;
	var adrenalineadd : float;
	var toxadd : float;
	
	combatadd = 0;
	if ( thePlayer.IsInCombat() ) {
		combatadd = PNGetThirstCombatAdd();
	}
	healthadd = (1 - (thePlayer.GetStat(BCS_Vitality) / thePlayer.GetStatMax(BCS_Vitality))) * PNGetThirstVitalityAdd();
	staminaadd = (1 - (thePlayer.GetStat(BCS_Stamina) / thePlayer.GetStatMax(BCS_Stamina))) * PNGetThirstStaminaAdd();
	if (!PNIsPatch())
		adrenalineadd = (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus)) * PNGetThirstAdrenalineAdd();
	else 
		adrenalineadd = (1 - (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus))) * PNGetThirstAdrenalineAdd() * (-1.f);
	toxadd = (thePlayer.GetStat(BCS_Toxicity) / thePlayer.GetStatMax(BCS_Toxicity)) * PNGetThirstToxAdd();
	totaladd = 1 + combatadd + healthadd + staminaadd - adrenalineadd - toxadd;
	if (PNPukeAnimOn()) if (thePlayer.PukeEffect) totaladd += 1; 
	if (totaladd < 0) { totaladd = 0; } 
	return totaladd;
}

function PNDrink( drink : int ) {
	var over : int;
	if ( PNThirstOn() ) {
		over = PNGetThirst() - drink;
		if ( over < 0 ) {
			if (PNGetThirst() < PNGetPukeThirstCap() && PNPukeAnimOn()) thePlayer.AddTimer('PNPuke', RandRangeF(30.0, 10.0));
			over = RoundMath( (float)over * PNGetOverDrinkMult() );
			PNSetFatigue( PNGetFatigue() - over );
			if (PNPeeOn() && drink > 0) PNRisePee(PNPeeRisePerOverdrink());
		} else {
			if (PNPeeOn() && drink > 0) PNRisePee(PNPeeRisePerDrink());
		}
		PNSetThirst( PNGetThirst() - drink );
		PNResetThirstCnt();
	}
}

function PNDrinkShallow( drink : int ) {
	var over : int ;
	if ( PNThirstOn() ) {
		thePlayer.abilityManager.GainStat( BCS_Toxicity, PNGetShallowTox() );
		PNSetThirst( PNGetThirst() - drink );
		PNResetThirstCnt();
	}
}

function PNDrinkShallowWater() {
	var pos	: Vector;
	var isInWater : bool;

	pos = thePlayer.GetWorldPosition();
	isInWater = pos.Z <= theGame.GetWorld().GetWaterLevel(pos, true);

	if ( PNThirstOn() ) {
		if ( isInWater ) {
			PNShallowAnim();
		} else {
			PNHudNotify( GetLocStringByKeyExt("HUDmessage_NoShallowWaterToDrink") );
		}
	}
}

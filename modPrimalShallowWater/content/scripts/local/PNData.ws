
// --- Getters and setters for wrapper variables --- \\

// ==========
//   Hunger
// ==========

function PNHungerOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuntoggle'); }
function PNGetHungerCounter() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuncounter')); }
function PNGetHungerDamage() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhundamage')); }
function PNGetHungerLevel() : int { return PNGetAttributeValue( thePlayer.GetAttributeValue( 'hunger' ) ); }
function PNGetHungerCombatAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuncombat')); }
function PNGetHungerVitalityAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunvital')); }
function PNGetHungerStaminaAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunstamina')); }
function PNGetHungerAdrenalineAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunadrenaline')); }
function PNGetHungerToxAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuntox')); }
function PNGetHungerMaxFastTravel() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunfast')); }
function PNGetHungerMeditationMult() : float { var med : bool; med = PNPeekMeditationFlag(); if (med) { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunmed')); } else { return 1; } }
function PNGetFeedLevel( _inv : CInventoryComponent, itemId : SItemUniqueId) : int { return RoundMath((float)PNGetItemAttributeValue(_inv.GetItemAttributeValue( itemId, 'feed' )) * PNGetFeedMult(_inv, itemId)); }
function PNGetFeedMult( _inv : CInventoryComponent, itemId : SItemUniqueId) : float {
	if (_inv.ItemHasAbility(itemId, 'feed_1')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNfeed1')); 
	} else if (_inv.ItemHasAbility(itemId, 'feed_2')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNfeed2')); 
	} else if (_inv.ItemHasAbility(itemId, 'feed_3')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNfeed3')); 
	} else if (_inv.ItemHasAbility(itemId, 'feed_4')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNfeed4')); 
	}
	return 1.0 ;
}

// ==========
//   Thirst
// ==========

function PNThirstOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrtoggle'); }
function PNGetThirstCounter() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrcounter')); }
function PNGetThirstCombatAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrcombat')); }
function PNGetThirstVitalityAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrvital')); }
function PNGetThirstStaminaAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrstamina')); }
function PNGetThirstAdrenalineAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthradrenaline')); }
function PNGetThirstToxAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrtox')); }
function PNGetThirstMaxFastTravel() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrfast')); } 
function PNGetThirstLevel() : int { return PNGetAttributeValue( thePlayer.GetAttributeValue( 'thirst' ) ); }
function PNGetThirstStaminaMult() : float { return (StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrstaminamult')) / 100) + 1.f; }
function PNGetThirstMeditationMult() : float { var med : bool; med = PNPeekMeditationFlag(); if (med) { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrmed')); } else { return 1; } }
function PNGetShallowThirstRise() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrshallow')); }
function PNGetShallowPukeLevel() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrshallowpuke')); }
function PNGetShallowTox() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrshallowtox')); }
function PNGetDrinkLevel( _inv : CInventoryComponent, itemId : SItemUniqueId) : int {
	//modPrimalShallowWater BEGIN
	if (_inv.GetItemName(itemId) == 'polluted_water')
	{
		return PNGetShallowThirstRise();
	}
	else
	//modPrimalShallowWater END
	return RoundMath((float)PNGetItemAttributeValue(_inv.GetItemAttributeValue( itemId, 'drink' )) * PNGetDrinkMult(_inv, itemId));
}
function PNGetDrinkMult( _inv : CInventoryComponent, itemId : SItemUniqueId ) : float {
	if (_inv.ItemHasAbility(itemId, 'drink_1')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNdrink1')); 
	} else if (_inv.ItemHasAbility(itemId, 'drink_2')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNdrink2')); 
	} else if (_inv.ItemHasAbility(itemId, 'drink_3')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNdrink3')); 
	} else if (_inv.ItemHasAbility(itemId, 'drink_4')) {
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNdrink4')); 
	}
	return 1.0 ;
}
// ==========
//  Fatigue
// ==========

function PNFatigueOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfattoggle'); } 
function PNGetFatigueCounter() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatcounter')); }
function PNGetFatigueCombatAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatcombat')); }
function PNGetFatigueVitalityAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatvital')); }
function PNGetFatigueStaminaAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatstamina')); }
function PNGetFatigueAdrenalineAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatadrenaline')); }
function PNGetFatigueToxAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfattox')); }
function PNGetFatigueMaxFastTravel() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatfast')); }
function PNGetFatigueLevel() : int { return PNGetAttributeValue( thePlayer.GetAttributeValue( 'fatigue' ) ); }
function PNGetOverEatMult() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatovereat'));}
function PNGetOverDrinkMult() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatoverdrink'));}
function PNGetFatigueWeightAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatweight'));}
function PNGetFatigueWeightThreshold() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatweightthr')) / 100.f;}
function PNGetLightArmorAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatlight'));}
function PNGetMediumArmorAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatmedium'));}
function PNGetHeavyArmorAdd() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatheavy'));}

// ==============
//  Pee and Poop
// ==============

function PNPeeOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpeeon'); }
function PNPoopOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpoopon'); }
function PNPeeRisePerDrink() : int {return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpeeperdrink'));}
function PNPeeRisePerOverdrink() : int {return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpeeperoverdrink'));}
function PNPoopRisePerEat() : int {return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpooppereat'));}
function PNPoopRisePerOvereat() : int {return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpoopperovereat'));}
function PNGetPeeLevel() : int { return PNGetAttributeValue( thePlayer.GetAttributeValue( 'pee' ) ); }
function PNGetPoopLevel() : int { return PNGetAttributeValue( thePlayer.GetAttributeValue( 'poop' ) ); }
function PNGetPukeThirstCap() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpukethr')); }
function PNGetPukeHungerCap() : int { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpukehun')); }

// ==============
//   Animations
// ==============

function PNEatAnimOn() : bool {        return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNeat');}
function PNAltEatAnim() : bool {       return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNalteat');}
function PNDrinkAnimOn() : bool {      return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNdrink');}
function PNAltDrinkAnim() : bool {     return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNaltdrink');}
function PNPukeAnimOn() : bool {       return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNpuke');}
function PNPeeAnimOn() : bool {        return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNpee');}
function PNPoopAnimOn() : bool {       return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNpoop');}
function PNSleepAnimOn() : bool {      return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNsleep');}
function PNOilAnimOn() : bool {        return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNoil');}
function PNInvAnimOn() : bool {        return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNinv');}
function PNLootAnimOn() : bool {       return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNloot');}
function PNGrindstoneAnimOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNgrindstone');}
function PNWorkbenchAnimOn() : bool {  return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNworkbench');}
function PNHornDrinking() : bool {	   return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNhorndrink'); }
function PNHornEating() : bool {	   return theGame.GetInGameConfigWrapper().GetVarValue('PNanim', 'PNhorneat'); }
// Animation Speeds
function PNPeeSpeed() :         float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNpeesp'));}
function PNPoopSpeed() :        float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNpoopsp'));}
function PNDrinkSpeed() :       float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNdrinksp'));}
function PNDrink2Speed() :      float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNdrink2sp'));}
function PNEatSpeed() :         float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNeatsp'));}
function PNEat2Speed() :        float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNeat2sp'));}
function PNPukeSpeed() :        float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNpukesp'));}
function PNCollapseSpeed() :    float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNcollapsesp'));}
function PNOilSpeed() :         float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNoilsp'));}
function PNGrindstoneSpeed() :  float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNgrindstonesp'));}
function PNWorkbenchSpeed() :   float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNworkbenchsp'));}
function PNLootStartSpeed() :   float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNlootstartsp'));}
function PNLootStopSpeed() :    float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNlootstopsp'));}
function PNDBLootStartSpeed() : float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNdblootstartsp'));}
function PNDBLootStopSpeed() :  float { return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('PNanimspeed', 'PNdblootstopsp'));}

// ==========
//    HUD
// ==========

function PNToggleHud() { if (PNHudOn()) { PNResetHud(); } else { PNSetHud(); } }
function PNHudOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudon'); }
function PNSetHud() { theGame.GetInGameConfigWrapper().SetVarValue('PNhud', 'PNhudon', true); }
function PNResetHud() { theGame.GetInGameConfigWrapper().SetVarValue('PNhud', 'PNhudon', false); }
function PNUpdateHud() {theGame.GetGuiManager().GetHudEventController().RunEvent_ControlsFeedbackModule_Update( 'PrimalNeeds' );}
function PNHudAlwaysOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudaon'); }
function PNHUDNeedSpeedOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudspeedon'); }
function PNHUDNeedTimeLeftOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudtimeon'); }
function PNFactorHungerSpeed() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudhfac'); }
function PNFactorThirstSpeed() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudtfac'); }
function PNFactorFatigueSpeed() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudffac'); }

// ==========
//    Misc
// ==========

function PNSetMeditationFlag() { theGame.GetInGameConfigWrapper().SetVarValue('PNmisc', 'PNmed', true); }
function PNPeekMeditationFlag() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNmed'); }
function PNResetMeditationFlag() { theGame.GetInGameConfigWrapper().SetVarValue('PNmisc', 'PNmed', false); }
function PNInitalized() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNinit'); }
function PNGetVersion() : float { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNversion')); }
function PNSetTimeParametar() { theGame.GetInGameConfigWrapper().SetVarValue('PNmisc', 'PNdiff', true); }
function PNResetTimeParametar() { theGame.GetInGameConfigWrapper().SetVarValue('PNmisc', 'PNdiff', false); }
function PNGetTimeParametar() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNdiff'); }
function PNExpireOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNexptoggle'); }
function PNNotify( text : string) { theGame.GetGuiManager().ShowNotification( text , 5000 ); }
function PNHudNotify( text : string ) { thePlayer.DisplayHudMessage( text );}
function PNConsumeCombatOn() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNconsumecombaton'); }
function PNAllowAnimsInCombat() : bool { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNanimcombat'); }

// ==============
//      PATCH
// ==============
function PNIsPatch() : bool { return false; }

// --- Initialisation --- //
function PNinit() {
	
	var wrapper : CInGameConfigWrapper;
	wrapper = theGame.GetInGameConfigWrapper();
	
	if (!PNInitalized()) {
		// Hunger
		wrapper.SetVarValue('PNhunger', 'PNhuntoggle', true);
		wrapper.SetVarValue('PNhunger', 'PNhuncounter', "15");
		wrapper.SetVarValue('PNhunger', 'PNhundamage', "10");
		wrapper.SetVarValue('PNhunger', 'PNhuncombat', "0.1");
		wrapper.SetVarValue('PNhunger', 'PNhunvital', "0.8");
		wrapper.SetVarValue('PNhunger', 'PNhunstamina', "0.2");
		wrapper.SetVarValue('PNhunger', 'PNhunadrenaline', "0.5");
		wrapper.SetVarValue('PNhunger', 'PNhuntox', "0.5");
		wrapper.SetVarValue('PNhunger', 'PNhunmed', "0.1");
		wrapper.SetVarValue('PNhunger', 'PNhunfast', "7");
		
		// Thirst
		wrapper.SetVarValue('PNthirst', 'PNthrtoggle', true );
		wrapper.SetVarValue('PNthirst', 'PNthrfast', "9" );
		wrapper.SetVarValue('PNthirst', 'PNthrcounter', "5" );
		wrapper.SetVarValue('PNthirst', 'PNthrcombat', "0.3" );
		wrapper.SetVarValue('PNthirst', 'PNthrvital', "0.1" );
		wrapper.SetVarValue('PNthirst', 'PNthrstamina', "0.5" );
		wrapper.SetVarValue('PNthirst', 'PNthradrenaline', "0.2" );
		wrapper.SetVarValue('PNthirst', 'PNthrtox', "0.7" );
		wrapper.SetVarValue('PNthirst', 'PNthrmed', "0.1" );
		wrapper.SetVarValue('PNthirst', 'PNthrstaminamult', "50");
		wrapper.SetVarValue('PNthirst', 'PNthrshallow', "5");
		wrapper.SetVarValue('PNthirst', 'PNthrshallowpuke', "5");
		wrapper.SetVarValue('PNthirst', 'PNthrshallowtox', "10");
		
		// Fatigue
		wrapper.SetVarValue('PNfatigue', 'PNfattoggle', "1" );
		wrapper.SetVarValue('PNfatigue', 'PNfatcounter', "20" );
		wrapper.SetVarValue('PNfatigue', 'PNfatfast', "5" );
		wrapper.SetVarValue('PNfatigue', 'PNfatcombat', "1.0" );
		wrapper.SetVarValue('PNfatigue', 'PNfatvital', "0.4" );
		wrapper.SetVarValue('PNfatigue', 'PNfatstamina', "0.2" );
		wrapper.SetVarValue('PNfatigue', 'PNfatadrenaline', "0" );
		wrapper.SetVarValue('PNfatigue', 'PNfattox', "0" );
		wrapper.SetVarValue('PNfatigue', 'PNfatovereat', "0.2" );
		wrapper.SetVarValue('PNfatigue', 'PNfatoverdrink', "0.1" );
		wrapper.SetVarValue('PNfatigue', 'PNfatweight', "1.0");
		wrapper.SetVarValue('PNfatigue', 'PNfatweightthr', "50");
		wrapper.SetVarValue('PNfatigue', 'PNfatlight', "0.05");
		wrapper.SetVarValue('PNfatigue', 'PNfatmedium', "0.15");
		wrapper.SetVarValue('PNfatigue', 'PNfatheavy', "0.25");
		
		// Pee and Poop
		wrapper.SetVarValue('PNpp', 'PNpeeon', true );
		wrapper.SetVarValue('PNpp', 'PNpoopon', true );
		wrapper.SetVarValue('PNpp', 'PNpukethr', "8" );
		wrapper.SetVarValue('PNpp', 'PNpukehun', "5" );
		wrapper.SetVarValue('PNpp', 'PNpeeperdrink', "1" );
		wrapper.SetVarValue('PNpp', 'PNpeeperoverdrink', "2" );
		wrapper.SetVarValue('PNpp', 'PNpooppereat', "1" );
		wrapper.SetVarValue('PNpp', 'PNpoopperovereat', "2" );
		
		// Animations
		wrapper.SetVarValue('PNanim', 'PNeat', true );
		wrapper.SetVarValue('PNanim', 'PNdrink', true );
		wrapper.SetVarValue('PNanim', 'PNpuke', true );
		wrapper.SetVarValue('PNanim', 'PNpee', true );
		wrapper.SetVarValue('PNanim', 'PNpoop', true );
		wrapper.SetVarValue('PNanim', 'PNsleep', true );
		wrapper.SetVarValue('PNanim', 'PNoil', true);
		wrapper.SetVarValue('PNanim', 'PNinv', true);
		wrapper.SetVarValue('PNanim', 'PNloot', true);
		wrapper.SetVarValue('PNanim', 'PNgrindstone', true);
		wrapper.SetVarValue('PNanim', 'PNworkbench', true);
		wrapper.SetVarValue('PNanim', 'PNalteat', false );
		wrapper.SetVarValue('PNanim', 'PNaltdrink', false );	
		wrapper.SetVarValue('PNanim', 'PNhorndrink', true);
		wrapper.SetVarValue('PNanim', 'PNhorneat', true);
		
		// Animation Speeds
		wrapper.SetVarValue('PNanimspeed', 'PNpeesp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNpoopsp', "1.4" );
		wrapper.SetVarValue('PNanimspeed', 'PNdrinksp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNdrink2sp', "2.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNeatsp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNeat2sp', "1.2" );
		wrapper.SetVarValue('PNanimspeed', 'PNpukesp', "0.8" );
		wrapper.SetVarValue('PNanimspeed', 'PNcollapsesp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNoilsp', "0.4" );
		wrapper.SetVarValue('PNanimspeed', 'PNgrindstonesp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNworkbenchsp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNlootstartsp', "1.2" );
		wrapper.SetVarValue('PNanimspeed', 'PNlootstopsp', "1.6" );
		wrapper.SetVarValue('PNanimspeed', 'PNdblootstartsp', "1.35" );
		wrapper.SetVarValue('PNanimspeed', 'PNdblootstopsp', "1.75" );
		
		// Hud
		wrapper.SetVarValue('Hud', 'ControlsFeedbackModule', true);
		wrapper.SetVarValue('PNhud', 'PNhudaon', true);
		wrapper.SetVarValue('PNhud', 'PNhudon', true);
		wrapper.SetVarValue('PNhud', 'PNhudspeedon', true);
		wrapper.SetVarValue('PNhud', 'PNhudtimeon', true);
		wrapper.SetVarValue('PNhud', 'PNhudhfac', true);
		wrapper.SetVarValue('PNhud', 'PNhudtfac', true);
		wrapper.SetVarValue('PNhud', 'PNhudffac', true);
		
		// Misc
		wrapper.SetVarValue('PNmisc', 'PNmed', false);
		wrapper.SetVarValue('PNmisc', 'PNdiff', false);
		wrapper.SetVarValue('PNmisc', 'PNexptoggle', true);
		wrapper.SetVarValue('PNmisc', 'PNconsumecombaton', true);
		wrapper.SetVarValue('PNmisc', 'PNfeed1', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNfeed2', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNfeed3', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNfeed4', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink1', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink2', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink3', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink4', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNanimcombat', true);
		// Version
		wrapper.SetVarValue('PNmisc', 'PNversion', "1.15");
		wrapper.SetVarValue('PNmisc', 'PNinit', true);
	} else {
		if (PNGetVersion() < 1.03) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.03");
			wrapper.SetVarValue('PNmisc', 'PNhudaon', true);
			wrapper.SetVarValue('PNmisc', 'PNhudon', true);
		}
		if (PNGetVersion() < 1.05) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.05");
			wrapper.SetVarValue('PNmisc', 'PNhudspeedon', true);
			wrapper.SetVarValue('PNmisc', 'PNhudtimeon', true);
			wrapper.SetVarValue('PNmisc', 'PNconsumecombaton', true);
		}
		if (PNGetVersion() < 1.06) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.06");
			wrapper.SetVarValue('PNfatigue', 'PNfatovereat', "0.5" );
			wrapper.SetVarValue('PNfatigue', 'PNfatoverdrink', "0.5" );
		}
		if (PNGetVersion() < 1.10) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.10");
			wrapper.SetVarValue('PNfatigue', 'PNfatovereat', "0.2" );
			wrapper.SetVarValue('PNfatigue', 'PNfatoverdrink', "0.1" );
			wrapper.SetVarValue('PNpp', 'PNpeeon', true );
			wrapper.SetVarValue('PNpp', 'PNpoopon', true );
			wrapper.SetVarValue('PNpp', 'PNpukethr', "8" );
			wrapper.SetVarValue('PNpp', 'PNpukehun', "5" );
			wrapper.SetVarValue('PNpp', 'PNpeeperdrink', "1" );
			wrapper.SetVarValue('PNpp', 'PNpeeperoverdrink', "2" );
			wrapper.SetVarValue('PNpp', 'PNpooppereat', "1" );
			wrapper.SetVarValue('PNpp', 'PNpoopperovereat', "2" );
			wrapper.SetVarValue('PNanim', 'PNeat', true );
			wrapper.SetVarValue('PNanim', 'PNdrink', true );
			wrapper.SetVarValue('PNanim', 'PNpuke', false );
			wrapper.SetVarValue('PNanim', 'PNpee', true );
			wrapper.SetVarValue('PNanim', 'PNpoop', true );
			wrapper.SetVarValue('PNanim', 'PNsleep', true );
			wrapper.SetVarValue('PNhud', 'PNhudaon', true);
			wrapper.SetVarValue('PNhud', 'PNhudon', true);
			wrapper.SetVarValue('PNhud', 'PNhudspeedon', true);
			wrapper.SetVarValue('PNhud', 'PNhudtimeon', true);
			wrapper.SetVarValue('PNhunger', 'PNhunfast', "7");
			wrapper.SetVarValue('PNthirst', 'PNthrfast', "9" );
			wrapper.SetVarValue('PNfatigue', 'PNfatfast', "5" );
		}
		if (PNGetVersion() < 1.11) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.11");
			wrapper.SetVarValue('PNanim', 'PNoil', true);
			wrapper.SetVarValue('PNthirst', 'PNthrstaminamult', "50");
			wrapper.SetVarValue('PNanim', 'PNinv', true);
			wrapper.SetVarValue('PNanim', 'PNloot', true);
			wrapper.SetVarValue('PNanim', 'PNgrindstone', true);
			wrapper.SetVarValue('PNanim', 'PNworkbench', true);
		}
		if (PNGetVersion() < 1.12) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.12");
			wrapper.SetVarValue('PNfatigue', 'PNfatweight', "1.0");
			wrapper.SetVarValue('PNfatigue', 'PNfatweightthr', "50");
		}
		if (PNGetVersion() < 1.13) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.13");
			wrapper.SetVarValue('PNfatigue', 'PNfatlight', "0.05");
			wrapper.SetVarValue('PNfatigue', 'PNfatmedium', "0.15");
			wrapper.SetVarValue('PNfatigue', 'PNfatheavy', "0.25");
			wrapper.SetVarValue('PNhud', 'PNhudhfac', true);
			wrapper.SetVarValue('PNhud', 'PNhudtfac', true);
			wrapper.SetVarValue('PNhud', 'PNhudffac', true);
		}
		if (PNGetVersion() < 1.14) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.14");			
			wrapper.SetVarValue('PNanimspeed', 'PNpeesp', "1.0" );
			wrapper.SetVarValue('PNanimspeed', 'PNpoopsp', "1.4" );
			wrapper.SetVarValue('PNanimspeed', 'PNdrinksp', "1.0" );
			wrapper.SetVarValue('PNanimspeed', 'PNdrink2sp', "2.0" );
			wrapper.SetVarValue('PNanimspeed', 'PNeatsp', "1.0" );
			wrapper.SetVarValue('PNanimspeed', 'PNeat2sp', "1.2" );
			wrapper.SetVarValue('PNanimspeed', 'PNpukesp', "0.8" );
			wrapper.SetVarValue('PNanimspeed', 'PNcollapsesp', "1.0" );
			wrapper.SetVarValue('PNanimspeed', 'PNoilsp', "0.4" );
			wrapper.SetVarValue('PNanimspeed', 'PNgrindstonesp', "1.0" );
			wrapper.SetVarValue('PNanimspeed', 'PNworkbenchsp', "1.0" );
			wrapper.SetVarValue('PNanimspeed', 'PNlootstartsp', "1.2" );
			wrapper.SetVarValue('PNanimspeed', 'PNlootstopsp', "1.6" );
			wrapper.SetVarValue('PNanimspeed', 'PNdblootstartsp', "1.35" );
			wrapper.SetVarValue('PNanimspeed', 'PNdblootstopsp', "1.75" );
			wrapper.SetVarValue('PNthirst', 'PNthrshallow', "5");
			wrapper.SetVarValue('PNthirst', 'PNthrshallowpuke', "5");
			wrapper.SetVarValue('PNthirst', 'PNthrshallowtox', "10");
			wrapper.SetVarValue('PNmisc', 'PNfeed1', "1.0");
			wrapper.SetVarValue('PNmisc', 'PNfeed2', "1.0");
			wrapper.SetVarValue('PNmisc', 'PNfeed3', "1.0");
			wrapper.SetVarValue('PNmisc', 'PNfeed4', "1.0");
			wrapper.SetVarValue('PNmisc', 'PNdrink1', "1.0");
			wrapper.SetVarValue('PNmisc', 'PNdrink2', "1.0");
			wrapper.SetVarValue('PNmisc', 'PNdrink3', "1.0");
			wrapper.SetVarValue('PNmisc', 'PNdrink4', "1.0");
			wrapper.SetVarValue('PNanim', 'PNalteat', false );
			wrapper.SetVarValue('PNanim', 'PNaltdrink', false );
			wrapper.SetVarValue('PNanim', 'PNpuke', true );
		}
		if (PNGetVersion() < 1.15) {
			wrapper.SetVarValue('PNmisc', 'PNversion', "1.15");				
			wrapper.SetVarValue('PNmisc', 'PNanimcombat', true);
			wrapper.SetVarValue('PNanim', 'PNhorndrink', true);
			wrapper.SetVarValue('PNanim', 'PNhorneat', true);
		}
	}
}



// --- String To Name --- \\

function PNHungerToName( hun : int ) : name {
	switch(hun) {
		case 0   : return 'hunger_0';
		case 1   : return 'hunger_1';
		case 2   : return 'hunger_2';
		case 3   : return 'hunger_3';
		case 4   : return 'hunger_4';
		case 5   : return 'hunger_5';
		case 6   : return 'hunger_6';
		case 7   : return 'hunger_7';
		case 8   : return 'hunger_8';
		case 9   : return 'hunger_9';
		case 10  : return 'hunger_10';
		case 11  : return 'hunger_11';
		case 12  : return 'hunger_12';
		case 13  : return 'hunger_13';
		case 14  : return 'hunger_14';
		case 15  : return 'hunger_15';
		case 16  : return 'hunger_16';
		case 17  : return 'hunger_17';
		case 18  : return 'hunger_18';
		case 19  : return 'hunger_19';
		case 20  : return 'hunger_20';
		case 21  : return 'hunger_21';
		case 22  : return 'hunger_22';
		case 23  : return 'hunger_23';
		case 24  : return 'hunger_24';
		case 25  : return 'hunger_25';
		case 26  : return 'hunger_26';
		case 27  : return 'hunger_27';
		case 28  : return 'hunger_28';
		case 29  : return 'hunger_29';
		case 30  : return 'hunger_30';
		case 31  : return 'hunger_31';
		case 32  : return 'hunger_32';
		case 33  : return 'hunger_33';
		case 34  : return 'hunger_34';
		case 35  : return 'hunger_35';
		case 36  : return 'hunger_36';
		case 37  : return 'hunger_37';
		case 38  : return 'hunger_38';
		case 39  : return 'hunger_39';
		case 40  : return 'hunger_40';
		case 41  : return 'hunger_41';
		case 42  : return 'hunger_42';
		case 43  : return 'hunger_43';
		case 44  : return 'hunger_44';
		case 45  : return 'hunger_45';
		case 46  : return 'hunger_46';
		case 47  : return 'hunger_47';
		case 48  : return 'hunger_48';
		case 49  : return 'hunger_49';
		case 50  : return 'hunger_50';
		case 51  : return 'hunger_51';
		case 52  : return 'hunger_52';
		case 53  : return 'hunger_53';
		case 54  : return 'hunger_54';
		case 55  : return 'hunger_55';
		case 56  : return 'hunger_56';
		case 57  : return 'hunger_57';
		case 58  : return 'hunger_58';
		case 59  : return 'hunger_59';
		case 60  : return 'hunger_60';
		case 61  : return 'hunger_61';
		case 62  : return 'hunger_62';
		case 63  : return 'hunger_63';
		case 64  : return 'hunger_64';
		case 65  : return 'hunger_65';
		case 66  : return 'hunger_66';
		case 67  : return 'hunger_67';
		case 68  : return 'hunger_68';
		case 69  : return 'hunger_69';
		case 70  : return 'hunger_70';
		case 71  : return 'hunger_71';
		case 72  : return 'hunger_72';
		case 73  : return 'hunger_73';
		case 74  : return 'hunger_74';
		case 75  : return 'hunger_75';
		case 76  : return 'hunger_76';
		case 77  : return 'hunger_77';
		case 78  : return 'hunger_78';
		case 79  : return 'hunger_79';
		case 80  : return 'hunger_80';
		case 81  : return 'hunger_81';
		case 82  : return 'hunger_82';
		case 83  : return 'hunger_83';
		case 84  : return 'hunger_84';
		case 85  : return 'hunger_85';
		case 86  : return 'hunger_86';
		case 87  : return 'hunger_87';
		case 88  : return 'hunger_88';
		case 89  : return 'hunger_89';
		case 90  : return 'hunger_90';
		case 91  : return 'hunger_91';
		case 92  : return 'hunger_92';
		case 93  : return 'hunger_93';
		case 94  : return 'hunger_94';
		case 95  : return 'hunger_95';
		case 96  : return 'hunger_96';
		case 97  : return 'hunger_97';
		case 98  : return 'hunger_98';
		case 99  : return 'hunger_99';
		case 100 : return 'hunger_100';
		default : return 'hunger_0';
	}
}

function PNThirstToName( thr : int ) : name {
		
	switch(thr) {
		case 0   : return 'thirst_0';
		case 1   : return 'thirst_1';
		case 2   : return 'thirst_2';
		case 3   : return 'thirst_3';
		case 4   : return 'thirst_4';
		case 5   : return 'thirst_5';
		case 6   : return 'thirst_6';
		case 7   : return 'thirst_7';
		case 8   : return 'thirst_8';
		case 9   : return 'thirst_9';
		case 10  : return 'thirst_10';
		case 11  : return 'thirst_11';
		case 12  : return 'thirst_12';
		case 13  : return 'thirst_13';
		case 14  : return 'thirst_14';
		case 15  : return 'thirst_15';
		case 16  : return 'thirst_16';
		case 17  : return 'thirst_17';
		case 18  : return 'thirst_18';
		case 19  : return 'thirst_19';
		case 20  : return 'thirst_20';
		case 21  : return 'thirst_21';
		case 22  : return 'thirst_22';
		case 23  : return 'thirst_23';
		case 24  : return 'thirst_24';
		case 25  : return 'thirst_25';
		case 26  : return 'thirst_26';
		case 27  : return 'thirst_27';
		case 28  : return 'thirst_28';
		case 29  : return 'thirst_29';
		case 30  : return 'thirst_30';
		case 31  : return 'thirst_31';
		case 32  : return 'thirst_32';
		case 33  : return 'thirst_33';
		case 34  : return 'thirst_34';
		case 35  : return 'thirst_35';
		case 36  : return 'thirst_36';
		case 37  : return 'thirst_37';
		case 38  : return 'thirst_38';
		case 39  : return 'thirst_39';
		case 40  : return 'thirst_40';
		case 41  : return 'thirst_41';
		case 42  : return 'thirst_42';
		case 43  : return 'thirst_43';
		case 44  : return 'thirst_44';
		case 45  : return 'thirst_45';
		case 46  : return 'thirst_46';
		case 47  : return 'thirst_47';
		case 48  : return 'thirst_48';
		case 49  : return 'thirst_49';
		case 50  : return 'thirst_50';
		case 51  : return 'thirst_51';
		case 52  : return 'thirst_52';
		case 53  : return 'thirst_53';
		case 54  : return 'thirst_54';
		case 55  : return 'thirst_55';
		case 56  : return 'thirst_56';
		case 57  : return 'thirst_57';
		case 58  : return 'thirst_58';
		case 59  : return 'thirst_59';
		case 60  : return 'thirst_60';
		case 61  : return 'thirst_61';
		case 62  : return 'thirst_62';
		case 63  : return 'thirst_63';
		case 64  : return 'thirst_64';
		case 65  : return 'thirst_65';
		case 66  : return 'thirst_66';
		case 67  : return 'thirst_67';
		case 68  : return 'thirst_68';
		case 69  : return 'thirst_69';
		case 70  : return 'thirst_70';
		case 71  : return 'thirst_71';
		case 72  : return 'thirst_72';
		case 73  : return 'thirst_73';
		case 74  : return 'thirst_74';
		case 75  : return 'thirst_75';
		case 76  : return 'thirst_76';
		case 77  : return 'thirst_77';
		case 78  : return 'thirst_78';
		case 79  : return 'thirst_79';
		case 80  : return 'thirst_80';
		case 81  : return 'thirst_81';
		case 82  : return 'thirst_82';
		case 83  : return 'thirst_83';
		case 84  : return 'thirst_84';
		case 85  : return 'thirst_85';
		case 86  : return 'thirst_86';
		case 87  : return 'thirst_87';
		case 88  : return 'thirst_88';
		case 89  : return 'thirst_89';
		case 90  : return 'thirst_90';
		case 91  : return 'thirst_91';
		case 92  : return 'thirst_92';
		case 93  : return 'thirst_93';
		case 94  : return 'thirst_94';
		case 95  : return 'thirst_95';
		case 96  : return 'thirst_96';
		case 97  : return 'thirst_97';
		case 98  : return 'thirst_98';
		case 99  : return 'thirst_99';
		case 100 : return 'thirst_100';
		default : return 'thirst_0';
	}
}


function PNFatigueToName( fat : int ) : name {
		
	switch(fat) {
		case 0   : return 'fatigue_0';
		case 1   : return 'fatigue_1';
		case 2   : return 'fatigue_2';
		case 3   : return 'fatigue_3';
		case 4   : return 'fatigue_4';
		case 5   : return 'fatigue_5';
		case 6   : return 'fatigue_6';
		case 7   : return 'fatigue_7';
		case 8   : return 'fatigue_8';
		case 9   : return 'fatigue_9';
		case 10  : return 'fatigue_10';
		case 11  : return 'fatigue_11';
		case 12  : return 'fatigue_12';
		case 13  : return 'fatigue_13';
		case 14  : return 'fatigue_14';
		case 15  : return 'fatigue_15';
		case 16  : return 'fatigue_16';
		case 17  : return 'fatigue_17';
		case 18  : return 'fatigue_18';
		case 19  : return 'fatigue_19';
		case 20  : return 'fatigue_20';
		case 21  : return 'fatigue_21';
		case 22  : return 'fatigue_22';
		case 23  : return 'fatigue_23';
		case 24  : return 'fatigue_24';
		case 25  : return 'fatigue_25';
		case 26  : return 'fatigue_26';
		case 27  : return 'fatigue_27';
		case 28  : return 'fatigue_28';
		case 29  : return 'fatigue_29';
		case 30  : return 'fatigue_30';
		case 31  : return 'fatigue_31';
		case 32  : return 'fatigue_32';
		case 33  : return 'fatigue_33';
		case 34  : return 'fatigue_34';
		case 35  : return 'fatigue_35';
		case 36  : return 'fatigue_36';
		case 37  : return 'fatigue_37';
		case 38  : return 'fatigue_38';
		case 39  : return 'fatigue_39';
		case 40  : return 'fatigue_40';
		case 41  : return 'fatigue_41';
		case 42  : return 'fatigue_42';
		case 43  : return 'fatigue_43';
		case 44  : return 'fatigue_44';
		case 45  : return 'fatigue_45';
		case 46  : return 'fatigue_46';
		case 47  : return 'fatigue_47';
		case 48  : return 'fatigue_48';
		case 49  : return 'fatigue_49';
		case 50  : return 'fatigue_50';
		case 51  : return 'fatigue_51';
		case 52  : return 'fatigue_52';
		case 53  : return 'fatigue_53';
		case 54  : return 'fatigue_54';
		case 55  : return 'fatigue_55';
		case 56  : return 'fatigue_56';
		case 57  : return 'fatigue_57';
		case 58  : return 'fatigue_58';
		case 59  : return 'fatigue_59';
		case 60  : return 'fatigue_60';
		case 61  : return 'fatigue_61';
		case 62  : return 'fatigue_62';
		case 63  : return 'fatigue_63';
		case 64  : return 'fatigue_64';
		case 65  : return 'fatigue_65';
		case 66  : return 'fatigue_66';
		case 67  : return 'fatigue_67';
		case 68  : return 'fatigue_68';
		case 69  : return 'fatigue_69';
		case 70  : return 'fatigue_70';
		case 71  : return 'fatigue_71';
		case 72  : return 'fatigue_72';
		case 73  : return 'fatigue_73';
		case 74  : return 'fatigue_74';
		case 75  : return 'fatigue_75';
		case 76  : return 'fatigue_76';
		case 77  : return 'fatigue_77';
		case 78  : return 'fatigue_78';
		case 79  : return 'fatigue_79';
		case 80  : return 'fatigue_80';
		case 81  : return 'fatigue_81';
		case 82  : return 'fatigue_82';
		case 83  : return 'fatigue_83';
		case 84  : return 'fatigue_84';
		case 85  : return 'fatigue_85';
		case 86  : return 'fatigue_86';
		case 87  : return 'fatigue_87';
		case 88  : return 'fatigue_88';
		case 89  : return 'fatigue_89';
		case 90  : return 'fatigue_90';
		case 91  : return 'fatigue_91';
		case 92  : return 'fatigue_92';
		case 93  : return 'fatigue_93';
		case 94  : return 'fatigue_94';
		case 95  : return 'fatigue_95';
		case 96  : return 'fatigue_96';
		case 97  : return 'fatigue_97';
		case 98  : return 'fatigue_98';
		case 99  : return 'fatigue_99';
		case 100 : return 'fatigue_100';
		default : return 'fatigue_0';
	}
}

function PNPeeToName( val : int ) : name {
	switch (val) {
		case 0   : return 'pee_0';
		case 1   : return 'pee_1';
		case 2   : return 'pee_2';
		case 3   : return 'pee_3';
		case 4   : return 'pee_4';
		case 5   : return 'pee_5';
		case 6   : return 'pee_6';
		case 7   : return 'pee_7';
		case 8   : return 'pee_8';
		case 9   : return 'pee_9';
		default  : return 'pee_0';
	}
}

function PNPoopToName( val : int ) : name {
	switch (val) {
		case 0   : return 'poop_0';
		case 1   : return 'poop_1';
		case 2   : return 'poop_2';
		case 3   : return 'poop_3';
		case 4   : return 'poop_4';
		case 5   : return 'poop_5';
		case 6   : return 'poop_6';
		case 7   : return 'poop_7';
		case 8   : return 'poop_8';
		case 9   : return 'poop_9';
		case 10  : return 'poop_10';
		case 11  : return 'poop_11';
		case 12  : return 'poop_12';
		case 13  : return 'poop_13';
		case 14  : return 'poop_14';
		case 15  : return 'poop_15';
		case 16  : return 'poop_16';
		case 17  : return 'poop_17';
		case 18  : return 'poop_18';
		case 19  : return 'poop_19';
		default  : return 'poop_0';
	}
}
state PNAnimation in CR4Player
{
	private var prevState : name ;
	private var speedMultID : int ;
	private var anim : string ;
	
	private var start : name ;
	private var loop : name ;
	private var stop : name ;
	private var startSpeed : float ;
	private var loopSpeed : float ;
	private var stopSpeed : float ;
	
	private var wasUsingItem : bool;
	
	event OnEnterState( prevStateName : name )
	{
		if (!PNIsAnim("collapse") && !PNIsAnim("puke")) {
			parent.AddTimer( 'InterruptMonitor', 0, true );
		}
		super.OnEnterState(prevStateName);
		parent.BlockAction( EIAB_DrawWeapon, 'Animation' );
		prevState = prevStateName;
		parent.prevState = prevStateName;

		//modPrimalShallowWater BEGIN
		if (parent.PukeEffect && this.IsFoodAnim()) {
			PNHudNotify(GetLocStringByKeyExt("HUDmessage_PukingEffect"));
			this.anim = "puke";
		} else {
			this.anim = parent.PNanimType;
		}
		//modPrimalShallowWater END

		if (GetWitcherPlayer().IsCurrentlyUsingItemL() && PNTwoHandedAnim() ) {
			parent.OnUseSelectedItem();
			wasUsingItem = true;
		} else
			wasUsingItem = false;
		SetUpAnimation();
		PlayAnimation();
	}
		
	event OnLeaveState( nextStateName : name )
	{
		parent.UnblockAction( EIAB_DrawWeapon, 'Animation' );
		parent.PNanimType = "";
		parent.ResetAnimationSpeedMultiplier(speedMultID);
		super.OnLeaveState(nextStateName);
		parent.RemoveTimer('InterruptMonitor');
		parent.suppressDrawSwordReaction = false;
		if ( wasUsingItem ) {	
			parent.OnUseSelectedItem();
		}

		//modPrimalShallowWater BEGIN
		if ( anim == "bottle1" || anim == "bottle2" ) {
			PSWPutAwayBottle();
		}
		//modPrimalShallowWater END
	}
	
	event OnTakeDamage(action: W3DamageAction)
	{
		if ((W3PlayerWitcher)action.victim && action.DealsAnyDamage() && !((W3Effect_Toxicity)action.causer))
		{
			parent.isLoop = false;
			parent.OnTakeDamage(action);
		}
	}
	
	entry function PlayAnimation()
	{
		//PN + modPrimalShallowWater BEGIN
		var i : int = 0;
		var blendIn  : float = 1.0;
		var blendOut : float = 0.0;

		if (this.anim == "shallower") {
			blendIn  = 0.3f;
			blendOut = 0.3f;
		} else if (this.anim == "bottle2") {
			blendIn  = 0.9f;
			blendOut = 0.9f;
		}

		if ( start != '' ) {
			if (this.WasSwimming()) {
				parent.BlockAction(EIAB_Movement, 'Animation');
				parent.RaiseEvent('DiveFail');
			} else {
				speedMultID = parent.SetAnimationSpeedMultiplier( startSpeed , speedMultID);
				parent.ActionPlaySlotAnimation( 'PLAYER_SLOT', start, 1.0, blendOut );
			}
		}
		if ( loop != '') {
			speedMultID = parent.SetAnimationSpeedMultiplier( loopSpeed , speedMultID);
			do {
				if (( anim == "shallow" || anim == "shallower" ) && PNGetThirst() <= 0 ) {
					parent.PNSetLoop( false );
					break;
				}
				if (( anim == "bottle1" || anim == "bottle2" ) && parent.inv.GetItemQuantityByName('polluted_water') >= 10 ) {
					parent.PNSetLoop( false );
					break;
				}
				if (this.WasSwimming()) {
					Sleep(5.0f);
				} else {
					if (this.anim == "bottle2") {
						parent.ActionPlaySlotAnimation( 'PLAYER_SLOT', loop , blendIn, blendOut);
					} else {
						parent.ActionPlaySlotAnimation( 'PLAYER_SLOT', loop , 0.0, 0.0);
					}
				}
				if ( anim == "shallow" || anim == "shallower" ) {
					i += 1;
					if (PNGetThirst() >= PNGetShallowThirstRise() )
						PNDrinkShallow(PNGetShallowThirstRise());
					else 
						PNDrinkShallow(PNGetThirst());
				}
				if ( anim == "bottle1" || anim == "bottle2" ) {
					parent.inv.AddAnItem('polluted_water');
				}
			} while ( parent.isLoop );
			if ( anim == "shallow" || anim == "shallower" ) {
				parent.RemoveTimer('InterruptMonitor');
				if (PNPeeOn()) PNRisePee( i / 3 );
				if (PNPukeAnimOn() && i > PNGetShallowPukeLevel() )
					parent.AddTimer('PNPuke', RandRangeF(30.0, 10.0));
			}
		}
		if ( stop != '' ) {
			if (this.WasSwimming()) {
				parent.RaiseEvent('DiveFail');
				parent.UnblockAction(EIAB_Movement, 'Animation');
			} else {
				speedMultID = parent.SetAnimationSpeedMultiplier( stopSpeed , speedMultID);
				parent.ActionPlaySlotAnimation( 'PLAYER_SLOT', stop , blendIn, 1.0);
			}
		}
		//PN + modPrimalShallowWater END
		if ( anim == "grindstone" || anim == "oil") 
			PNSheatheSword();
			
		parent.GotoState( prevState );
	}
	
	function SetUpAnimation() 
	{
		var peesp, poopsp, drinksp, drink2sp, eatsp, eat2sp, pukesp, collapsesp, oilsp, grindstonesp, workbenchsp : float ;
		var lootstartsp, lootloopsp, lootstopsp : float ;
		var dblootstartsp, dblootloopsp, dblootstopsp : float ;
			
		switch (anim) 
		{
			case "drink":
				drinksp = PNDrinkSpeed();
				start = '';
				loop = '';
				stop = 'work_stand_drink_02'; stopSpeed = drinksp;
				GetWitcherPlayer().AddTimer(parent.drinkMode, 1.0 / drinksp);
				break;
			case "drink2":
				drink2sp = PNDrink2Speed();
				start = '';
				loop = '';
				stop = 'geralt_determined_gesture_drink'; stopSpeed = drink2sp;
				GetWitcherPlayer().AddTimer(parent.drinkMode, 3.0 / drink2sp);
				break;
			case "eat":
				eatsp = PNEatSpeed();
				start = '';
				loop = '';
				stop = 'work_stand_eat_01'; stopSpeed = eatsp;
				GetWitcherPlayer().AddTimer('PNConsume', 1.2 / eatsp );
				break;
			case "eat2":
				eat2sp = PNEat2Speed();
				start = '';
				loop = '';
				stop = 'work_stand_eat_02'; stopSpeed = eat2sp;
				GetWitcherPlayer().AddTimer('PNConsume', 3.0 / eat2sp );
				break;
			case "oil":
				oilsp = PNOilSpeed();
				start = '';
				loop = '';
				stop = 'man_work_sword_sharpening_02'; stopSpeed = oilsp ;
				GetWitcherPlayer().AddTimer('PNApplyOil', 2.0 / oilsp );
				break;
			case "deadbodyloot":
				dblootstartsp = PNDBLootStartSpeed();
				dblootstopsp = PNDBLootStopSpeed();
				start = 'work_kneeling_start'; startSpeed = dblootstartsp;
				loop = 'work_kneeling_loop'; loopSpeed = 1000.0 ;
				stop = 'work_kneeling_end'; stopSpeed = dblootstopsp;
				parent.isLoop = true;
				GetWitcherPlayer().AddTimer('PNContainerProcessLoot', 2.0 / dblootstartsp);
				break;
			case "loot":
				lootstartsp = PNLootStartSpeed();
				lootstopsp = PNLootStopSpeed();
				start = 'man_work_picking_up_herbs_start'; startSpeed = lootstartsp;
				loop = 'man_work_picking_up_herbs_loop_03'; loopSpeed = 1000.0 ;
				stop = 'man_work_picking_up_herbs_stop'; stopSpeed = lootstopsp;
				parent.isLoop = true;
				GetWitcherPlayer().AddTimer('PNContainerProcessLoot', 2.5 / lootstartsp );
				break;
			case "grindstone":
				grindstonesp = PNGrindstoneSpeed();
				start = '';
				loop = '';
				stop = 'man_work_sword_sharpening_06'; stopSpeed = grindstonesp;
				GetWitcherPlayer().AddTimer('PNRepairBuffWeapon', 6.5 / grindstonesp);
				break;
			case "workbench":
				workbenchsp = PNWorkbenchSpeed();
				start = '';
				loop = '';
				stop = 'man_standing_adjusting_and_cleaning_clothes_loop_1'; stopSpeed = workbenchsp;
				GetWitcherPlayer().AddTimer('PNRepairBuffArmor', 9.5 / workbenchsp);
				parent.AddTimer('DelayedInterrupt', 12.0 / workbenchsp );
				break;
			case "shallow":
				start = 'man_work_standing_splashing_his_face_start'; startSpeed = 1.0 ;
				loop = 'man_work_standing_splashing_his_face_loop_03'; loopSpeed = 1.0 ;
				stop = 'man_work_standing_splashing_his_face_stop'; stopSpeed = 1.0 ;
				parent.isLoop = true;
				break;
			//modPrimalShallowWater BEGIN
			case "shallower":
				start = 'man_work_milking_cow_start'; this.startSpeed = 1.0f;
				loop  = 'man_work_milking_cow_loop2'; this.loopSpeed  = 1.0f;
				stop  = 'man_work_loot_ground_stop';  this.stopSpeed  = 1.0f;
				parent.isLoop = true;
				break;
			case "bottle1":
				start = 'man_work_standing_splashing_his_face_start';   this.startSpeed = 1.0f;
				loop  = 'man_work_standing_splashing_his_face_loop_03'; this.loopSpeed  = 1.0f;
				stop  = 'man_work_standing_splashing_his_face_stop';    this.stopSpeed  = 1.0f;
				parent.isLoop = true;
				break;
			case "bottle2":
				start = 'work_kneeling_start';                   this.startSpeed = 1.0f;
				loop  = 'high_kneeling_determined_gesture_take'; this.loopSpeed  = 1.0f;
				stop  = 'work_kneeling_end';                     this.stopSpeed  = 1.0f;
				parent.isLoop = true;
				break;
			//modPrimalShallowWater END
			case "puke":
				pukesp = PNPukeSpeed();
				start = '';
				loop = '';
				stop = 'man_work_drunk_puke'; stopSpeed = pukesp;
				break;
			case "collapse":
				collapsesp = PNCollapseSpeed();
				start = 'man_work_sleep_ground_start'; startSpeed = collapsesp;
				loop = 'man_work_sleep_ground_loop_1'; loopSpeed = collapsesp;
				stop = 'man_work_sleep_ground_stop'; stopSpeed = collapsesp;
				parent.RemoveTimer('PNPuke');
				parent.AddTimer('PNCollapse', 11.0 / collapsesp );
				break;
			case "pee":
				peesp = PNPeeSpeed();
				start = 'man_peeing_start'; startSpeed = peesp;
				loop = 'man_peeing_loop'; loopSpeed = peesp;
				stop = 'man_peeing_end'; stopSpeed = peesp;
				parent.AddTimer('PNEndPee', 7.0 / peesp );
				break;
			case "poop":
				poopsp = PNPoopSpeed();
				start = 'man_work_sit_squat_start'; startSpeed = poopsp;
				loop = 'man_work_sit_squat_01'; loopSpeed = poopsp;
				stop = 'man_work_sit_squat_stop'; stopSpeed = poopsp;
				parent.AddTimer('PNEndPoop', 5.0 / poopsp );
				break;
			default:
				break;
		}
	}

	//modPrimalShallowWater BEGIN
	private function WasSwimming() : bool
	{
		return this.prevState == 'Swimming';
	}

	private function IsFoodAnim() : bool
	{
		return (parent.PNanimType == "drink")
		    || (parent.PNanimType == "drink2")
		    || (parent.PNanimType == "eat")
		    || (parent.PNanimType == "eat2")
		    || (parent.PNanimType == "shallow")
		    || (parent.PNanimType == "shallower");
	}
	//modPrimalShallowWater END
}

state PNInterruption in CR4Player
{
	var speedMultID : int;
	
	event OnEnterState( prevStateName : name )
	{
		parent.isLoop = false;
		super.OnEnterState(prevStateName);
		RemoveAllTimers();
		InterruptAnimation();
	}
	
	event OnLeaveState( nextStateName : name )
	{
		super.OnLeaveState(nextStateName);
	}
	
	entry function InterruptAnimation() {
		parent.ActionPlaySlotAnimation( 'PLAYER_SLOT', '' );
		parent.ResetAnimationSpeedMultiplier(speedMultID);
		parent.GotoState(parent.prevState);
	}
	
	function RemoveAllTimers() {
		GetWitcherPlayer().RemoveTimer('PNConsume' );
		GetWitcherPlayer().RemoveTimer('PNDrinkPotion');
		GetWitcherPlayer().RemoveTimer('PNDrinkPotionInv');
		GetWitcherPlayer().RemoveTimer('PNApplyOil');
		GetWitcherPlayer().RemoveTimer('PNContainerProcessLoot');
		GetWitcherPlayer().RemoveTimer('PNRepairBuffWeapon');
		GetWitcherPlayer().RemoveTimer('PNRepairBuffArmor');
		parent.RemoveTimer('PNEndPoop');
		parent.RemoveTimer('PNEndPee');
		parent.RemoveTimer('PNCollapse');
	}
}

function PNDrinkAnim(mode: name, optional slot: EEquipmentSlots)
{
	var item : SItemUniqueId = GetWitcherPlayer().PNItemToConsume;
	var slotvar : EEquipmentSlots = GetWitcherPlayer().PNSlotTOConsume;
	
	if ( mode == 'PNDrinkPotion' ) {
		GetWitcherPlayer().GetItemEquippedOnSlot(slotvar, item);
		if ( !GetWitcherPlayer().inv.HasItemById(item) || GetWitcherPlayer().inv.SingletonItemGetAmmo(item) == 0 ) return;
	}

	if (PNDrinkAnimOn() && PNAnimationNotBeingPerformed())
	{
		if (PNHornDrinking() && ( thePlayer.IsInCombat() || thePlayer.IsOnBoat() || thePlayer.GetCurrentStateName() == 'HorseRiding'))
		{
			PNBlockAllDrinkingActions();

			if (GetWitcherPlayer().IsCurrentlyUsingItemL())
			{
				GetWitcherPlayer().RaiseEvent('ForcedUsableItemUnequip');
				GetWitcherPlayer().AddTimer('PNPotion', 0.5f, false);
				GetWitcherPlayer().AddTimer(mode, 2.5f, false);
				GetWitcherPlayer().AddTimer('PNUnblockActions', 3.5);
			}
			else
			{
				GetWitcherPlayer().OnUsePotion();
				GetWitcherPlayer().AddTimer(mode, 2.0f, false);
				GetWitcherPlayer().AddTimer('PNUnblockActions', 3.0);
			}
		}
		else
		{
			if (!PNAltDrinkAnim())
				thePlayer.PNSetAnim("drink");
			else
				thePlayer.PNSetAnim("drink2");
			theGame.GetGuiManager().GetCommonMenu().CloseMenu();
			thePlayer.PNSetDrinkMode(mode);
			PNSheatheSwordIfUnsheatedAndPlayAnimation();
		}
	}
}

function PNEatAnim()
{
	if (PNEatAnimOn() && PNAnimationNotBeingPerformed())
	{
		if (PNHornEating() && ( thePlayer.IsInCombat() || thePlayer.IsOnBoat() || thePlayer.GetCurrentStateName() == 'HorseRiding'))
		{
			PNBlockAllDrinkingActions();

			if (GetWitcherPlayer().IsCurrentlyUsingItemL())
			{
				GetWitcherPlayer().RaiseEvent('ForcedUsableItemUnequip');
				GetWitcherPlayer().AddTimer('PNPotion', 0.5f, false);
				GetWitcherPlayer().AddTimer('PNConsume', 2.5f, false);
				GetWitcherPlayer().AddTimer('PNUnblockActions', 3.5);
			}
			else
			{
				GetWitcherPlayer().OnUsePotion();
				GetWitcherPlayer().AddTimer('PNConsume', 2.0f, false);
				GetWitcherPlayer().AddTimer('PNUnblockActions', 3.0);
			}
		}
		else
		{
			if (!PNAltEatAnim())
				thePlayer.PNSetAnim("eat");
			else
				thePlayer.PNSetAnim("eat2");
			theGame.GetGuiManager().GetCommonMenu().CloseMenu();
			PNSheatheSwordIfUnsheatedAndPlayAnimation();
		}
	}
}

function PNOilAnim( apply : name) {
	if (PNOilAnimOn() && PNAnimationNotBeingPerformed()) {
		thePlayer.PNSetAnim( "oil" );
		PNUnsheateRightSwordAndPlayAnimation( apply );
	}
}

function PNLootAnim( container : W3Container ) {
	if (PNLootAnimOn() && PNAnimationNotBeingPerformed()) {
		if ((W3ActorRemains) container )		
			thePlayer.PNSetAnim( "deadbodyloot" );
		else 
			thePlayer.PNSetAnim( "loot" );
		thePlayer.SetCustomRotation('Loot', VecHeading(container.GetWorldPosition() - thePlayer.GetWorldPosition()), 360.f, 1.f, false);			
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
}

function PNGrindstoneAnim() {
	if (PNGrindstoneAnimOn() && PNAnimationNotBeingPerformed()) {
		thePlayer.PNSetAnim( "grindstone" );
		PNUnsheatheSwordAndPlayAnimation();
	}
}

function PNWorkbenchAnim() {
	if (PNWorkbenchAnimOn() && PNAnimationNotBeingPerformed()) {
		thePlayer.PNSetAnim( "workbench" );
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
}

function PNPeeAnim() {
	if (PNPeeAnimOn()) {
		if (PNIsAnim("pee") || PNIsAnim("collapse") || PNIsAnim("puke"))
			return;
		if (!PNAnimationNotBeingPerformed()) {
			PNForceInterruptAnim();
		}
		thePlayer.PNSetAnim("pee");
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
}

function PNPoopAnim() {
	if (PNPoopAnimOn()) {
		if (PNIsAnim("poop") || PNIsAnim("collapse") || PNIsAnim("puke"))
			return;
		if (!PNAnimationNotBeingPerformed()) {
			PNForceInterruptAnim();
		}
		thePlayer.PNSetAnim("poop");
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
}


function PNPukeAnim() {
	if (PNPukeAnimOn()) {
		if (PNIsAnim("puke"))
			return;
		if (!PNAnimationNotBeingPerformed()) {
			PNForceInterruptAnim();
		}
		thePlayer.PNStartPukeEffect();
		thePlayer.AddGameTimeTimer('PNStopPukeEffect', GameTimeCreate( 0, 1, 0, 0 ) );
		thePlayer.PNSetAnim("puke");
		if (thePlayer.GetCurrentStateName() == 'Exploration' || thePlayer.IsInCombat())
			PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
}

function PNCollapseAnim() {
	if (PNSleepAnimOn())
	{
		if (!(thePlayer.GetCurrentStateName() == 'Exploration' || thePlayer.IsInCombat()))
			return;
		if (PNIsAnim("collapse") || PNIsAnim("puke"))
			return;
		if (!PNAnimationNotBeingPerformed()) {
			PNForceInterruptAnim();
		}
		thePlayer.PNSetAnim("collapse");
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
}

function PNShallowAnim() {
	if (thePlayer.IsInShallowWater() && PNAnimationNotBeingPerformed())
	{
		thePlayer.PNSetAnim("shallow");
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
	//modPrimalShallowWater BEGIN
	else if (thePlayer.IsInWaterTrigger() && PNAnimationNotBeingPerformed())
	{
		thePlayer.PNSetAnim("shallower");
		PNSheatheSwordIfUnsheatedAndPlayAnimation();
	}
	/* Stop drinking or bottling shallow water */
	else if (PSWIsShallowWaterShenanigans())
	{
		thePlayer.PNSetLoop(false);
		PNHudNotify(GetLocStringByKeyExt("psw_anim_stopping"));
	}
	//modPrimalShallowWater END
}
/**************************************************************
							HELPERS
 **************************************************************/

function PNTwoHandedAnim() : bool {
	return 
		thePlayer.PNanimType == "drink2"
	 || thePlayer.PNanimType == "oil"
	 || thePlayer.PNanimType == "workbench"
	 || thePlayer.PNanimType == "grindstone"
	 || thePlayer.PNanimType == "pee"
	 || PSWIsShallowWaterShenanigans(); //modPrimalShallowWater
} 
 
function PNIsAnim( anim : string ) : bool
{
	return thePlayer.PNanimType == anim;
}
 
function PNForceInterruptAnim() {
	thePlayer.PNSetLoop( false );
	thePlayer.GotoState('PNInterruption');
}
 
function PNAnimationNotBeingPerformed() : bool
{
	return !(thePlayer.GetCurrentStateName() == 'PNAnimation');
}

function PNInRightStateToPlayAnim() : bool
{
	return thePlayer.GetCurrentStateName() == 'Exploration' || thePlayer.GetCurrentStateName() == 'CombatFists' || thePlayer.GetCurrentStateName() == 'CombatSteel' || thePlayer.GetCurrentStateName() == 'CombatSilver';
}
 
function PNBlockAllDrinkingActions() {
	thePlayer.BlockAction(EIAB_DrawWeapon, 			'PotionAnimation');
	thePlayer.BlockAction(EIAB_Signs,				'PotionAnimation');
	thePlayer.BlockAction(EIAB_Crossbow,			'PotionAnimation');
	thePlayer.BlockAction(EIAB_UsableItem,			'PotionAnimation');
	thePlayer.BlockAction(EIAB_ThrowBomb,			'PotionAnimation');
	thePlayer.BlockAction(EIAB_SwordAttack,			'PotionAnimation');
	thePlayer.BlockAction(EIAB_Jump,				'PotionAnimation');
	// thePlayer.BlockAction(EIAB_Dodge,				'PotionAnimation');
	thePlayer.BlockAction(EIAB_Roll,				'PotionAnimation');
	thePlayer.BlockAction(EIAB_LightAttacks,		'PotionAnimation');
	thePlayer.BlockAction(EIAB_HeavyAttacks,		'PotionAnimation');
	thePlayer.BlockAction(EIAB_SpecialAttackLight,	'PotionAnimation');
	thePlayer.BlockAction(EIAB_SpecialAttackHeavy,	'PotionAnimation');	
}
 
function PNSheatheSwordIfUnsheatedAndPlayAnimation() {
	if (GetWitcherPlayer().IsWeaponHeld('silversword') || GetWitcherPlayer().IsWeaponHeld('steelsword')) {
	GetWitcherPlayer().OnEquipMeleeWeapon(PW_None, true, true);
		thePlayer.AddTimer('PNAnimState', 1.0);
	} else {
		thePlayer.GotoState('PNAnimation');
	}
	thePlayer.BlockAction( EIAB_DrawWeapon, 'Animation' );
}

function PNSheatheSword() {
	GetWitcherPlayer().OnEquipMeleeWeapon(PW_None, true, true);
}

function PNUnsheateRightSwordAndPlayAnimation( apply : name ) {
	var notApply : name;
	var weapon : EPlayerWeapon;
	
	if (apply == 'silversword') {
		notApply = 'steelsword';
		weapon = PW_Silver;
	} else {
		notApply = 'silversword';
		weapon = PW_Steel;
	}
	
	if ( thePlayer.GetCurrentStateName() == 'Exploration' ) {
		theGame.GetGuiManager().GetCommonMenu().CloseMenu();
		thePlayer.PNSetSuppressDrawSwordReaction( true );
		GetWitcherPlayer().OnEquipMeleeWeapon(weapon, true);
		if (GetWitcherPlayer().IsWeaponHeld(apply)) {
			thePlayer.GotoState('PNAnimation');
		} else if (GetWitcherPlayer().IsWeaponHeld(notApply)) {
			thePlayer.AddTimer('PNAnimState', 2.6);
		} else {
			thePlayer.AddTimer('PNAnimState', 1.5);
		}	
	}
	thePlayer.BlockAction( EIAB_DrawWeapon, 'Animation' );
}

function PNUnsheatheSwordAndPlayAnimation() {
	var steel : SItemUniqueId;
	var silver : SItemUniqueId;
	
	GetWitcherPlayer().GetItemEquippedOnSlot(EES_SteelSword, steel);
	GetWitcherPlayer().GetItemEquippedOnSlot(EES_SilverSword, silver);

	thePlayer.PNSetSuppressDrawSwordReaction( true );
	
	if (!GetWitcherPlayer().IsWeaponHeld('silversword') && !GetWitcherPlayer().IsWeaponHeld('steelsword')) {
	
		if ( GetWitcherPlayer().inv.ItemHasTag( steel, 'Wooden' ) || GetWitcherPlayer().inv.ItemHasTag( steel, 'SecondaryWeapon'))
			if ( GetWitcherPlayer().inv.HasItemById( silver ) ) {
				GetWitcherPlayer().OnEquipMeleeWeapon(PW_Silver, true);
				thePlayer.AddTimer('PNAnimState', 1.5);
			} else {
				GetWitcherPlayer().DisplayHudMessage(GetLocStringByKeyExt( "panel_hud_message_repair_nothing" ));
				thePlayer.PNSetSuppressDrawSwordReaction( false );
				return;
			}
		else
			if ( GetWitcherPlayer().inv.HasItemById( steel ) && GetWitcherPlayer().inv.HasItemById( silver ) ) {
				if ( RandF() >= 0.5 )
					GetWitcherPlayer().OnEquipMeleeWeapon(PW_Steel, true);
				else 
					GetWitcherPlayer().OnEquipMeleeWeapon(PW_Silver, true);
			} else {
				if (GetWitcherPlayer().inv.HasItemById( steel ) ) {
					GetWitcherPlayer().OnEquipMeleeWeapon(PW_Steel, true);
				} else {
					GetWitcherPlayer().OnEquipMeleeWeapon(PW_Silver, true);
				}
			}
			thePlayer.AddTimer('PNAnimState', 1.5);
	} else {
		
		if ( GetWitcherPlayer().IsWeaponHeld('steelsword') ) {
			if ( GetWitcherPlayer().inv.ItemHasTag( steel, 'Wooden' ) || GetWitcherPlayer().inv.ItemHasTag( steel, 'SecondaryWeapon') ) {
				if ( GetWitcherPlayer().inv.HasItemById( silver ) ) {
					GetWitcherPlayer().OnEquipMeleeWeapon(PW_None, true);
					GetWitcherPlayer().OnEquipMeleeWeapon(PW_Silver, true);
					thePlayer.AddTimer('PNAnimState', 3.0);
				} else {
					GetWitcherPlayer().DisplayHudMessage(GetLocStringByKeyExt( "panel_hud_message_repair_nothing" ));
					thePlayer.PNSetSuppressDrawSwordReaction( false );
					return;
				}
			} else {
				thePlayer.GotoState('PNAnimation');				
			}	
		} else {
			thePlayer.GotoState('PNAnimation');			
		}
	}
	thePlayer.BlockAction( EIAB_DrawWeapon, 'Animation' );
}
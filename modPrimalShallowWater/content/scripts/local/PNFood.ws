function PNDecrementDay()
{
	var items : array<SItemUniqueId>;
	var i : int;
	var currDay : int;
	var _inv : CInventoryComponent;
	
	_inv = thePlayer.GetInventory();
	
	_inv.GetAllItems(items);
	
	for(i=items.Size()-1; i>=0; i-=1)
	{
		if ( PNGetItemAttributeValue(_inv.GetItemAttributeValue( items[i], 'expire' )) <= 0 && !_inv.ItemHasTag(items[i], 'no_expire') ) {
			_inv.AddItemTag( items[i], 'no_expire');
		}
		
		if (_inv.ItemHasTag( items[i], 'Edibles') && !_inv.ItemHasTag( items[i], 'no_expire' )) 
		{
		
		currDay = PNGetItemAttributeValue(_inv.GetItemAttributeValue( items[i], 'expire' ));

			switch(currDay) {
				case 5:
					_inv.RemoveItemBaseAbility(items[i], 'expire_day_5');
					_inv.AddItemBaseAbility(items[i], 'expire_day_4');
					break;
				case 4:
					_inv.RemoveItemBaseAbility(items[i], 'expire_day_4');
					_inv.AddItemBaseAbility(items[i], 'expire_day_3');
					break;
				case 3:
					_inv.RemoveItemBaseAbility(items[i], 'expire_day_3');
					_inv.AddItemBaseAbility(items[i], 'expire_day_2');
					break;
				case 2:
					_inv.RemoveItemBaseAbility(items[i], 'expire_day_2');
					_inv.AddItemBaseAbility(items[i], 'expire_day_1');
					break;
				case 1:
					_inv.RemoveItemBaseAbility(items[i], 'expire_day_1');
					_inv.AddItemBaseAbility(items[i], 'expire_day_0');
					break;
				default: break;
			}
			
			currDay = currDay - 1;
			
			if (currDay <= 0) 
			{
				_inv.RemoveItem( items[i], _inv.GetItemQuantity( items[i] ));
			}
		}
	}
}

function PNGetExpireLevel( _inv : CInventoryComponent, itemId : SItemUniqueId) : float {
	var exp : float;
	
	exp = PNGetItemAttributeValue(_inv.GetItemAttributeValue( itemId, 'expire' ));
	
	if ( exp <= 0 && !_inv.ItemHasTag(itemId, 'no_expire') ) {
		_inv.AddItemTag(itemId, 'no_expire');
		return 0.0 ;
	}
	return exp;
}

function PNUpdateToxicity(_inv : CInventoryComponent, itemId : SItemUniqueId) : bool {
	var itemTox : float;
	var currTox : float;
	var maxTox : float;
	itemTox = CalculateAttributeValue(_inv.GetItemAttributeValue(itemId, 'toxicity'));
	currTox = thePlayer.GetStat(BCS_Toxicity);
	maxTox = thePlayer.GetStatMax(BCS_Toxicity);
	
	if ( currTox + itemTox > maxTox ) {
		GetWitcherPlayer().PNSendToxicityTooHighMessage();
		return false;
	}
	if( itemTox > 0.f )
	{
		if (_inv.ItemHasTag(itemId, 'Drinks') && _inv.GetItemName(itemId) != 'polluted_water') { //modPrimalShallowWater
			thePlayer.abilityManager.DrainToxicity(itemTox * (-1));
		} else {
			thePlayer.abilityManager.GainStat(BCS_Toxicity, itemTox );
		}
	}
	return true;
}

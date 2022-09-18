class ZDRPGUtility: Inventory
{
    Default {
        Inventory.Amount 0;
        Inventory.MaxAmount 1;
        +Inventory.PersistentPower;
    }
}

class ZDRPGMedkitActivator: ZDRPGUtility
{
    override bool Use(bool pickup)
    {
        let Stats = ZDRPGStats.GetStats(owner);
        let PlayerInv = ZDRPGPlayerInventory.GetInventory(owner);
        int missingHealth = Stats.MaxHealth - owner.health;

        if(missingHealth > 0) 
            return MedkitHeal(missingHealth, Stats, PlayerInv);

        console.printf("full health");
        return false;
    }

    bool MedkitHeal(int missingHealth, ZDRPGStats Stats, ZDRPGPlayerInventory PlayerInv)
    {
        if(PlayerInv.Medkit > 0 && PlayerInv.Medkit >= missingHealth) {
            owner.A_SetHealth(Stats.MaxHealth);
            PlayerInv.Medkit -= missingHealth;
            console.printf("healed");
            return true;
        }

        if(PlayerInv.Medkit > 0) {
            owner.GiveBody(PlayerInv.Medkit);
            PlayerInv.Medkit = 0;
            console.printf("partial heal");
            return true;
        }

        console.printf("empty medkit");
        return false;
    }
}

/*class ZDRPGShieldActivator: ZDRPGUtility
{
    override bool Use(bool pickup)
    {
        let Shield = ZDRPGShield(owner.FindInventory("ZDRPGShield"));
        if(Shield)
        {
            Shield.ShieldActive = false;
            console.printf("Active: " .. Shield.ShieldActive);
        }
        return true;
    }
}*/

class ZDRPGWeaponSpeedScaling: ZDRPGUtility
{
    private PSpriteSpeedScalerSet scalers;
	
	override void Tick() {
		Super.Tick();
		
		if (Owner && Owner.player && Owner.player.ReadyWeapon)
        {
            let Stats = ZDRPGStats.GetStats(owner);
			scalers.Tick(Owner.player.ReadyWeapon, Stats.WeaponSpeed*-1);
        }
		else if (scalers.first)
			scalers.Clear();
	}
}

// Lewisk3: You can "block" saving by giving the player an inventory item which contains a CVar. CVars cannot be serialized into saves.
// May be useful to block saving in arena waves
class BlockSaves : Inventory
{
  CVar myCVar;
  override void DoEffect()
  {
    super.DoEffect();
    if(!myCVar) myCVar = CVar.GetCVar("somerandomcvar");
  }
}
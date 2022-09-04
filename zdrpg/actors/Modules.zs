class ZDRPGModules: Inventory
{
    Default {
        Inventory.Amount 1;
        Inventory.MaxAmount 1000000000;

        Scale 0.33;
    
        Inventory.PickupMessage "You got some Upgrade Modules!";
        Inventory.PickupSound "items/module";
        
        +INVENTORY.ALWAYSPICKUP;
        +INVENTORY.TRANSFER;
    }

    override bool TryPickup (in out Actor toucher) 
	{
        let Inventory = ZDRPGPlayerInventory(toucher.FindInventory("ZDRPGPlayerInventory"));
        Inventory.Modules += self.Amount;
        return false;
	}
}
/*
actor DRPGModulePickup : CustomInventory
{
    var int user_amount;
    
    Scale 0.33
    
    Inventory.MaxAmount 0
    Inventory.PickupMessage "You got some Upgrade Modules!"
    Inventory.PickupSound "items/module"
    
    +INVENTORY.ALWAYSPICKUP
    +INVENTORY.TRANSFER
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        TNT1 A 0 A_SetUserVar("user_amount", ((Random((((CallACS("GetAveragePlayerLevel") + 1.0) * 100.0) * (CallACS("GetModuleSpawnFactor") / 100.0)) / 12.0, (((CallACS("GetAveragePlayerLevel") + 1.0) * 100.0) * (CallACS("GetModuleSpawnFactor") / 100.0)) / 3.0 )) + 25) / 25 * 25)
        TNT1 A 0 A_GiveInventory("DRPGModule", user_amount)
        TNT1 A 0 ACS_NamedExecuteAlways("ModulePopoffs", 0)
    SpawnLoop:
        UMOD ABCDEFGHIJKLMNO 4 Bright
        Loop
    }
}
*/
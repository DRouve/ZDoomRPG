// Generic Loot base
class ZDRPGLoot : Inventory
{
    Default
    {
        Inventory.Amount 1;
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "Got a Generic Loot item.";
        Inventory.PickupSound "items/loot";
        
        +COUNTITEM;
    }

    override bool TryPickup (in out Actor toucher)
    {
        if(toucher.Player)
        {
            let missionController = ZDRPGMissionController(toucher.FindInventory("ZDRPGMissionController"));
            if(missionController)
                if(missionController.mission && missionController.mission.isActive)
                    if(missionController.mission.Type == "Find Items" || missionController.mission.Item == self.GetClassName())
                    {
                        missionController.mission.CurrentAmount++;
                    }
        }
        super.TryPickup(toucher);
        return true;
    }
    
}

// Medical Supplies
class ZDRPGLootMedicalSupplies : ZDRPGLoot
{
    Default
    {
        Inventory.PickupMessage "Got Medical Supplies.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT01 A -1;
            Stop;
    }
}

// Chemicals
class ZDRPGLootChemicals : ZDRPGLoot
{
    Default
    {
        Scale 0.25;
        Inventory.PickupMessage "Got Chemicals.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT02 A -1;
            Stop;
    }
}

// Hazardous Materials
class ZDRPGLootHazardousMaterials : ZDRPGLoot
{
    Default
    {
        Inventory.PickupMessage "Got Hazardous Materials.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT03 A -1;
            Stop;
    }
}

// Anomalous Materials
class ZDRPGLootAnomalousMaterials : ZDRPGLoot
{
    Default
    {
        Scale 0.75;
    
        Inventory.PickupMessage "Got Anomalous Materials.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT04 A -1;
            Stop;
    }
}

// Briefcase Data
class ZDRPGLootBriefcase : ZDRPGLoot
{
    Default
    {
        Inventory.PickupMessage "Got Briefcase.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT05 A -1;
            Stop;
    }
}

// Computer Data
class ZDRPGLootComputerData : ZDRPGLoot
{
    Default
    {
        Scale 0.33;
        Inventory.PickupMessage "Got Computer Data.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT06 A -1;
            Stop;
    }
}

// Gun Parts
class ZDRPGLootGunParts : ZDRPGLoot
{
    Default
    {
        Scale 0.75;
    
        Inventory.PickupMessage "Got Gun Parts.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT07 A -1;
            Stop;
    }
}

// Ammo Casings
class ZDRPGLootAmmoCasings : ZDRPGLoot
{
    Default
    {
        Scale 0.75;
    
        Inventory.PickupMessage "Got Ammo Casings.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT08 A -1;
            Stop;
    }
}

// Fuel Capsule
class ZDRPGLootFuelCapsule : ZDRPGLoot
{
    Default
    {
        Scale 0.75;
    
        Inventory.PickupMessage "Got Fuel Capsule.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT09 A -1;
            Stop;
    }
}

// Scrap Metals
class ZDRPGLootScrapMetals : ZDRPGLoot
{
    Default
    {
        Scale 0.5;
    
        Inventory.PickupMessage "Got Scrap Metals.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT10 A -1;
            Stop;
    }
}

// Scrap Electronics
class ZDRPGLootScrapElectronics : ZDRPGLoot
{
    Default
    {
        Scale 0.5;
    
        Inventory.PickupMessage "Got Scrap Electronics.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT11 A -1;
            Stop;
    }
}

// Experimental Parts
class ZDRPGLootExperimentalParts : ZDRPGLoot
{
    Default
    {
        Scale 0.75;
    
        Inventory.PickupMessage "Got Experimental Parts.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT12 AB 6;
            Goto Spawn+1;
    }
}

// Demon Artifact
class ZDRPGLootDemonArtifact : ZDRPGLoot
{
    Default
    {
        Scale 0.85;
    
        Inventory.PickupMessage "Got Demon Artifact.";
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            LT13 A -1;
            Stop;
    }
}

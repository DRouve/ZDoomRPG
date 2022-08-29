/* ARMOR ITEMS

    Armor Bonus - Adds 1 to current Armor

    - Normal -
    Green       100, 10%
    Blue        100, 25%
    Yellow      200, 50%
    Red         200, 75%
    White       200, 100%

    - Reinforced -
    Green       200, 10%
    Blue        200, 25%
    Yellow      400, 50%
    Red         400, 75%
    White       400, 100%

*/

// Armor Bonus
class ZDRPGArmorBonus : ArmorBonus
{
    Default
    {
        Inventory.PickupSound "items/helmet";
    }
}

// Normal Armors
// --------------------------------------------------

// Green Armor
class ZDRPGGreenArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARM1";
        
        Armor.SavePercent 10;
        Armor.SaveAmount 100;
    }
    
}

class ZDRPGGreenArmor : Inventory
{
    Default
    {
        Tag "Green Armor - 10% Damage Protection";
    
        //+INVBAR;
        
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You got Green Combat Armor!";
        Inventory.PickupSound "items/armor";
        Inventory.UseSound "items/armor";
        Inventory.Icon "ARM1";
    }   
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARM1 A 6;
            ARM1 B 6 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGGreenArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Blue Armor
class ZDRPGBlueArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARM2";
        
        Armor.Savepercent 25;
        Armor.Saveamount 100;
    }
}

class ZDRPGBlueArmor : Inventory
{
    Default
    {
        Tag "Blue Armor - 25% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You got Blue Combat Armor!";
        Inventory.PickupSound "items/armor";
        Inventory.UseSound "items/armor";
        Inventory.Icon "ARM2";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARM2 A 6;
            ARM2 B 6 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGBlueArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Yellow Armor
class ZDRPGYellowArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARM3";
        
        Armor.Savepercent 50;
        Armor.Saveamount 200;
    }
}

class ZDRPGYellowArmor : Inventory
{
    Default
    {
        Tag "Yellow Armor - 50% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got Yellow Combat Armor!";
        Inventory.PickupSound "items/armor2";
        Inventory.UseSound "items/armor2";
        Inventory.Icon "ARM3";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARM3 A 6;
            ARM3 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGYellowArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Red Armor
class ZDRPGRedArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARM4";
        
        Armor.Savepercent 75;
        Armor.Saveamount 200;
    }
}

class ZDRPGRedArmor : Inventory
{
    Default
    {
        //Game Doom;
    
        Radius 20;
        Height 16;
        
        Tag "Red Armor - 75% Damage Protection";
        
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got Red Combat Armor!";
        Inventory.PickupSound "items/armor2";
        Inventory.UseSound "items/armor2";
        Inventory.Icon "ARM4";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARM4 A 6;
            ARM4 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGRedArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// White Armor
class ZDRPGWhiteArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARM5";
        
        Armor.Savepercent 100;
        Armor.Saveamount 200;
    }
}

class ZDRPGWhiteArmor : Inventory
{
    Default
    {
        Tag "White Armor - 100% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got White Combat Armor!";
        Inventory.PickupSound "items/armor2";
        Inventory.UseSound "items/armor2";
        Inventory.Icon "ARM5";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARM5 A 6;
            ARM5 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGWhiteArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Reinforced Armors
// --------------------------------------------------

// Reinforced Green Armor
class ZDRPGReinforcedGreenArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARX1";
        
        Armor.SavePercent 10;
        Armor.SaveAmount 200;
    }
}

class ZDRPGReinforcedGreenArmor : Inventory
{
    Default
    {
        Tag "Reinforced Green Armor - 10% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got Reinforced Green Combat Armor!";
        Inventory.PickupSound "items/armor";
        Inventory.UseSound "items/armor";
        Inventory.Icon "ARX1";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARX1 A 6;
            ARX1 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGReinforcedGreenArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Reinforced Blue Armor
class ZDRPGReinforcedBlueArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARX2";
        
        Armor.SavePercent 25;
        Armor.SaveAmount 200;
    }   
}

class ZDRPGReinforcedBlueArmor : Inventory
{
    Default
    {
        Tag "Reinforced Blue Armor - 25% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got Reinforced Blue Combat Armor!";
        Inventory.PickupSound "items/armor";
        Inventory.UseSound "items/armor";
        Inventory.Icon "ARX2";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARX2 A 6;
            ARX2 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGReinforcedBlueArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Reinforced Yellow Armor
class ZDRPGReinforcedYellowArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARX3";
        
        Armor.SavePercent 50;
        Armor.SaveAmount 400;
    }
}

class ZDRPGReinforcedYellowArmor : Inventory 
{
    Default
    {
        Tag "Reinforced Yellow Armor - 50% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got Reinforced Yellow Combat Armor!";
        Inventory.PickupSound "items/armor2";
        Inventory.UseSound "items/armor2";
        Inventory.Icon "ARX3";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARX3 A 6;
            ARX3 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGReinforcedYellowArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Reinforced Red Armor
class ZDRPGReinforcedRedArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARX4";
        
        Armor.SavePercent 75;
        Armor.SaveAmount 400;
    }
}

class ZDRPGReinforcedRedArmor : Inventory
{
    Default
    {
        Tag "Reinforced Red Armor - 75% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got Reinforced Red Combat Armor!";
        Inventory.PickupSound "items/armor2";
        Inventory.UseSound "items/armor2";
        Inventory.Icon "ARX4";
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARX4 A 6;
            ARX4 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGReinforcedRedArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

// Reinforced White Armor
class ZDRPGReinforcedWhiteArmorEffect : BasicArmorPickup
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.Icon "ARX5";
        
        Armor.SavePercent 100;
        Armor.SaveAmount 400;
    }
}

class ZDRPGReinforcedWhiteArmor : Inventory
{
    Default
    {
        Tag "Reinforced White Armor - 100% Damage Protection";
    
        //+INVBAR;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You Got Reinforced White Combat Armor!";
        Inventory.PickupSound "items/armor2";
        Inventory.UseSound "items/armor2";
        Inventory.Icon "ARX5";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            ARX5 A 6;
            ARX5 B 6 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("ShieldRemoveArmor") == 1, "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGReinforcedWhiteArmorEffect", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Stop;
    }
}

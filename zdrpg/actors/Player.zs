class ZDRPGDoomPlayer : DoomPlayer
{
	Default {
        Species "Player";

        Player.ForwardMove 2.0, 1.0;
        Player.SideMove 2.0, 1.0;
        
        Player.MugShotMaxHealth -1;
        
        Player.DamageScreenColor "Green", 1.0, "Slime";
        Player.DamageScreenColor "Green", 1.0, "Radiation";
        Player.DamageScreenColor "Green", 1.0, "Toxicity";

        Player.StartItem "Pistol";
        Player.StartItem "Clip", 51;
        Player.StartItem "Fist";
        
        Player.StartItem "ZDRPGPlayerInventory";
        Player.StartItem "ZDRPGStats";
        
        +THRUSPECIES;
        +QUICKTORETALIATE ;
    }
}
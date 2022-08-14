class PlayerHandler : EventHandler 
{
    override void PlayerSpawned(PlayerEvent e)
    {
        PlayerInfo player = players[e.PlayerNumber];
        player.mo.GiveInventory("ZDRPGStats", 1);
        player.mo.GiveInventory("ZDRPGPlayerInventory", 1);   
        player.mo.GiveInventory("ZDRPGMedkitActivator", 1);   
        player.mo.GiveInventory("ZDRPGShieldActivator", 1);   
    }

    override void NetworkProcess(ConsoleEvent e)
    {
        if (e.Name ~== "UseSkill")
        {
            let item = players[e.Player].mo.FindInventory("ZDRPGHeal");
            if (item)
                item.Use(true);
        }

        if (e.Name ~== "UseMedkit")
        {
            let item = players[e.Player].mo.FindInventory("ZDRPGMedkitActivator");
            if (item)
                item.Use(true);
        }
    }
}
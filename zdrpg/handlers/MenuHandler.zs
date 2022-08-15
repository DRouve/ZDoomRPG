class ZDRPGMenuHandler : EventHandler 
{
    override void NetworkProcess(ConsoleEvent e)
    {
        if (e.IsManual || e.Player < 0 || !PlayerInGame[e.Player] || !(players[e.Player].mo))
            return;

        /*Array<string> command;
        e.Name.Split (command, ":");
    
        if(command [0] ~== "statUp" && command.Size() > 1)
        {
            ZDRPGStats.StatUp(players[e.Player], command[1]);
        }*/

        if (e.Name ~== "statUp")
        {
            let Stats = ZDRPGStats.GetStats(players[e.Player].mo);
            if (Stats && e.Args[0]) 
            {   
                ZDRPGStats.StatUpInt(players[e.Player].mo, e.Args[0]); 
            }
        }
    }
}
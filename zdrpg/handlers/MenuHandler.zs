class ZDRPGMenuHandler : EventHandler 
{
    array <string> mapsList;

    override void NetworkProcess(ConsoleEvent e)
    {
        if (e.IsManual || e.Player < 0 || !PlayerInGame[e.Player] || !(players[e.Player].mo))
            return;

        if (e.Name ~== "statUp")
        {
            let Stats = ZDRPGStats.GetStats(players[e.Player].mo);
            if (Stats && e.Args[0]) 
            {   
                ZDRPGStats.StatUpInt(players[e.Player].mo, e.Args[0]); 
            }
        }

        Array<string> command;
        e.Name.Split (command, "#");
    
        if(command [0] ~== "showMaps" && command.Size() > 1)
        {
            mapsList.Clear();
            Array<string> maps;
            command[1].Split (maps, "::");
            for(int i = 0; i<maps.Size();i++)
            {
                mapsList.Push(maps[i]);
            }

            ZDRPG_ZF_TransportMenu link;
            link.setMenu('ZDRPG_ZF_MapsMenu');
        }

        command.Clear();
        e.Name.Split (command, ":");
        
        if(command [0] ~== "changeMap")
        {
            Level.ChangeLevel(command[1]);
        }
    }
}
class ZDRPGMissionController: Inventory
{
    ZDRPGMission mission;
    int OldSecretCount;

    Default {
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
    }

    override void Tick() {
        Super.Tick();
        if(owner && mission && mission.isActive) {
            if(isSecretFound() && mission.Type == "Find Secrets")
                mission.CurrentAmount++;

            if(mission.OldCurrentAmount != mission.CurrentAmount)
            {
                console.printf(mission.Item..": "..mission.CurrentAmount);
                mission.OldCurrentAmount = mission.CurrentAmount;
            }
            if(mission.CurrentAmount >= mission.Amount) {
                if(mission.Type == "Collection")
                    owner.TakeInventory(mission.Item, mission.Amount);
                owner.GiveInventory("ZDRPGCredits", mission.RewardCredits);
                owner.GiveInventory("ZDRPGModules", mission.RewardModules);
                console.printf("Mission complete!");
                mission.Destroy();
            }
        }

        // resets OldSecretCount every map
        if(owner.player.secretcount == 0 && OldSecretCount != 0)
        {
            OldSecretCount = 0;
        }

        if(isSecretFound())
        {
            //console.printf("secretfound");
            OldSecretCount = owner.player.secretcount;
        }
    }

    bool isSecretFound()
    {
        // checking "owner.player.secretcount > 0" to avoid false triggering during map change
        return (owner.player.secretcount > 0 && owner.player.secretcount != OldSecretCount);
    }

    //override bool OnGiveSecret(bool printmsg, bool playsound)
    //{
        //super.OnGiveSecret(printmsg, playsound);
        //console.printf("omegalul");
        //return true;
    //}
}

class ZDRPGMission
{
    bool isActive;
    
    int Difficulty;
    // mission type
    string Type;
    // objective/target
    name Item;
    // missions' menu icon
    string Icon;

    int Amount;
    int CurrentAmount;
    int OldCurrentAmount;
    int RewardXP;
    int RewardRank;
    int RewardCredits;
    int RewardModules;
    string RewardItem;

    static ZDRPGMission Start(ZDRPGMission args)
    {
        let instance = ZDRPGMission(args);

        instance.isActive = true;
        instance.OldCurrentAmount = instance.CurrentAmount;
            
        console.printf("%d", instance.Difficulty);
        console.printf(instance.Type);
        console.printf(instance.Item);
        console.printf("%d", instance.Amount);
        console.printf("%d", instance.CurrentAmount);
        console.printf("%d", instance.RewardXP);
        console.printf("%d", instance.RewardRank);
        console.printf("%d", instance.RewardCredits);
        console.printf("%d", instance.RewardModules);
        console.printf(instance.RewardItem);
        
        return instance;
    }
}
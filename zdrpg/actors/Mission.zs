class ZDRPGMissionController: Inventory
{
    ZDRPGMission mission;

    Default {
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
    }

    override void Tick() {
        Super.Tick();
        if(owner && mission && mission.isActive) {
            if(mission.CurrentAmount >= mission.Amount) {
                owner.GiveInventory("ZDRPGCredits", mission.RewardCredits);
                owner.GiveInventory("ZDRPGModules", mission.RewardModules);
                mission.Destroy();
            }
        }
    }
}

class ZDRPGMission
{
    bool isActive;
    
    int Difficulty;
    // mission type
    string Type;
    // objective/target
    string Item;

    int Amount;
    int CurrentAmount;
    int RewardXP;
    int RewardRank;
    int RewardCredits;
    int RewardModules;
    string RewardItem;

    static ZDRPGMission Start(ZDRPGMission args)
    {
        let instance = ZDRPGMission(args);

        instance.isActive = true;
        instance.CurrentAmount = 0;

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
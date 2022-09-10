/*
 * SimpleMenu.ZS:
 * This example shows how to make a simple menu with a background, a text label,
 * and a single-texture button.
 * Clicking the button changes the colour of the text label's text to a random
 * colour.
*/

// The menu's command handler.
// This is needed so we can make our menu interactable.
class ZDRPG_ZF_MissionsMenuHandler : ZDRPG_ZF_Handler
{
    // The menu this command handler belongs to.
    // We need this to be able to do anything with our menu.
    ZDRPG_ZF_MissionsMenu link;
    ZDRPGPlayerHandler playerHandler; 

    override void buttonClickCommand (ZDRPG_ZF_Button caller, Name command)
    {
        if(command == "abortMission")
            playerHandler.SendNetworkEvent(command);

        string commandString = command;
        Array <String> commandSplit;
        commandString.split(commandSplit, ":");
        if(commandSplit[0] ~== "showMission" && commandSplit.Size() > 1)
        {
            let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));
            let missionIndex = commandSplit[1].ToInt();
            let mission = eHandler.missions[missionIndex];

            let descriptionFrame = ZDRPG_ZF_Frame(link.mainFrame.elements[0]);
            let missionInfoFrame = ZDRPG_ZF_Frame(descriptionFrame.elements[2]);
            let rewardInfoFrame = ZDRPG_ZF_Frame(descriptionFrame.elements[3]);

            let selectMissionLabel = ZDRPG_ZF_Label(descriptionFrame.elements[1]);
            selectMissionLabel.hide();

            missionInfoFrame.show();
            rewardInfoFrame.show();

            let missionType = ZDRPG_ZF_Label(missionInfoFrame.elements[0]);
            let missionAmount = ZDRPG_ZF_Label(missionInfoFrame.elements[1]);
            let missionTarget = ZDRPG_ZF_Label(missionInfoFrame.elements[2]);

            let missionAmountOriginPos = missionAmount.GetPos();
            let missionTargetOriginPos = missionTarget.GetPos();

            missionTarget.hide();
            class<Actor> isActor = (class<Actor>)(mission.Item);
            if(isActor)
            {
                let actorDefaults = GetDefaultByType((class<Actor>)(mission.Item));
                missionTarget.SetText("Target : " .. actorDefaults.GetTag());
                missionTarget.show();

                // if mission has monster or item target and "Target" label is below "Amount" label 
                if(missionTarget.GetPosY() > missionAmount.GetPosY())
                {
                    missionAmount.SetPos(missionTargetOriginPos);
                    missionTarget.SetPos(missionAmountOriginPos);
                }
            }
            else if(missionTarget.GetPosY() < missionAmount.GetPosY())
            {
                // if "Target" label is higher than "Amount" label and mission's Item isn't an actor, i.e. Find Items, Find Secrets etc.
                missionAmount.SetPos(missionTargetOriginPos);
                missionTarget.SetPos(missionAmountOriginPos);
            }

            missionType.SetText("Type : " .. mission.Type);
            missionAmount.SetText("Amount : " .. mission.Amount);

            let rewardXP = ZDRPG_ZF_Label(rewardInfoFrame.elements[0]);
            let rewardRank = ZDRPG_ZF_Label(rewardInfoFrame.elements[1]);
            let rewardCredits = ZDRPG_ZF_Label(rewardInfoFrame.elements[2]);

            rewardXP.SetText("XP : " .. mission.RewardXP);
            rewardRank.SetText("Rank : " .. mission.RewardRank);
            rewardCredits.SetText("Credits : " .. mission.RewardCredits);

            let addMissionButton = ZDRPG_ZF_Button(descriptionFrame.elements[4]);
            let abortMissionButton = ZDRPG_ZF_Button(descriptionFrame.elements[5]);
            
            let missionController = ZDRPGMissionController(players[consoleplayer].mo.FindInventory("ZDRPGMissionController"));

            abortMissionButton.hide();
            if(missionController.mission)
                abortMissionButton.show();

            let encodedMission = "Id="..missionIndex.."&Difficulty="..mission.Difficulty.."&Type="..mission.Type.."&Item="..mission.Item.."&Amount="..mission.Amount.."&RewardXP="..mission.RewardXP.."&RewardRank="..mission.RewardRank.."&RewardCredits="..mission.RewardCredits.."&RewardModules="..mission.RewardModules.."&RewardItem="..mission.RewardItem;

            descriptionFrame.setDontBlockMouse(true);
            missionInfoFrame.setDontBlockMouse(true);
            addMissionButton.setCommand('addMission:'.. encodedMission);
            addMissionButton.show();
        }

        if(commandSplit[0] ~== "addMission" && commandSplit.Size() > 1)
        {
            let missionController = ZDRPGMissionController(players[consoleplayer].mo.FindInventory("ZDRPGMissionController"));
            if(missionController.mission)
                console.printf("mission already exist");
            else
            {
                // send network even to accept mission
                playerHandler.SendNetworkEvent(commandString);

                Array <String> paramSplit;
                commandString.split(paramSplit, "&");
                let difficulty = ZDRPGMissionHandler.GetParameter(paramSplit[1]).ToInt();
                let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));
                
                //let missionElementFrame = caller.getMaster();
                let difficultyPageFrame = ZDRPG_ZF_Frame(link.mainFrame.elements[difficulty+1]);

                // remove accepted mission from missions' array and menu
                eHandler.missions[ZDRPGMissionHandler.GetParameter(paramSplit[0]).ToInt()].destroy();

                // remove all missions in current frame
                for(int i = 0; i < difficultyPageFrame.elements.Size(); i++)
                {
                    if(difficultyPageFrame.elements[i] is "ZDRPG_ZF_Frame")
                        difficultyPageFrame.elements[i].destroy();
                }

                // re-add missions again (to refresh grid)
                link.createMissionBoxes(difficulty, (1920, 1080), difficultyPageFrame);
            }
        }

        if(commandSplit[0] ~== "getPage" && commandSplit.Size() > 1)
        {
            let descriptionFrame = ZDRPG_ZF_Frame(link.mainFrame.elements[0]);
            let missionInfoFrame = ZDRPG_ZF_Frame(descriptionFrame.elements[2]);
            let rewardInfoFrame = ZDRPG_ZF_Frame(descriptionFrame.elements[3]);

            missionInfoFrame.hide();
            rewardInfoFrame.hide();

            let addMissionButton = ZDRPG_ZF_Button(descriptionFrame.elements[4]);
            addMissionButton.hide();

            let abortMissionButton = ZDRPG_ZF_Button(descriptionFrame.elements[5]);
            abortMissionButton.hide();

            let selectMissionLabel = ZDRPG_ZF_Label(descriptionFrame.elements[1]);
            selectMissionLabel.show();

            for(int i = 0; i < link.framesList.Size(); i++)
            {
                link.framesList[i].hide();
            }
            link.framesList[commandSplit[1].ToInt()].show();
            
        }
    }
}

class ZDRPG_ZF_MissionsMenu : ZDRPG_ZF_GenericMenu
{
    // The menu's command handler.
    // We need a command handler so we can make our menu interactable.
    ZDRPG_ZF_MissionsMenuHandler handler;

    // A font to use for text.
    Font smallFont;

    // A background image.
    ZDRPG_ZF_Image background;
    // A simple single-texture button.
    ZDRPG_ZF_Button aButton;
    // A text label.
    ZDRPG_ZF_Label aLabel;

    array <ZDRPG_ZF_Frame> framesList;

    override void Init (Menu parent)
    {
        Vector2 baseRes = (1920, 1080);

        // Call GenericMenu's 'Init' function to do some required initialization.
        Super.Init (parent);
        menuactive = Menu.On;
        // Set our base resolution to 320x200.
        SetBaseResolution (baseRes);

        // Get GZDoom's new options menu smallfont.
        smallFont = OptionFont ();

        // Create an instance of the handler.
        handler = new ('ZDRPG_ZF_MissionsMenuHandler');
        // Set the handler's "link" pointer to us.
        handler.link = self;

        // Add a background.
        /*background = ZDRPG_ZF_Image.Create
        (
            // Position
            (0, 0),
            // Size
            (1920, 1080),
            // Image path/name
            "graphics/ZFormsExamples/Panel.png",
            // Alignment options
            ZDRPG_ZF_Image.AlignType_TopLeft
        );
        // Add the image element into the main frame.
        background.Pack (mainFrame);*/

        // Create the box image's textures.

        createDescriptionBox(baseRes);

        array <int> blocksCount;
        array <int> rowsCount;

        let Stats = ZDRPGStats(players [consoleplayer].mo.FindInventory("ZDRPGStats")); 

        let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));
        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));

        if(eHandler.Missions.Size() > 0)
        {
            let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
            let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
            let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);
            
            for(int j = 0; j < staticHandler.missionDifficulties.Size(); j++)
            {
                let difficultyPageFrame = ZDRPG_ZF_Frame.create(
                    (0, 0),
                    baseRes
                );
                difficultyPageFrame.setDontBlockMouse(true);
                difficultyPageFrame.pack(mainFrame);

                createMissionBoxes(j, baseRes, difficultyPageFrame);

                if(j+1 < staticHandler.missionDifficulties.Size() && j < Stats.RankLvl / 2.0 - 1.0)
                {
                    // Add a button.
                    aButton = ZDRPG_ZF_Button.Create
                    (
                        // Position
                        //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
                        (1880, 20),
                        // Size
                        (18, 18),
                        // Our command handler
                        cmdHandler: handler,
                        // A command string for the button
                        command: "getPage:"..j+1,
                        // The button's textures
                        inactive: buttonIdle,
                        hover: buttonHover,
                        click: buttonClick
                    );
                    // Add the button element into the main frame.
                    aButton.Pack (difficultyPageFrame);
                }
                
                if(j-1 >= 0)
                {
                    // Add a button.
                    aButton = ZDRPG_ZF_Button.Create
                    (
                        // Position
                        //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
                        (20, 20),
                        // Size
                        (18, 18),
                        // Our command handler
                        cmdHandler: handler,
                        // A command string for the button
                        command: "getPage:"..j-1,
                        // The button's textures
                        inactive: buttonIdle,
                        hover: buttonHover,
                        click: buttonClick
                    );
                    
                    // Add the button element into the main frame.
                    aButton.Pack (difficultyPageFrame);
                }

                // Add a label.
                aLabel = ZDRPG_ZF_Label.Create
                (
                    // Position
                    (950, 20),
                    // Size.
                    (0, smallFont.GetHeight ()),
                    // The label's text
                    text: staticHandler.missionDifficulties[j],
                    // The font to use
                    fnt: smallFont,
                    // Whether to automatically wrap the text or not
                    wrap: false,
                    // Whether to automatically resize the element based on the text width
                    autoSize: true,
                    // The text's colour
                    textColor: Font.CR_WHITE
                );
                // Add the label element to the main frame.
                aLabel.Pack (difficultyPageFrame);

                blocksCount.Clear();
                rowsCount.Clear();
                difficultyPageFrame.hide();
                
                framesList.Push(difficultyPageFrame);
                
            }

            framesList[0].show();
        }
    }

    void createDescriptionBox(Vector2 baseRes)
    {
        int descriptionFrameOffset = 75;

        let descriptionFrame = ZDRPG_ZF_Frame.create(
            (descriptionFrameOffset, baseRes.y - (baseRes.y * 0.5)),
            (baseRes.x - 2*descriptionFrameOffset, baseRes.y - (baseRes.y * 0.5) - 100)
        );
        descriptionFrame.pack(mainFrame); // index: 0

        let boxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureGreen.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );

        let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            descriptionFrame.getSize(),
            // Texture
            boxTexture,
            // Scale
            (0.25, 0.25)
        );

        aBoxImage.pack(descriptionFrame); // index: 0

        let descriptionFrameSize = descriptionFrame.getSize();

        // Add a label.
        aLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (descriptionFrameSize.x * 0.5 - 50, descriptionFrameSize.y * 0.5 - smallFont.GetHeight()),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "Select mission",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        aLabel.pack(descriptionFrame); // index: 1

        let missionInfoBox = CreateMissionInfoBox(descriptionFrame);
        let missionRewardBox = CreateMissionRewardBox(descriptionFrame, missionInfoBox);

        missionInfoBox.setDontBlockMouse(true);
        missionRewardBox.setDontBlockMouse(true);

        missionInfoBox.hide();
        missionRewardBox.hide();

        let addMissionButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (descriptionFrameSize.x * 0.5 - 172, descriptionFrameSize.y * 0.75),
            // Size
            (345, 50),
            // Our command handler
            text: "Accept mission",
            cmdHandler: handler,
            // A command string for the button
            command: 'addMission:0',
            fnt: bigFont,
            textScale: 2,
            textColor: Font.CR_GREEN
        );

        // Add the button element into the main frame.
        addMissionButton.Pack (descriptionFrame); // index: 4

        addMissionButton.hide();

        let abortMissionButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (descriptionFrameSize.x * 0.5 - 275, addMissionButton.GetPosY() + bigFont.GetHeight() * 3),
            // Size
            (550, 50),
            // Our command handler
            text: "Abort current mission",
            cmdHandler: handler,
            // A command string for the button
            command: 'abortMission',
            fnt: bigFont,
            textScale: 2,
            textColor: Font.CR_RED
        );

        // Add the button element into the main frame.
        abortMissionButton.Pack (descriptionFrame); // index: 5

        abortMissionButton.hide();

        
    }

    ZDRPG_ZF_Frame CreateMissionInfoBox(ZDRPG_ZF_Frame descriptionFrame)
    {
        int descriptionFrameOffset = 75;
        let descriptionFrameSize = descriptionFrame.getSize();

        let missionInfoFrame = ZDRPG_ZF_Frame.create(
            (40, 40),
            (descriptionFrameSize.x - (descriptionFrameSize.x * 0.5) - 60, descriptionFrameSize.y - descriptionFrameOffset - 40)
        );
        missionInfoFrame.pack(descriptionFrame); // index: 2

        let missionInfoBoxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureBlue.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );

        let missionInfoBox = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            missionInfoFrame.getSize(),
            // Texture
            missionInfoBoxTexture,
            // Scale
            (0.25, 0.25)
        );

        //missionInfoBox.pack(missionInfoFrame); // index: 0

        // Add a label.
        let missionType = ZDRPG_ZF_Label.Create
        (
            // Position
            (75, 75),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        missionType.pack(missionInfoFrame); // index: 0

        // Add a label.
        let missionAmount = ZDRPG_ZF_Label.Create
        (
            // Position
            (missionType.GetPosX(), missionType.GetPosY() + smallFont.GetHeight() * 2), 
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        missionAmount.pack(missionInfoFrame); // index: 1

        // Add a label.
        let missionTarget = ZDRPG_ZF_Label.Create
        (
            // Position
            (missionAmount.GetPosX(), missionAmount.GetPosY() + smallFont.GetHeight() * 2), 
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        missionTarget.pack(missionInfoFrame); // index: 2
        //missionTarget.hide();

        return missionInfoFrame;
    }

    ZDRPG_ZF_Frame CreateMissionRewardBox(ZDRPG_ZF_Frame descriptionFrame, ZDRPG_ZF_Frame missionInfoFrame)
    {
        int descriptionFrameOffset = 75;
        let descriptionFrameSize = descriptionFrame.getSize();
        let missionInfoFrameSize = missionInfoFrame.getSize();

        let missionInfoFrame = ZDRPG_ZF_Frame.create(
            (missionInfoFrameSize.x + 60, 40),
            (descriptionFrameSize.x - (descriptionFrameSize.x * 0.5) - 40, descriptionFrameSize.y - descriptionFrameOffset - 40)
        );
        missionInfoFrame.pack(descriptionFrame); // index: 3

        let missionInfoBoxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureRed.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );

        let missionInfoBox = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            missionInfoFrame.getSize(),
            // Texture
            missionInfoBoxTexture,
            // Scale
            (0.25, 0.25)
        );

        //missionInfoBox.pack(missionInfoFrame); // index: 0

        // Add a label.
        let rewardXP = ZDRPG_ZF_Label.Create
        (
            // Position
            (75, 75),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "XP : 10000",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        rewardXP.pack(missionInfoFrame); // index: 1

        // Add a label.
        let rewardRank = ZDRPG_ZF_Label.Create
        (
            // Position
            (rewardXP.GetPosX(), rewardXP.GetPosY() + smallFont.GetHeight() * 2), 
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "Rank : 5000",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        rewardRank.pack(missionInfoFrame); // index: 2

        // Add a label.
        let rewardCredits = ZDRPG_ZF_Label.Create
        (
            // Position
            (rewardRank.GetPosX(), rewardRank.GetPosY() + smallFont.GetHeight() * 2), 
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "Credits : 750",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        rewardCredits.pack(missionInfoFrame); // index: 3

        return missionInfoFrame;
    }

    void createMissionBoxes(int difficulty, Vector2 baseRes, ZDRPG_ZF_Frame difficultyPageFrame)
    {
        array <int> blocksCount;
        array <int> rowsCount;

        let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));

        for(int i=0; i<eHandler.Missions.Size(); i++)
        {
            let mission = eHandler.Missions[i];
            if(mission && mission.Difficulty == difficulty)
            {
                string missionText;
                let encodedMission = "Id="..i.."&Difficulty="..mission.Difficulty.."&Type="..mission.Type.."&Item="..mission.Item.."&Amount="..mission.Amount.."&RewardXP="..mission.RewardXP.."&RewardRank="..mission.RewardRank.."&RewardCredits="..mission.RewardCredits.."&RewardModules="..mission.RewardModules.."&RewardItem="..mission.RewardItem;
                class<Actor> isActor = (class<Actor>)(mission.Item);
                if(isActor)
                {
                    let monsterDefaults = GetDefaultByType((class<Actor>)(mission.Item));
                    missionText = mission.Type..": "..monsterDefaults.GetTag()..": "..mission.Amount;
                }
                else
                {
                    missionText = mission.Type..": "..mission.Amount;
                }
                //CreateStatBox(missionText, "addMission:"..encodedMission, baseRes, blocksCount, rowsCount, difficultyPageFrame);
                //CreateStatBox(missionText, "addMission:"..encodedMission, mission.Icon, baseRes, blocksCount, rowsCount, difficultyPageFrame);
                CreateStatBox(missionText, "showMission:"..i, mission.Icon, baseRes, blocksCount, rowsCount, difficultyPageFrame);
            }
        }
    }

    void CreateStatBox(string labelText, string commandName, string img, Vector2 baseRes, out array <int> blocksCount, out array <int> rowsCount, ZDRPG_ZF_Frame frame) 
    {
        
        let boxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureGreen.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );

        let offsetY = 75;
        // Add a box image.
        let boxSize = (128, 128);
        if((50 + boxSize.X) * blocksCount.Size() > baseRes.X)
        {
            blocksCount.Clear();
            rowsCount.Push(1);
        }
        let boxOffset = offsetY + boxSize.X * blocksCount.Size();
        let boxInnerOffset = blocksCount.Size() * 32;

        let buttonFrame = ZDRPG_ZF_Frame.create(
            (boxOffset + boxInnerOffset, offsetY + (rowsCount.Size() * (boxSize.X + 32))),
            boxSize
        );

        buttonFrame.pack(frame);

        background = ZDRPG_ZF_Image.Create
        (
            // Position
            (0, 0),
            // Size
            (128, 128),
            // Image path/name
            "graphics/bbs/" .. img,
            // Alignment options
            ZDRPG_ZF_Image.AlignType_TopLeft,
            (4, 4)
        );
        // Add the image element into the main frame.
        background.Pack (buttonFrame);

        /*let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            boxSize,
            // Texture
            boxTexture,
            // Scale
            (0.25, 0.25)
        );
        // Add the box image element into the main frame.
        aBoxImage.Pack (buttonFrame);*/

        // Create the button's textures.
        let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
        let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
        let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);

        let buttonSideSize = 128;
        let buttonPosX = boxOffset + boxInnerOffset + background.GetWidth() / 2 - buttonSideSize / 2;
        let buttonPosY = offsetY + (rowsCount.Size() * (boxSize.X + 32)) + background.GetHeight() / 2 - buttonSideSize / 2;

        // Add a button.
        aButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (0, 0),
            // Size
            (buttonSideSize, buttonSideSize),
            // Our command handler
            cmdHandler: handler,
            // A command string for the button
            command: commandName
            // The button's textures
            //inactive: buttonIdle,
            //hover: buttonHover,
            //click: buttonClick
        );
        // Add the button element into the main frame.
        aButton.Pack (buttonFrame);

        // Add a label.
        aLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, 0),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: labelText,
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );
        // Calculate the horizontal position for the label so that it's centered on the screen.
        aLabel.SetPosX (aButton.GetPosX () - smallFont.stringWidth (aLabel.GetText ()));
        // Add the label element to the main frame.
        aLabel.Pack (buttonFrame);

        blocksCount.Push(1);
    }
}

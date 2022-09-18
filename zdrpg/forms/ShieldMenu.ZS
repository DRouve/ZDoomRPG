/*
 * SimpleMenu.ZS:
 * This example shows how to make a simple menu with a background, a text label,
 * and a single-texture button.
 * Clicking the button changes the colour of the text label's text to a random
 * colour.
*/

// The menu's command handler.
// This is needed so we can make our menu interactable.
class ZDRPG_ZF_ShieldMenuHandler : ZDRPG_ZF_Handler
{
    // The menu this command handler belongs to.
    // We need this to be able to do anything with our menu.
    ZDRPG_ZF_ShieldMenu link;
    ZDRPGPlayerHandler playerHandler; 

    override void buttonClickCommand (ZDRPG_ZF_Button caller, Name command)
    {
        string commandString = command;
        Array <String> commandSplit;
        commandString.split(commandSplit, ":");

        if(commandSplit[0] ~== "showDescription" && commandSplit.Size() > 1)
        {
            let shieldClassName = commandSplit[1];
            let itemDefaults = GetDefaultByType((class<ZDRPGShieldPart>)(shieldClassName));

            let descriptionFrame = ZDRPG_ZF_Frame(link.mainFrame.elements[0]);
            let shieldInfoFrame = ZDRPG_ZF_Frame(descriptionFrame.elements[2]);
            let listFrame = ZDRPG_ZF_Frame(shieldInfoFrame.elements[0]);

            let selectShieldLabel = ZDRPG_ZF_Label(descriptionFrame.elements[1]);
            selectShieldLabel.hide();

            shieldInfoFrame.show();
            //rewardInfoFrame.show();

            let shieldName       = ZDRPG_ZF_Label(listFrame.elements[0]);
            let shieldCapacity   = ZDRPG_ZF_Label(listFrame.elements[1]);
            let shieldChargeRate = ZDRPG_ZF_Label(listFrame.elements[2]);
            let shieldDelay      = ZDRPG_ZF_Label(listFrame.elements[3]);

            /*
            let shieldCapacityOriginPos   = shieldCapacity.GetPos();
            let shieldChargeRateOriginPos = shieldChargeRate.GetPos();
            let shieldDelayOriginPos      = shieldDelay.GetPos();

            if(itemDefaults.Capacity == 0 && itemDefaults.ChargeRate != 0)
            {
                shieldChargeRate.SetPos(shieldCapacityOriginPos);
                shieldDelay.SetPos(shieldChargeRateOriginPos);
            }
            else if(itemDefaults.Capacity == 0 && itemDefaults.ChargeRate == 0 && itemDefaults.Delay != 0)
            {
                shieldDelay.SetPos(shieldCapacityOriginPos);
            }
            else if(itemDefaults.Capacity != 0 && itemDefaults.ChargeRate == 0 && itemDefaults.Delay != 0)
            {
                shieldDelay.SetPos(shieldChargeRateOriginPos);
            }*/

            //missionTarget.hide();
            /*class<Actor> isActor = (class<Actor>)(mission.Item);
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
            }*/
            //if(shieldCapacity.getMaster())
                shieldCapacity.hide();
            //if(shieldChargeRate.getMaster())
                shieldChargeRate.hide();
            //if(shieldDelay.getMaster())
                shieldDelay.hide();

            shieldName.SetText(itemDefaults.GetTag());
            
            if(itemDefaults.Capacity != 0)
            {
                //if(!shieldCapacity.getMaster())
                shieldCapacity.show();
                shieldCapacity.SetText("Capacity : " .. itemDefaults.Capacity);
            }
                
            if(itemDefaults.ChargeRate != 0)
            {
                //if(!shieldChargeRate.getMaster())
                shieldChargeRate.show();
                shieldChargeRate.SetText("Charge Rate : " .. itemDefaults.ChargeRate);
            }
                
            if(itemDefaults.Delay != 0)
            {
                //if(!shieldDelay.getMaster())
                shieldDelay.show();
                shieldDelay.SetText("Delay : " .. String.Format("%.1f", itemDefaults.Delay));
            }
                
                
            //let rewardXP = ZDRPG_ZF_Label(rewardInfoFrame.elements[0]);
            //let rewardRank = ZDRPG_ZF_Label(rewardInfoFrame.elements[1]);
            //let rewardCredits = ZDRPG_ZF_Label(rewardInfoFrame.elements[2]);

            //rewardXP.SetText("XP : " .. mission.RewardXP);
            //rewardRank.SetText("Rank : " .. mission.RewardRank);
            //rewardCredits.SetText("Credits : " .. mission.RewardCredits);

            let equipShieldButton = ZDRPG_ZF_Button(descriptionFrame.elements[3]);
            equipShieldButton.setText("Equip");

            let Shield = ZDRPGShield(players[consoleplayer].mo.FindInventory("ZDRPGShield"));
            if(Shield.Body && Shield.Body.GetClassName() == shieldClassName || Shield.Battery && Shield.Battery.GetClassName() == shieldClassName || Shield.Capacitor && Shield.Capacitor.GetClassName() == shieldClassName)
            {
                equipShieldButton.setText("Unequip");
            }
            //let abortMissionButton = ZDRPG_ZF_Button(descriptionFrame.elements[5]);
            
            //let missionController = ZDRPGMissionController(players[consoleplayer].mo.FindInventory("ZDRPGMissionController"));

            //abortMissionButton.hide();
            //if(missionController.mission)
            //    abortMissionButton.show();

            //descriptionFrame.setDontBlockMouse(true);
            //missionInfoFrame.setDontBlockMouse(true);
            equipShieldButton.setCommand("equipShield:".. shieldClassName);
            equipShieldButton.show();
        }
    
        if(commandSplit[0] ~== "equipShield" && commandSplit.Size() > 1)
        {
            playerHandler.SendNetworkEvent(command);

            let descriptionFrame = ZDRPG_ZF_Frame(link.mainFrame.elements[0]);
            let equipShieldButton = ZDRPG_ZF_Button(descriptionFrame.elements[3]);
            equipShieldButton.setText("Unequip");
        }

        if(commandSplit[0] ~== "getPage" && commandSplit.Size() > 1)
        {
            let descriptionFrame = ZDRPG_ZF_Frame(link.mainFrame.elements[0]);
            let shieldInfoFrame = ZDRPG_ZF_Frame(descriptionFrame.elements[2]);
            //let rewardInfoFrame = ZDRPG_ZF_Frame(descriptionFrame.elements[3]);

            shieldInfoFrame.hide();
            //rewardInfoFrame.hide();

            let equipShieldButton = ZDRPG_ZF_Button(descriptionFrame.elements[3]);
            equipShieldButton.hide();

            //let abortMissionButton = ZDRPG_ZF_Button(descriptionFrame.elements[5]);
            //abortMissionButton.hide();

            let selectShieldComponentLabel = ZDRPG_ZF_Label(descriptionFrame.elements[1]);
            selectShieldComponentLabel.show();

            for(int i = 0; i < link.framesList.Size(); i++)
            {
                link.framesList[i].hide();
            }
            link.framesList[commandSplit[1].ToInt()].show();
            
        }
    }
}

class ZDRPG_ZF_ShieldMenu : ZDRPG_ZF_GenericMenu
{
    // The menu's command handler.
    // We need a command handler so we can make our menu interactable.
    ZDRPG_ZF_ShieldMenuHandler handler;

    // A font to use for text.
    Font smallFont;

    // A background image.
    ZDRPG_ZF_Image background;
    // A simple single-texture button.
    ZDRPG_ZF_Button aButton;
    // A text label.
    ZDRPG_ZF_Label aLabel;

    ZDRPG_ZF_BoxTextures buttonIdle;
    ZDRPG_ZF_BoxTextures buttonHover;
    ZDRPG_ZF_BoxTextures buttonClick;

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
        handler = new ('ZDRPG_ZF_ShieldMenuHandler');
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

        let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
        let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
        let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);

        createDescriptionBox(baseRes);

        array <int> blocksCount;
        array <int> rowsCount;

        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));

        if(staticHandler.shieldBodies.Size() > 0)
        {
            let shieldBodiesFrame = ZDRPG_ZF_Frame.create(
                (0, 0),
                baseRes
            );
            shieldBodiesFrame.setDontBlockMouse(true);
            shieldBodiesFrame.pack(mainFrame); // index: 1
            framesList.Push(shieldBodiesFrame);

            createPaginationButton("next", 1, shieldBodiesFrame);
            createFrameLabel("Bodies", shieldBodiesFrame);
            listItems(staticHandler.shieldBodies, baseRes, shieldBodiesFrame);
        }

        if(staticHandler.shieldBatteries.Size() > 0)
        {
            let shieldBatteriesFrame = ZDRPG_ZF_Frame.create(
                (0, 0),
                baseRes
            );
            shieldBatteriesFrame.setDontBlockMouse(true);
            shieldBatteriesFrame.pack(mainFrame); // index: 2
            framesList.Push(shieldBatteriesFrame);
            shieldBatteriesFrame.hide();

            createPaginationButton("prev", 0, shieldBatteriesFrame);
            createPaginationButton("next", 2, shieldBatteriesFrame);
            createFrameLabel("Batteries", shieldBatteriesFrame);
            listItems(staticHandler.shieldBatteries, baseRes, shieldBatteriesFrame);
        }

        if(staticHandler.shieldCapacitors.Size() > 0)
        {
            let shieldCapacitorsFrame = ZDRPG_ZF_Frame.create(
                (0, 0),
                baseRes
            );
            shieldCapacitorsFrame.setDontBlockMouse(true);
            shieldCapacitorsFrame.pack(mainFrame); // index: 3 
            framesList.Push(shieldCapacitorsFrame);
            shieldCapacitorsFrame.hide();

            createPaginationButton("prev", 1, shieldCapacitorsFrame);
            createPaginationButton("next", 3, shieldCapacitorsFrame);
            createFrameLabel("Capacitors", shieldCapacitorsFrame);
            listItems(staticHandler.shieldCapacitors, baseRes, shieldCapacitorsFrame);
        }

        if(staticHandler.shieldAccessories.Size() > 0)
        {
            let shieldAccessoriesFrame = ZDRPG_ZF_Frame.create(
                (0, 0),
                baseRes
            );
            shieldAccessoriesFrame.setDontBlockMouse(true);
            shieldAccessoriesFrame.pack(mainFrame); // index: 4
            framesList.Push(shieldAccessoriesFrame);
            shieldAccessoriesFrame.hide();

            createPaginationButton("prev", 2, shieldAccessoriesFrame);
            createFrameLabel("Accessories", shieldAccessoriesFrame);
            listItems(staticHandler.shieldAccessories, baseRes, shieldAccessoriesFrame);
        }
    }

    void listItems(array <string> itemsArray, Vector2 baseRes, ZDRPG_ZF_Frame frame)
    {
        array <int> blocksCount;
        array <int> rowsCount;

        for(int i=0; i < itemsArray.Size(); i++)
        {
            
            let itemDefaults = GetDefaultByType((class<Actor>)(itemsArray[i]));
            let isOwned = ZDRPGShieldPart(players [consoleplayer].mo.FindInventory(itemsArray[i])); 

            let itemSprite = "TNT1";
            string cmd = "";
            if(isOwned)
            {
                itemSprite = TexMan.GetName(itemDefaults.spawnstate.GetSpriteTexture(0));
                cmd = "showDescription:"..itemsArray[i];
            }
            
            CreateStatBox("", cmd, itemSprite, baseRes, blocksCount, rowsCount, frame);
        }
    }

    void createFrameLabel(string text, ZDRPG_ZF_Frame frame)
    {
        // Add a label.
        let frameLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (950, 20),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: text,
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
        frameLabel.Pack (frame);
    }

    void createPaginationButton(string type, int frameIndex, ZDRPG_ZF_Frame frame)
    {
        let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
        let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
        let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);

        let buttonPos = (1880, 20);
        if(type == "prev")
            buttonPos = (20, 20);

        // Add a button.
        let button = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            buttonPos,
            // Size
            (18, 18),
            // Our command handler
            cmdHandler: handler,
            // A command string for the button
            command: "getPage:"..frameIndex,
            // The button's textures
            inactive: buttonIdle,
            hover: buttonHover,
            click: buttonClick
        );
        // Add the button element into the main frame.
        button.Pack(frame);
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
        let selectShieldLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (descriptionFrameSize.x * 0.5 - 50, descriptionFrameSize.y * 0.5 - smallFont.GetHeight()),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "Select shield component",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        selectShieldLabel.pack(descriptionFrame); // index: 1

        let shieldInfoBox = CreateShieldInfoBox(descriptionFrame);
        //let shieldRewardBox = CreateMissionRewardBox(descriptionFrame, missionInfoBox);

        shieldInfoBox.setDontBlockMouse(true);
        //missionRewardBox.setDontBlockMouse(true);

        shieldInfoBox.hide();
        //missionRewardBox.hide();

        let equipShieldButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (descriptionFrameSize.x * 0.5 - 172, descriptionFrameSize.y * 0.75),
            // Size
            (345, 50),
            // Our command handler
            text: "Equip",
            cmdHandler: handler,
            // A command string for the button
            command: 'equipShield:0',
            fnt: bigFont,
            textScale: 2,
            textColor: Font.CR_GREEN
        );

        // Add the button element into the main frame.
        equipShieldButton.Pack (descriptionFrame); // index: 3

        equipShieldButton.hide();

        /*let abortMissionButton = ZDRPG_ZF_Button.Create
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

        abortMissionButton.hide();*/   
    }

    ZDRPG_ZF_Frame CreateShieldInfoBox(ZDRPG_ZF_Frame descriptionFrame)
    {
        int descriptionFrameOffset = 75;
        let descriptionFrameSize = descriptionFrame.getSize();

        let shieldInfoFrame = ZDRPG_ZF_Frame.create(
            (40, 40),
            (descriptionFrameSize.x - (descriptionFrameSize.x * 0.5) - 60, descriptionFrameSize.y - descriptionFrameOffset - 40)
        );
        shieldInfoFrame.pack(descriptionFrame); // index: 2

        let shieldInfoBoxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
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

        let shieldInfoBox = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            shieldInfoFrame.getSize(),
            // Texture
            shieldInfoBoxTexture,
            // Scale
            (0.25, 0.25)
        );

        //missionInfoBox.pack(missionInfoFrame); // index: 0

        let listFrame = ZDRPG_ZF_ListFrame.Create
        (
            (75, 75),
            (200, 200),
            smallFont.GetHeight() * 2
        );

        listFrame.pack(shieldInfoFrame); // index: 0

        // Add a label.
        let shieldName = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, 0),
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

        shieldName.pack(listFrame); // index: 0

        // Add a label.
        let shieldCapacity = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, 0), 
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

        shieldCapacity.pack(listFrame); // index: 1

        // Add a label.
        let shieldChargeRate = ZDRPG_ZF_Label.Create
        (
            // Position
            (0,0), 
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

        shieldChargeRate.pack(listFrame); // index: 2

        // Add a label.
        let shieldDelay = ZDRPG_ZF_Label.Create
        (
            // Position
            (0,0), 
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

        shieldDelay.pack(listFrame); // index: 3
        //missionTarget.hide();

        return shieldInfoFrame;
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
        let boxSize = (96, 96);
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
            boxSize,
            // Image path/name
            img,
            // Alignment options
            ZDRPG_ZF_Image.AlignType_TopLeft,
            (2, 2)
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

        let buttonSideSize = 96;
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

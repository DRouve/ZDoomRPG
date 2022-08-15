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
        Array<string> buttonCommand;
        string commandString = command;
        commandString.Split (buttonCommand, ":");
    
        if(buttonCommand [0] ~== "statUp" && buttonCommand.Size() > 1)
        {
            playerHandler.SendNetworkEvent("statUp", buttonCommand[1].ToInt());
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

        array <int> blocksCount;
        CreateStatBox("ShieldItem 1",     "statUp:1", baseRes, blocksCount);
        CreateStatBox("ShieldItem 2",      "statUp:2", baseRes, blocksCount);
        CreateStatBox("ShieldItem 3",     "statUp:3", baseRes, blocksCount);
        CreateStatBox("ShieldItem 4",       "statUp:4", baseRes, blocksCount);
        CreateStatBox("ShieldItem 5", "statUp:5", baseRes, blocksCount);
    }

    void CreateStatBox(string labelText, string commandName, Vector2 baseRes, out array <int> blocksCount) 
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
        let boxOffset = offsetY + boxSize.X * blocksCount.Size();
        let boxInnerOffset = blocksCount.Size() * 32;

        let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (boxOffset + boxInnerOffset, offsetY),
            // Size
            boxSize,
            // Texture
            boxTexture,
            // Scale
            (0.25, 0.25)
        );
        // Add the box image element into the main frame.
        aBoxImage.Pack (mainFrame);

        // Create the button's textures.
        let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
        let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
        let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);

        let buttonSideSize = 18;
        let buttonPosX = boxOffset + boxInnerOffset + aBoxImage.GetWidth() / 2 - buttonSideSize / 2;
        let buttonPosY = offsetY + aBoxImage.GetHeight() / 2 - buttonSideSize / 2;

        // Add a button.
        aButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (buttonPosX, buttonPosY),
            // Size
            (buttonSideSize, buttonSideSize),
            // Our command handler
            cmdHandler: handler,
            // A command string for the button
            command: commandName,
            // The button's textures
            inactive: buttonIdle,
            hover: buttonHover,
            click: buttonClick
        );
        // Add the button element into the main frame.
        aButton.Pack (mainFrame);

        // Add a label.
        aLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, aButton.GetPosY () + aButton.GetHeight () + 4),
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
        aLabel.Pack (mainFrame);

        blocksCount.Push(1);
    }

    override void handleBack() {
		super.handleBack();
        menuactive = Menu.OnNoPause;
	}
}

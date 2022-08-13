class ZDRPGHUD : BaseStatusBar
{
    HUDFont fontSmall;
    HUDFont fontBig;
    HUDFont fontBigNoMono;

    override void Init()
    {
        super.Init();
        Font fnt = "BIGFONT";
        fontBig = HUDFont.Create(fnt, fnt.GetCharWidth("0"), true, 2, 2);
        fontBigNoMono = HUDFont.Create(fnt, 1, false, 2, 2);
        fnt = "SMALLFONT";
        fontSmall = HUDFont.Create(fnt);
    }
    
    override void Draw (int state, double TicFrac)
	{
		if (state == HUD_StatusBar)
		{
            
		}
		else if (state == HUD_Fullscreen)
		{
            BeginHUD();
			DrawLeftTop ();
            DrawLeftBottom ();
            // From GZDoom -> DoomStatusBar
            if (deathmatch)
            {
                DrawString(fontBig, FormatNumber(CPlayer.FragCount, 3), (-3, 1), DI_TEXT_ALIGN_RIGHT, Font.CR_GOLD);
            }
            else
            {
                DrawFullscreenKeys();
            } 
		}
	} 

    void DrawLeftBottom() {
        // Mugshot and Health
        DrawTexture(GetMugShot(5), (5, -3), DI_SCREEN_LEFT_BOTTOM|DI_ITEM_LEFT_BOTTOM); 
        DrawString(fontBig, FormatNumber(CPlayer.health, 3), (30, -18), DI_SCREEN_LEFT_BOTTOM|DI_TEXT_ALIGN_LEFT, Font.CR_RED);

        // EP
        let Stats = ZDRPGStats(CPlayer.mo.FindInventory("ZDRPGStats"));
        DrawString(fontBig, FormatNumber(Stats.EP, 3), (-35, -18), DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_LIGHTBLUE);  
        DrawImage("EPEMA0", (0, 6), DI_SCREEN_RIGHT_BOTTOM|DI_ITEM_RIGHT_BOTTOM);
        DrawImage("EPENA0", (0, 6), DI_SCREEN_RIGHT_BOTTOM|DI_ITEM_RIGHT_BOTTOM);

        // Ammo
        Inventory ammotype1, ammotype2;
		[ammotype1, ammotype2] = GetCurrentAmmo();
		int invY = -20;
		if (ammotype1 != null)
		{
			DrawInventoryIcon(ammotype1, (-16, -25));
			DrawString(fontBig, FormatNumber(ammotype1.Amount, 3), (-35, -38), DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_GRAY);
			invY -= 20;
		}
		if (ammotype2 != null && ammotype2 != ammotype1)
		{
			DrawInventoryIcon(ammotype2, (-16, invY + 17));
			DrawString(fontBig, FormatNumber(ammotype2.Amount, 3), (-35, invY), DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_GRAY);
			invY -= 20;
		} 
    }

    void DrawLeftTop() {
        let Inventory = ZDRPGPlayerInventory(CPlayer.mo.FindInventory("ZDRPGPlayerInventory"));
        
        // Credits
        DrawImage("CREDA0", (12, 10), DI_SCREEN_LEFT_TOP|DI_ITEM_LEFT_TOP, 1., (-1, -1), (1.1, 1.1));
        DrawString(fontBigNoMono, FormatNumber(Inventory.Credits, getCurrencyOffset(Inventory.Credits)), (65, 5), DI_SCREEN_LEFT_TOP|DI_TEXT_ALIGN_LEFT, Font.CR_GOLD);  

        // Modules
        DrawImage("UMODA0", (16, 35), DI_SCREEN_LEFT_TOP|DI_ITEM_LEFT_TOP, 1., (-1, -1), (1.1, 1.1));
        DrawString(fontBigNoMono, FormatNumber(Inventory.Modules, getCurrencyOffset(Inventory.Modules)), (65, 35), DI_SCREEN_LEFT_TOP|DI_TEXT_ALIGN_LEFT, Font.CR_GREEN);  

        // Medpack
        DrawImage("MEDKA0", (16, 75), DI_SCREEN_LEFT_TOP|DI_ITEM_LEFT_TOP, 1., (-1, -1), (1.05, 1.1));
        let MedkitFontColor = Font.CR_RED; 
        if(Inventory.Medkit > 0) {
            MedkitFontColor = Font.CR_BRICK; 
        }
        DrawString(fontBigNoMono, FormatNumber(Inventory.Medkit, getCurrencyOffset(Inventory.Medkit)), (65, 65), DI_SCREEN_LEFT_TOP|DI_TEXT_ALIGN_LEFT, MedkitFontColor);  
    }

    // From GZDoom -> DoomStatusBar
    protected virtual void DrawFullscreenKeys()
	{
		// Draw the keys. This does not use a special draw function like SBARINFO because the specifics will be different for each mod
		// so it's easier to copy or reimplement the following piece of code instead of trying to write a complicated all-encompassing solution.
		Vector2 keypos = (-10, 2);
		int rowc = 0;
		double roww = 0;
		for(let i = CPlayer.mo.Inv; i != null; i = i.Inv)
		{
			if (i is "Key" && i.Icon.IsValid())
			{
				DrawTexture(i.Icon, keypos, DI_SCREEN_RIGHT_TOP|DI_ITEM_LEFT_TOP);
				Vector2 size = TexMan.GetScaledSize(i.Icon);
				keypos.Y += size.Y + 2;
				roww = max(roww, size.X);
				if (++rowc == 3)
				{
					keypos.Y = 2;
					keypos.X -= roww + 2;
					roww = 0;
					rowc = 0;
				}
			}
		}
	}

    int getCurrencyOffset(int itemAmount) {
        if(itemAmount > 99)
            return 2;
        return 1;
    }
}
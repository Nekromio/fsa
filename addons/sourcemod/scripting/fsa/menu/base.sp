void MenuBasic(int client)
{
	Menu hMenu = new Menu(MenuBasic_Callback);
	hMenu.SetTitle("FSA Меню");
	hMenu.AddItem("item1", "Управление Игроками");
	hMenu.AddItem("item2", "Веселые Команды");
	hMenu.AddItem("item3", "Меню Предметов");
	if(Engine_Version != GAME_CSGO)
        hMenu.AddItem("item4", "Воспроизведение Музыки");
    hMenu.ExitBackButton = true;
	hMenu.Display(client, 0);
}

void MenuPlayerCommand(int client)
{
    Menu hMenu = new Menu(MenuPlayerCommand_Callback);
    hMenu.SetTitle("ФСА(Админ) Действия над игроком");
    hMenu.AddItem("Item1", "Бан");
    hMenu.AddItem("Item2", "Заморозить");
    hMenu.AddItem("Item3", "Кик");
    hMenu.AddItem("Item4", "Мут");
    hMenu.AddItem("Item5", "Убить");
    hMenu.AddItem("Item6", "Сменить команду");
    hMenu.AddItem("Item7", "Переместить в спектора");
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuPlayerCommand_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
			switch(item)
            {
                case 0: MenuBanPlayerTime(client);
				case 1: MenuFreeze(client);
				case 2: MenuKick(client);
				case 3: MenuMute(client);
				case 4: ManuSlay(client);
				case 5: MenuSwapTeam(client);
				case 6: MenuSwapSpec(client);
            }
        }
		case MenuAction_Cancel:
		{
			if(item == MenuCancel_ExitBack)
			{
            	MenuBasic(client);
        	}
   		}
	}
	return 0;
}

void MenuPlayMusic(int client)
{
    Menu hMenu = CreateMenu(MenuPlayMusic_Callback);
    hMenu.SetTitle("Проиграть трек");
	hMenu.AddItem("Item", "[Остановить]");
    for(int i = 0; i < sizeof(sSoundNameList); i++)
    {
        hMenu.AddItem("Item", sSoundNameList[i]);
    }

    hMenu.ExitBackButton = true;
	hMenu.Display(client, 0);
}

public int MenuPlayMusic_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
			if(item)
				PlaySound(client, item-1);	//Так как мы добавили на 0 остановку треков
			else
				PlaySound(client, item, false);

			MenuPlayMusic(client);
        }
		case MenuAction_Cancel:
		{
			if(item == MenuCancel_ExitBack)
			{
            	MenuBasic(client);
        	}
   		}
	}
	return 0;
}

int MenuBasic_Callback(Menu menu, MenuAction action, int client, int item)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char info[64];
			GetMenuItem(menu, item, info, sizeof(info));
			GetClientName(client, name_1, sizeof(name_1));

			switch(item)
			{
				case 0: MenuPlayerCommand(client);
				case 1: MenuFunCmd(client);
				case 2: MenuProp(client);
				case 3: MenuPlayMusic(client);
			}
		}
		case MenuAction_Cancel:
		{
			if(item == MenuCancel_ExitBack)
				MenuBasic(client);
		}
		case MenuAction_End:
		{
			delete menu;
		}
	}
	return 0;
}
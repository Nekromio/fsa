void MenuProp(int client)
{
	Menu hMenu = new Menu(MenuProp_Callback);
	hMenu.SetTitle("ФСА(Админ) Меню предметов");
	hMenu.AddItem("Delete Prop", "Удалить");
	hMenu.AddItem("Rotate Prop", "Повернуть");
	if(Engine_Version != GAME_CSGO)
        hMenu.AddItem("Physic Props", "Физические предметы");
	hMenu.AddItem("Dynamic/Static Props", "Статические предметы");
	hMenu.AddItem("NPCs", "НПСы");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, 0);
}

public int MenuProp_Callback(Menu hMenu, MenuAction action, int client, int item)
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
                case 0: DeleteProp(client);
                case 1: MenuRotateProp(client);
                case 2: MenuPhysicProp(client);
                case 3: MenuStaticProp(client);
                case 4: MenuNPC(client);
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

void MenuRotateProp(int client)
{
    Menu hMenu = new Menu(MenuRotateProp_Callback);
	hMenu.SetTitle("ФСА(Админ) Меню Повернуть предмет");
	hMenu.AddItem("Rotate X +45 Degrees", "Повернуть Х +45 Градусов");
	hMenu.AddItem("Rotate Y +45 Degrees", "Повернуть Y +45 Градусов");
	hMenu.AddItem("Rotate Z +45 Degrees", "Повернуть Z +45 Градусов");
	hMenu.AddItem("Rotate X -45 Degrees", "Повернуть X -45 Градусов");
	hMenu.AddItem("Rotate Y -45 Degrees", "Повернуть Y -45 Градусов");
	hMenu.AddItem("Rotate Z -45 Degrees", "Повернуть Z -45 Градусов");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, 0);
}

public int MenuRotateProp_Callback(Menu hMenu, MenuAction action, int client, int item)
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
                case 0: propRotation(client, 0);
                case 1: propRotation(client, 1);
                case 2: propRotation(client, 2);
                case 3: propRotation(client, 0, false);
                case 4: propRotation(client, 1, false);
                case 5: propRotation(client, 2, false);
            }
            MenuRotateProp(client);
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

void MenuPhysicProp(int client)
{
    Menu hMenu = new Menu(MenuPhysicProp_Callback);
    hMenu.SetTitle("Физические предметы");

    char index[8];
    for(int i = 0; i < sizeof(sPhysicNameModelList); i++)
    {
        Format(index, sizeof(index), "%d", i);
        hMenu.AddItem(index, sPhysicNameModelList[i]);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuPhysicProp_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int index = getIndex(hMenu, item);

            CreatePhysicModel(client, index);

            MenuPhysicProp(client);
        }
		case MenuAction_Cancel:
		{
			if(item == MenuCancel_ExitBack)
			{
            	MenuProp(client);
        	}
   		}
	}
	return 0;
}

void MenuStaticProp(int client)
{
    Menu hMenu = new Menu(MenuStaticProp_Callback);
    hMenu.SetTitle("Статические предметы");

    char index[8];
    for(int i = 0; i < sizeof(sStaticModelList); i++)
    {
        Format(index, sizeof(index), "%d", i);
        hMenu.AddItem(index, sStaticNameModelList[i]);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuStaticProp_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int index = getIndex(hMenu, item);

            SpawnStaticModel(client, index);

            MenuStaticProp(client);
        }
		case MenuAction_Cancel:
		{
			if(item == MenuCancel_ExitBack)
			{
            	MenuProp(client);
        	}
   		}
	}
	return 0;
}

void MenuNPC(int client)
{
    Menu hMenu = new Menu(MenuNPC_Callback);
    hMenu.SetTitle("NPC");

    char index[8];
    for(int i = 0; i < sizeof(sPhysicNameNPCList); i++)
    {
        Format(index, sizeof(index), "%d", i);
        hMenu.AddItem(index, sPhysicNameNPCList[i]);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuNPC_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int index = getIndex(hMenu, item);

            SpawnStaticModel(client, index, true);

            MenuNPC(client);
        }
		case MenuAction_Cancel:
		{
			if(item == MenuCancel_ExitBack)
			{
            	MenuProp(client);
        	}
   		}
	}
	return 0;
}
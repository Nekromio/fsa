void MenuBanPlayerTime(int client)
{
    Menu hMenu = new Menu(MenuBanPlayerTime_Callback);
    hMenu.SetTitle("Срок бана");
    hMenu.AddItem("Permanent", "Перанент");
    hMenu.AddItem("5 mins", "5 минут");
    hMenu.AddItem("30 mins", "30 минут");
    hMenu.AddItem("1 hour", "1 час");
    hMenu.AddItem("2 hours", "2 часа");
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuBanPlayerTime_Callback(Menu hMenu, MenuAction action, int client, int item)
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
                case 0: MenuBanPlayerChoice(client, 0);
                case 1: MenuBanPlayerChoice(client, 1);
                case 2: MenuBanPlayerChoice(client, 30);
                case 3: MenuBanPlayerChoice(client, 60);
                case 4: MenuBanPlayerChoice(client, 120);
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

void MenuBanPlayerChoice(int client, int time)
{
    iBanTime[client] = time;
    Menu hMenu = new Menu(MenuBanPlayerChoice_Callback);
    char name[64], buffer[8];
    hMenu.SetTitle("Выбрать игрока");
    int count;
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && !IsFakeClient(i) && client != i)
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        hMenu.AddItem(buffer, name);
        count++;
    }
    if(!count)
    {
        hMenu.AddItem("item1", "Нет игроков");
    }
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuBanPlayerChoice_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int target = getIndex(hMenu, item);
            char buffer[64];
            Format(buffer, sizeof(buffer), "%N", client);
            BanClient(target, iBanTime[client], BANFLAG_AUTHID, "[FSA] Заблокирован!", "Вы заблокировны!", buffer);
            iBanTime[client] = -1;
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

void MenuFreeze(int client)
{
    Menu hMenu = new Menu(MenuFreeze_Callback);
    hMenu.SetTitle("Заморозить");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Freeze)
        {
            Format(name, sizeof(name), "[Freez] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuFreeze_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int target = getIndex(hMenu, item);

            int tempstring = 0;
            if (status[target].Freeze == false)
            {
                SetEntityMoveType(target, MOVETYPE_NONE);
                status[target].Freeze = true;
                status[target].Jet = false;
                status[target].Clip = false;
                tempstring = 1;
            }
            if (status[target].Freeze == true)
            {
                if (tempstring == 0)
                {
                    SetEntityMoveType(target, MOVETYPE_WALK);
                    status[target].Freeze = false;
                }
            }

            PrintToChatAll("\x03[\x04FSA\x03] \x01(ADMIN) %N %s %N", client, status[target].Freeze == true ? "заморозил" : "разморозил", target);

            MenuFreeze(client);
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

void MenuKick(int client)
{
    Menu hMenu = new Menu(MenuKick_Callback);
    hMenu.SetTitle("Кик игрока");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuKick_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int target = getIndex(hMenu, item);

            KickClient(target, "Kicked by Admin");

            MenuKick(client);
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

void MenuMute(int client)
{
    Menu hMenu = new Menu(MenuMute_Callback);
    hMenu.SetTitle("Выбрать игрока");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
    
        if (status[i].Mute == true)
        {
            Format(name, sizeof(name), "[Мут] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuMute_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int target = getIndex(hMenu, item);
            int userid = GetClientUserId(target);

            int tempstring = 0;
            if (status[target].Mute == false)
            {
                status[target].Mute = true;
                ServerCommand("sm_mute #%d", userid);
                ServerCommand("sm_gag #%d", userid);
                tempstring = 1;
            }
            if (status[target].Mute == true)
            {
                if (tempstring == 0)
                {
                    status[target].Mute = false;
                    ServerCommand("sm_unmute #%d", userid);
                    ServerCommand("sm_ungag #%d", userid);
                }
            }
            MenuMute(client);
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

void ManuSlay(int client)
{
    Menu hMenu = new Menu(ManuSlay_Callback);
    hMenu.SetTitle("Шлепнуть");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int ManuSlay_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int target = getIndex(hMenu, item);

            SlapPlayer(target, 1000, true);

            ManuSlay(client);
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

void MenuSwapTeam(int client)
{
    Menu hMenu = new Menu(MenuSwapTeam_Callback);
    hMenu.SetTitle("Сменить команду");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && GetClientTeam(i) > 1)
    {
        int team = GetClientTeam(i);
        Format(buffer, sizeof(buffer), "%d", i);
        Format(name, sizeof(name), "[%s] %N", team == 2 ? "Т" : "КТ", i);
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuSwapTeam_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int target = getIndex(hMenu, item);

            int team = GetClientTeam(target) == 2 ? 3 : 2;
			ChangeClientTeam(target, team);

            MenuSwapTeam(client);
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

void MenuSwapSpec(int client)
{
    Menu hMenu = new Menu(MenuSwapSpec_Callback);
    hMenu.SetTitle("В наблюдатели");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && GetClientTeam(i) > 1)
    {
        int team = GetClientTeam(i);
        Format(buffer, sizeof(buffer), "%d", i);
        Format(name, sizeof(name), "[%s] %N", team == 2 ? "Т" : "КТ", i);
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuSwapSpec_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            int target = getIndex(hMenu, item);

			ChangeClientTeam(target, 1);

            MenuSwapSpec(client);
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
void MenuFunCmd(int client)
{
    Menu hMenu = new Menu(MenuFunCmd_Callback);
    hMenu.SetTitle("ФСА(Админ) Весёлые команды");
    hMenu.AddItem("Beacon", "Маяк");
    hMenu.AddItem("Blind", "Ослепить");
    hMenu.AddItem("Burn", "Сжечь");
    hMenu.AddItem("Burymain", "Закопать");
    hMenu.AddItem("Disarm", "Разоружить");
    hMenu.AddItem("Disguise" ,"Изменить модель игрока");
    hMenu.AddItem("Drug", "Наркотик");
    hMenu.AddItem("Godmode", "Бесмертие");
    hMenu.AddItem("Invisible", "Невидимость");
    hMenu.AddItem("Jetpack", "Реактивный ранец");
    hMenu.AddItem("Noclip", "Прохождение сквозь стены");
    hMenu.AddItem("Regeneration", "Регенерация");
    hMenu.AddItem("Respawn", "Воскрешение");
    hMenu.AddItem("Rocket", "Ракета");
    hMenu.AddItem("Slap", "Пнуть");
    hMenu.AddItem("Speed", "Скорость");
    hMenu.AddItem("Bird", "Стать птичкой");
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuFunCmd_Callback(Menu hMenu, MenuAction action, int client, int item)
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
                case 0: MenuBeacon(client);
                case 1: MenuBlind(client);
                case 2: MenuBurn(client);
                case 3: MenuBurymain(client);
                case 4: MenuDisarm(client);
                case 5: MenuDisguise(client);
                case 6: MenuDrug(client);
                case 7: MenuGodmode(client);
                case 8: MenuInvisible(client);
                case 9: MenuJetpack(client);
                case 10: MenuNoclip(client);
                case 11: MenuRegeneration(client);
                case 12: MenuRespawn(client);
                case 13: MenuRocket(client);
                case 14: MenuSlap(client);
                case 15: MenuSpeed(client);
                case 16: MenuBird(client);
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

void MenuBeacon(int client)
{
    Menu hMenu = new Menu(MenuBeacon_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Beacon)
        {
            Format(name, sizeof(name), "[Маяк] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuBeacon_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].Beacon == false)
            {
                status[target].Beacon = true;
            }
            else if (status[target].Beacon == true)
            {
                status[target].Beacon = false;
            }

            MenuBeacon(client);
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

void MenuBlind(int client)
{
    Menu hMenu = new Menu(MenuBlind_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if (status[i].BlindAlpha == 200)
        {
            Format(name, sizeof(name), "[Half-Blind] %s", name);
        }
        if (status[i].BlindAlpha == 255)
        {
            Format(name, sizeof(name), "[Blind] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuBlind_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].BlindAlpha == 0)
            {
                status[target].BlindAlpha = 200;
                ServerCommand("sm_blind #%target %target", userid, status[target].BlindAlpha);
                //PrintToChatAll("\x03[\x04FSA\x03] \x01(ADMIN) %s half-blinded %s", nameclient1, nameclient2);
            }
            if (status[target].BlindAlpha == 200)
            {
                status[target].BlindAlpha = 255;
                ServerCommand("sm_blind #%target %target", userid, status[target].BlindAlpha);
                //PrintToChatAll("\x03[\x04FSA\x03] \x01(ADMIN) %s blinded %s", nameclient1, nameclient2);
            }
            if (status[target].BlindAlpha == 255)
            {
                status[target].BlindAlpha = 0;
                ServerCommand("sm_blind #%target %target", userid, status[target].BlindAlpha);
                //PrintToChatAll("\x03[\x04FSA\x03] \x01(ADMIN) %s unblinded %s", nameclient1, nameclient2);
            }

            MenuBlind(client);
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

void MenuBurn(int client)
{
    Menu hMenu = new Menu(MenuBurn_Callback);
    hMenu.SetTitle("Поджечь");
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

public int MenuBurn_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            IgniteEntity(target, 15.0, false, 0.0, false);

            MenuBurn(client);
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

void MenuBurymain(int client)
{
    Menu hMenu = new Menu(Burymain_Callback);
    hMenu.SetTitle("Закопать/Раскопать");
    hMenu.AddItem("Item1", "Закопать");
    hMenu.AddItem("Item2", "Раскопать");
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int Burymain_Callback(Menu hMenu, MenuAction action, int client, int item)
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
                case 0: MenuBury(client);
                case 1: MenuUnBury(client);
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

void MenuBury(int client)
{
    Menu hMenu = new Menu(MenuBury_Callback);
    hMenu.SetTitle("Закопать");
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

public int MenuBury_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            float pos[3];
            GetClientAbsOrigin(target, pos);
            pos[2] = pos[2] - 50;
            TeleportEntity(target, pos, NULL_VECTOR, NULL_VECTOR);

            MenuBury(client);
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

void MenuUnBury(int client)
{
    Menu hMenu = new Menu(MenuUnBury_Callback);
    hMenu.SetTitle("Раскопать");
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

public int MenuUnBury_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            float pos[3];
            GetClientAbsOrigin(target, pos);
            pos[2] = pos[2] + 50;
            TeleportEntity(target, pos, NULL_VECTOR, NULL_VECTOR);

            MenuUnBury(client);
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

void MenuDisarm(int client)
{
    Menu hMenu = new Menu(MenuDisarm_Callback);
    hMenu.SetTitle("Разоружить");
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

public int MenuDisarm_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            int weapon;
            for(int j = 0; j <= 6; j++)
            {
                weapon = GetPlayerWeaponSlot(target, j);
                if(weapon != -1)
                    RemovePlayerItem(target, weapon);
            }

            MenuDisarm(client);
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

void MenuDisguise(int client)
{
    Menu hMenu = new Menu(MenuDisguise_Callback);
    hMenu.SetTitle("Выбор модели");

    for(int i = 0; i < sizeof(sNameModels); i++)
    {
        hMenu.AddItem(sModels[i], sNameModels[i]);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}
//iSelectModel

public int MenuDisguise_Callback(Menu hMenu, MenuAction action, int client, int item)
{
    switch(action)
    {
		case MenuAction_End:
        {
            delete hMenu;
        }
		case MenuAction_Select:
        {
            iSelectModel[client] = item;

            MenuDisguiseUser(client);
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

void MenuDisguiseUser(int client)
{
    Menu hMenu = new Menu(MenuDisguiseUser_Callback);
    hMenu.SetTitle("Кому установить модель:");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Disguise)
        {
            Format(name, sizeof(name), "[Модель] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuDisguiseUser_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            switch(status[target].Disguise)
            {
                case false:
                {
                    GetClientModel(target, playermodel[target], sizeof(playermodel));
                    //SetEntityModel(target, DisguiseAdminString[client]);
                    //PrintToChatAll("Игрок [%N] установил на игрока [%N] модель [%s]", client, target, sModels[iSelectModel[client]]);
                    SetEntityModel(target, sModels[iSelectModel[client]]);
                    status[target].Disguise = true;
                }
                case true:
                {
                    SetEntityModel(target, playermodel[target]);
                    //PrintToChatAll("Игрок [%N] вернул игроку [%N] модель [%s]", client, target, playermodel[target]);
                    status[target].Disguise = false;
                }
            }

            MenuDisguiseUser(client);
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

void MenuDrug(int client)
{
    Menu hMenu = new Menu(MenuDrug_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Drug)
        {
            Format(name, sizeof(name), "[Пьян] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuDrug_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            switch(status[target].Drug)
            {
                case false:
                {
                    status[target].Drug = true;
                    ServerCommand("sm_drug #%d", userid);
                }
                case true:
                {
                    status[target].Drug = false;
                    ServerCommand("sm_drug #%d", userid);
                }
            }
            MenuDrug(client);
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

void MenuGodmode(int client)
{
    Menu hMenu = new Menu(MenuGodmode_Callback);
    hMenu.SetTitle("Godmode");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].God)
        {
            Format(name, sizeof(name), "[God] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuGodmode_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].God == false)
            {
                status[target].God = true;
                SetEntProp(target, Prop_Data, "m_takedamage", 0, 1);
            }
            else if (status[target].God == true)
            {
                status[target].God = false;
                SetEntProp(target, Prop_Data, "m_takedamage", 2, 1);
            }

            MenuGodmode(client);
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

void MenuInvisible(int client)
{
    Menu hMenu = new Menu(MenuInvisible_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Invis)
        {
            Format(name, sizeof(name), "[INVIS] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuInvisible_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].Invis == false)
            {
                status[target].Invis = true;
                SetEntityRenderMode(target, RENDER_NONE);
            }
            else if (status[target].Invis == true)
            {
                status[target].Invis = false;
                SetEntityRenderMode(target, RENDER_NORMAL);
            }

            MenuInvisible(client);
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

void MenuJetpack(int client)
{
    Menu hMenu = new Menu(MenuJetpack_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Jet)
        {
            Format(name, sizeof(name), "[JET] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuJetpack_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].Jet == false)
            {
                status[target].Jet = true;
                status[target].Freeze = false;
                status[target].Clip = false;
                SetEntityMoveType(target, MOVETYPE_FLY);
            }
            else if (status[target].Jet == true)
            {
                status[target].Jet = false;
				SetEntityMoveType(target, MOVETYPE_WALK);
            }

            MenuJetpack(client);
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

void MenuNoclip(int client)
{
    Menu hMenu = new Menu(MenuNoclip_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Clip)
        {
            Format(name, sizeof(name), "[NOCLIP] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuNoclip_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].Clip == false)
            {
                status[target].Clip = true;
                status[target].Freeze = false;
                status[target].Jet = false;
                SetEntityMoveType(target, MOVETYPE_NOCLIP);
            }
            else if (status[target].Clip == true)
            {
                status[target].Clip = false;
				SetEntityMoveType(target, MOVETYPE_WALK);
            }

            MenuNoclip(client);
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

void MenuRegeneration(int client)
{
    Menu hMenu = new Menu(MenuRegeneration_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Regen)
        {
            Format(name, sizeof(name), "[REGEN] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuRegeneration_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].Regen == false)
            {
                status[target].Regen = true;
            }
            else if (status[target].Regen == true)
            {
                status[target].Regen = false;
            }

            MenuRegeneration(client);
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

void MenuRespawn(int client)
{
    Menu hMenu = new Menu(MenuRespawn_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && GetClientTeam(i) > 1)
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuRespawn_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            CS_RespawnPlayer(target);

            MenuRespawn(client);
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

void MenuRocket(int client)
{
    Menu hMenu = new Menu(MenuRocket_Callback);
    hMenu.SetTitle("Меню заморозки");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Rocket)
        {
            Format(name, sizeof(name), "[ROCKET] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuRocket_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            if (status[target].Rocket == false)
            {
                status[target].Rocket = true;
                if (RocketType == 1)
                {
                    SetEntityGravity(target, -0.1);
                    float ABSORIGIN[3];
                    GetClientAbsOrigin(target, ABSORIGIN);
                    ABSORIGIN[2] = ABSORIGIN[2] + 5;
                    TeleportEntity(target, ABSORIGIN, NULL_VECTOR, NULL_VECTOR);
                }
                if (RocketType == 2)
                {
                    SetEntityMoveType(target, MOVETYPE_NONE);
                }
                char sName[64];
                Format(sName, sizeof(sName), "%N", target);
                sprite[target] = CreateEntityByName("env_spritetrail");
                float spriteorigin[3];
                GetClientAbsOrigin(target, spriteorigin);
                DispatchKeyValue(target, "targetname", sName);
                PrecacheModel("sprites/sprite_fire01.vmt", false);
                DispatchKeyValue(sprite[target], "model", "sprites/sprite_fire01.vmt");
                DispatchKeyValue(sprite[target], "endwidth", "2.0");
                DispatchKeyValue(sprite[target], "lifetime", "2.0");
                DispatchKeyValue(sprite[target], "startwidth", "16.0");
                DispatchKeyValue(sprite[target], "renderamt", "255");
                DispatchKeyValue(sprite[target], "rendercolor", "255 255 255");
                DispatchKeyValue(sprite[target], "rendermode", "5");
                DispatchKeyValue(sprite[target], "parentname", sName);
                DispatchSpawn(sprite[target]);
                TeleportEntity(sprite[target], spriteorigin, NULL_VECTOR, NULL_VECTOR);
                SetVariantString(sName);
                AcceptEntityInput(sprite[target], "SetParent");
                PrecacheSound("weapons/rpg/rocketfire1.wav", false);
                EmitSoundToAll("weapons/rpg/rocketfire1.wav", SOUND_FROM_PLAYER, SNDCHAN_STATIC, SNDLEVEL_NORMAL, SND_NOFLAGS, SNDVOL_NORMAL, SNDPITCH_NORMAL, -1, NULL_VECTOR, NULL_VECTOR, true, 0.0);
                CreateTimer(0.25, RocketLaunchTimer);
            }
            else if (status[target].Rocket == true)
            {
                status[target].Rocket = false;
                if (RocketType == 1)
                {
                    SetEntityGravity(target, 1.0);
                }
                if (RocketType == 2)
                {
                    SetEntityMoveType(target, MOVETYPE_WALK);
                }
                for (int k = 1; k <= MaxClients; k++)
                {
                    StopSound(k, SNDCHAN_STATIC, "weapons/rpg/rocket1.wav");
                }
                AcceptEntityInput(sprite[target], "Kill", -1, -1, 0);
            }

            MenuRocket(client);
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

void MenuSlap(int client)
{
    Menu hMenu = new Menu(MenuSlap_Callback);
    hMenu.SetTitle("Шлёпнуть");
    hMenu.AddItem("Item1", "0");
    hMenu.AddItem("Item1", "1");
    hMenu.AddItem("Item1", "5");
    hMenu.AddItem("Item1", "10");
    hMenu.AddItem("Item1", "50");
    hMenu.AddItem("Item1", "100");
    hMenu.AddItem("Item1", "500");
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuSlap_Callback(Menu hMenu, MenuAction action, int client, int item)
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
                case 0: iSlapDamage[client] = 0;
                case 1: iSlapDamage[client] = 1;
                case 2: iSlapDamage[client] = 5;
                case 3: iSlapDamage[client] = 10;
                case 4: iSlapDamage[client] = 50;
                case 5: iSlapDamage[client] = 100;
                case 6: iSlapDamage[client] = 500;
            }

            MenuSlapUser(client);
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

void MenuSlapUser(int client)
{
    Menu hMenu = new Menu(MenuSlapUser_Callback);
    hMenu.SetTitle("Шлёпнуть");
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

public int MenuSlapUser_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            switch(item)
            {
                case 0: SlapPlayer(target, iSlapDamage[client], true);
            }

            MenuSlapUser(client);
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

void MenuSpeed(int client)
{
    Menu hMenu = new Menu(MenuSpeed_Callback);
    hMenu.SetTitle("Скорость");
    hMenu.AddItem("Item1", "Стандарт");
    hMenu.AddItem("Item1", "x2");
    hMenu.AddItem("Item1", "x3");
    hMenu.AddItem("Item1", "x4");
    hMenu.AddItem("Item1", "x0.5");
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuSpeed_Callback(Menu hMenu, MenuAction action, int client, int item)
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
                case 0: fSpeed[client] = 1.0;
                case 1: fSpeed[client] = 2.0;
                case 2: fSpeed[client] = 3.0;
                case 3: fSpeed[client] = 4.0;
                case 4: fSpeed[client] = 0.5;
            }

            MenuSpeedUser(client);
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

void MenuSpeedUser(int client)
{
    Menu hMenu = new Menu(MenuSpeedUser_Callback);
    hMenu.SetTitle("Меню скорости");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);

        switch(status[i].SpeedIndex)
        {
            case 1: Format(name, sizeof(name), "[x2] %s", name);
            case 2: Format(name, sizeof(name), "[x3] %s", name);
            case 3: Format(name, sizeof(name), "[x4] %s", name);
            case 4: Format(name, sizeof(name), "[x0.5] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuSpeedUser_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            switch(fSpeed[client])
            {
                case 1.0: status[target].SpeedIndex = 0;
                case 2.0: status[target].SpeedIndex = 1;
                case 3.0: status[target].SpeedIndex = 2;
                case 4.0: status[target].SpeedIndex = 3;
                case 0.5: status[target].SpeedIndex = 4;
            }
            float speed = GetEntPropFloat(target, Prop_Data, "m_flLaggedMovementValue");
            if(speed != fSpeed[client])
            {
                SetEntPropFloat(target, Prop_Data, "m_flLaggedMovementValue", fSpeed[client]);
            }
            else
            {
                status[target].SpeedIndex = 0;
                SetEntPropFloat(target, Prop_Data, "m_flLaggedMovementValue", 1.0);
            }

            MenuSpeedUser(client);
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

void MenuBird(int client)
{
    Menu hMenu = new Menu(MenuBird_Callback);
    hMenu.SetTitle("Стать птичкой");
    char name[64], buffer[8];
    for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i) && IsPlayerAlive(i))
    {
        Format(name, sizeof(name), "%N", i);
        Format(buffer, sizeof(buffer), "%d", i);
        if(status[i].Bird)
        {
            Format(name, sizeof(name), "[Птичка] %s", name);
        }
        hMenu.AddItem(buffer, name);
    }
    
    hMenu.ExitBackButton = true;
    hMenu.Display(client, 0);
}

public int MenuBird_Callback(Menu hMenu, MenuAction action, int client, int item)
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

            BecomeBird(client, target);

            MenuBird(client);
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
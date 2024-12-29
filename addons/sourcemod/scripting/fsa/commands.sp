Action Cmd_MenuBasic(int client, int arg)
{
	if(!cvEnable.BoolValue)
		return Plugin_Continue;

	if(!IsClientValid(client))
        return Plugin_Continue;

	MenuBasic(client);

	return Plugin_Handled;
}

Action Cmd_Bury(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;

    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0; // Не используется в данной функции, но требуется для универсальности
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !bury <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            PerformBury(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            PerformBury(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Unbury(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;
        
	char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !bury <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            PerformBury(i, true);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            PerformBury(Target_List[i], true);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Disarm(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;
        
    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !disarm <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            PerformDisarm(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            PerformDisarm(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_God(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;

    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !god <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            ToggleGodMode(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            ToggleGodMode(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Invis(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;

    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !invis <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            ToggleInvisibility(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            ToggleInvisibility(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Jet(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;

    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !jet <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            ToggleJetpack(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            ToggleJetpack(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Clip(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;

    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !clip <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            ToggleNoclip(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            ToggleNoclip(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Regen(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;

    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !regen <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            ToggleRegen(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            ToggleRegen(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Rocket(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;

    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !rocket <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            ToggleRocket(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            ToggleRocket(Target_List[i]);
        }
    }

    return Plugin_Continue;
}

Action Cmd_Speed(int client, int args)
{
    if(!cvEnable.BoolValue)
		return Plugin_Continue;
        
    char ChatString[64], processed[64];
    int Target_List[MAXPLAYERS];
    int targetCount;
    bool thebool;
    char nameclient1[64];
    GetClientName(client, nameclient1, sizeof(nameclient1));

    float dummyAmount = 0.0;
    if (!ValidateAndProcessTargets(client, args, ChatString, sizeof(ChatString), dummyAmount, Target_List, targetCount, processed, sizeof(processed), thebool, "Usage: !speed <name>"))
    {
        return Plugin_Continue;
    }

    if (StrEqual(ChatString, "#all", false))
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            ToggleSpeed(i);
        }
    }
    else
    {
        for (int i = 0; i < targetCount; i++)
        {
            ToggleSpeed(Target_List[i]);
        }
    }

    return Plugin_Continue;
}
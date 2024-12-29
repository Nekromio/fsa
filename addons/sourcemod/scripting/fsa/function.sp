
void propRotation(int client, int num, bool plus = true)
{
    if(!IsClientValid(client))
        return;

    int target = GetClientAimTarget(client, false);

    if(!IsValidIndex(target))
    {
        MenuRotateProp(client);
        return;
    }

    GetEntPropVector(target, Prop_Send, "m_angRotation", RotateVec);

    RotateVec[num] = RotateVec[num] + (plus ? 45.0 : -45.0);
    TeleportEntity(target, NULL_VECTOR, RotateVec, NULL_VECTOR);
    AcceptEntityInput(target, "EnableCollision");
    AcceptEntityInput(target, "TurnOn", target, target, 0);

    PrintToChatAll("Предмет изменил vec[%d] %s [%s] ", num, plus ? "+" : "-", "45.0");

    MenuRotateProp(client);
}

void PlaySound(int client, int index, bool play = true)
{
    if(play)
    {
        status[client].hSoundPlay.PushString(sSoundList[index]);
	    EmitSoundToAll(sSoundList[index], SOUND_FROM_PLAYER, SNDCHAN_STATIC, SNDLEVEL_NORMAL, SND_NOFLAGS, SNDVOL_NORMAL, SNDPITCH_NORMAL, -1, NULL_VECTOR, NULL_VECTOR, true, 0.0);
    }
    else
    {
        char buffer[256];
        for(int i = 0; i < status[client].hSoundPlay.Length; i++)
        {
            status[client].hSoundPlay.GetString(i, buffer, sizeof(buffer));
            if(!buffer[0])
                continue;
            StopSound(client, SNDCHAN_STATIC, buffer);
        }
    }
}

int getIndex(Menu hMenu, int item)
{
    char buffer[8];
    hMenu.GetItem(item, buffer, sizeof(buffer));
    int target = StringToInt(buffer);

    return target;
}

void CreatePhysicModel(int client, int index)
{
    switch(index)
    {
        case 0,5,9:
        {
            PropHealth = 1;
            Explode = 0;
        }
        case 1,4,6,10,11:
        {
            PropHealth = 0;
            Explode = 0;
        }
        case 2,3:
        {
            PropHealth = 1;
            Explode = 1;
        }
        case 7:
        {
            char sModel[256];
            Format(sModel, sizeof(sModel), "%s", sPhysicModelList[index]);
            float VecOrigin[3], VecAngles[3];
            int prop = CreateEntityByName("prop_physics_override");
            DispatchKeyValue(prop, "model", sModel);
            GetClientEyePosition(client, VecOrigin);
            GetClientEyeAngles(client, VecAngles);
            TR_TraceRayFilter(VecOrigin, VecAngles, MASK_OPAQUE, RayType_Infinite, TraceRayDontHitSelf, client);
            TR_GetEndPosition(VecOrigin);
            VecAngles[0] = 0.0;
            VecAngles[2] = 0.0;
            VecOrigin[2] = VecOrigin[2] + 5;
            DispatchKeyValueVector(prop, "angles", VecAngles);
            DispatchSpawn(prop);
            TeleportEntity(prop, VecOrigin, NULL_VECTOR, NULL_VECTOR);
        }
        case 8:
        {
            char sModel[256];
            Format(sModel, sizeof(sModel), "%s", sPhysicModelList[index]);
            float VecOrigin[3], VecAngles[3];
            int prop = CreateEntityByName("prop_physics_override");
            DispatchKeyValue(prop, "model", sModel);
            GetClientEyePosition(client, VecOrigin);
            GetClientEyeAngles(client, VecAngles);
            TR_TraceRayFilter(VecOrigin, VecAngles, MASK_SOLID, RayType_Infinite, TraceRayDontHitSelf, client);
            TR_GetEndPosition(VecOrigin);
            VecAngles[0] = 0.0;
            VecAngles[2] = 0.0;
            VecOrigin[2] = VecOrigin[2] + 60;
            DispatchKeyValue(prop, "StartDisabled", "false");
            DispatchKeyValue(prop, "Solid", "6"); 
            AcceptEntityInput(prop, "TurnOn", prop, prop, 0);
            SetEntProp(prop, Prop_Data, "m_CollisionGroup", 5);
            SetEntProp(prop, Prop_Data, "m_nSolidType", 6);
            SetEntityMoveType(prop, MOVETYPE_VPHYSICS);
            DispatchSpawn(prop);
            TeleportEntity(prop, VecOrigin, VecAngles, NULL_VECTOR);
            AcceptEntityInput(prop, "EnableCollision");
        }
        case 12:
        {
            char sModel[256];
            Format(sModel, sizeof(sModel), "%s", sPhysicModelList[index]);
            float VecAngles[3], VecOrigin[3];
            int prop = CreateEntityByName("prop_physics_override");
            DispatchKeyValue(prop, "model", sModel);
            GetClientEyePosition(client, VecOrigin);
            GetClientEyeAngles(client, VecAngles);
            TR_TraceRayFilter(VecOrigin, VecAngles, MASK_SOLID, RayType_Infinite, TraceRayDontHitSelf, client);
            TR_GetEndPosition(VecOrigin);
            VecAngles[0] = 0.0;
            VecAngles[2] = 0.0;
            VecOrigin[2] = VecOrigin[2] + 35;
            DispatchKeyValue(prop, "StartDisabled", "false");
            DispatchKeyValue(prop, "Solid", "6"); 
            AcceptEntityInput(prop, "TurnOn", prop, prop, 0);
            SetEntProp(prop, Prop_Data, "m_CollisionGroup", 5);
            SetEntProp(prop, Prop_Data, "m_nSolidType", 6);
            SetEntityMoveType(prop, MOVETYPE_VPHYSICS);
            DispatchSpawn(prop);
            TeleportEntity(prop, VecOrigin, VecAngles, NULL_VECTOR);
            AcceptEntityInput(prop, "EnableCollision");
        }
        case 13:
        {
            char sModel[256];
            Format(sModel, sizeof(sModel), "%s", sPhysicModelList[index]);
            float VecOrigin[3], VecAngles[3];
            int prop = CreateEntityByName("prop_physics_override");
            DispatchKeyValue(prop, "model", sModel);
            GetClientEyePosition(client, VecOrigin);
            GetClientEyeAngles(client, VecAngles);
            TR_TraceRayFilter(VecOrigin, VecAngles, MASK_OPAQUE, RayType_Infinite, TraceRayDontHitSelf, client);
            TR_GetEndPosition(VecOrigin);
            VecAngles[0] = 0.0;
            VecAngles[2] = 0.0;
            VecOrigin[2] = VecOrigin[2] + 10;
            DispatchKeyValueVector(prop, "angles", VecAngles);
            DispatchSpawn(prop);
            TeleportEntity(prop, VecOrigin, NULL_VECTOR, NULL_VECTOR);
        }
    }
    
    if(index != 7 && index != 8 && index != 12 && index != 13)
        SpawnPhysicModel(client, index);

    MenuPhysicProp(client);
}

void SpawnPhysicModel(int client, int index)
{
    char sModel[256];
    Format(sModel, sizeof(sModel), "%s", sPhysicModelList[index]);
    //PrintToChatAll("Индекс модели [%d] Путь [%s]", index, sPhysicModelList[index]);

	float VecOrigin[3], VecAngles[3];
	int prop = CreateEntityByName("prop_physics_override");
	DispatchKeyValue(prop, "model", sModel);
	if (PropHealth == 1)
	{
		DispatchKeyValue(prop, "health", "1");
	}
	if (Explode == 1)
	{
		DispatchKeyValue(prop, "exploderadius", "1000");
		DispatchKeyValue(prop, "explodedamage", "50");
	}
	GetClientEyePosition(client, VecOrigin);
	GetClientEyeAngles(client, VecAngles);
	TR_TraceRayFilter(VecOrigin, VecAngles, MASK_SOLID, RayType_Infinite, TraceRayDontHitSelf, client);
	TR_GetEndPosition(VecOrigin);
	VecAngles[0] = 0.0;
	VecAngles[2] = 0.0;
	VecOrigin[2] = VecOrigin[2] + 15;
	DispatchKeyValue(prop, "StartDisabled", "false");
	DispatchKeyValue(prop, "Solid", "6"); 
	AcceptEntityInput(prop, "TurnOn", prop, prop, 0);
 	SetEntProp(prop, Prop_Data, "m_CollisionGroup", 5);
	SetEntProp(prop, Prop_Data, "m_nSolidType", 6);
	SetEntityMoveType(prop, MOVETYPE_VPHYSICS);
	DispatchSpawn(prop);
	TeleportEntity(prop, VecOrigin, VecAngles, NULL_VECTOR);
	AcceptEntityInput(prop, "EnableCollision");
}

void SpawnStaticModel(int client, int index = 0, bool NPC = false)
{
    char sModel[256];
    if(!NPC)
        Format(sModel, sizeof(sModel), "%s", sStaticModelList[index]);
    else
        Format(sModel, sizeof(sModel), "%s", sPhysicNPCList[index]);

	float VecOrigin[3], VecAngles[3], normal[3];
	int prop = CreateEntityByName("prop_dynamic_override");
	DispatchKeyValue(prop, "model", sModel);
	GetClientEyePosition(client, VecOrigin);
	GetClientEyeAngles(client, VecAngles);
	TR_TraceRayFilter(VecOrigin, VecAngles, MASK_SOLID, RayType_Infinite, TraceRayDontHitSelf, client);
	TR_GetEndPosition(VecOrigin);
	TR_GetPlaneNormal(INVALID_HANDLE, normal);
	GetVectorAngles(normal, normal);
	normal[0] += 90.0;
	DispatchKeyValue(prop, "StartDisabled", "false");
	DispatchKeyValue(prop, "Solid", "6");
	SetEntProp(prop, Prop_Data, "m_nSolidType", 6);
	DispatchKeyValue(prop, "spawnflags", "8"); 
	SetEntProp(prop, Prop_Data, "m_CollisionGroup", 5);
	TeleportEntity(prop, VecOrigin, normal, NULL_VECTOR);
	DispatchSpawn(prop);
	AcceptEntityInput(prop, "EnableCollision"); 
	AcceptEntityInput(prop, "TurnOn", prop, prop, 0);
}

void DeleteProp(int client)
{
    if(!IsClientValid(client))
        return;

    int target = GetClientAimTarget(client, false);

    if(!IsValidIndex(target))
    {
        MenuProp(client);
        return;
    }

    AcceptEntityInput(target, "Kill", -1, -1, 0);
    MenuProp(client);
}

bool IsValidIndex(int ent)
{
    if(ent == -1)
        return false;

    char buffer[256];
    GetEdictClassname(ent, buffer, sizeof(buffer));

    for(int i = 0; i < sizeof(sClass); i++)
    {
        if(!strcmp(buffer, sClass[i]))
        {
            return true;
        }
    }
    return false;
}

bool IsClientValid(int client)
{
	return 0 < client <= MaxClients && IsClientInGame(client);
}

bool TraceRayDontHitSelf(int entity, int mask, any data)
{
	if (entity == data)
	{
		return false;
	}
	return true;
}

bool ValidateAndProcessTargets(
    int client, 
    int args, 
    char[] arg, 
    int argSize, 
    float &amount, 
    int[] targetList, 
    int &targetCount, 
    char[] targetName, 
    int targetNameSize, 
    bool &isMultiTarget, 
    const char[] usageMessage)
{
    if (args < 1)
    {
        ReplyToCommand(client, usageMessage);
        return false;
    }

    GetCmdArg(1, arg, argSize);

    // Если ожидается второй аргумент для числового значения
    if (args > 1)
    {
        if (!GetCmdArgFloatEx(2, amount))
        {
            ReplyToCommand(client, "[SM] %s", "Invalid Amount");
            return false;
        }

        if (amount < 0.0)
        {
            amount = 0.0;
        }
    }

    targetCount = ProcessTargetString(
        arg,
        client,
        targetList,
        MAXPLAYERS,
        COMMAND_FILTER_CONNECTED,
        targetName,
        targetNameSize,
        isMultiTarget);

    if (targetCount <= 0)
    {
        ReplyToTargetError(client, targetCount);
        return false;
    }

    return true;
}

void PerformBury(int client, bool liftUp = false)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        float buryvec[3];
        GetClientAbsOrigin(client, buryvec);

        buryvec[2] += (liftUp ? 50 : -50);

        TeleportEntity(client, buryvec, NULL_VECTOR, NULL_VECTOR);
    }
}

void PerformDisarm(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        int weaponid;
        for (int j = 0; j <= 6; j++)
        {
            weaponid = GetPlayerWeaponSlot(client, j);
            if (weaponid != -1)
            {
                RemovePlayerItem(client, weaponid);
            }
        }
    }
}

void ToggleGodMode(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        if (status[client].God == false)
        {
            status[client].God = true;
            SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
        }
        else if (status[client].God == true)
        {
            status[client].God = false;
            SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
        }
    }
}

void ToggleInvisibility(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        if (status[client].Invis == false)
        {
            status[client].Invis = true;
            SetEntityRenderMode(client, RENDER_NONE);
        }
        else if (status[client].Invis == true)
        {
            status[client].Invis = false;
            SetEntityRenderMode(client, RENDER_NORMAL);
        }
    }
}

void ToggleJetpack(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        if (status[client].Jet == false)
        {
            status[client].Jet = true;
            status[client].Freeze = false;
            status[client].Clip = false;
            SetEntityMoveType(client, MOVETYPE_FLY);
        }
        else if (status[client].Jet == false)
        {
            status[client].Jet = false;
            SetEntityMoveType(client, MOVETYPE_WALK);
        }
    }
}

void ToggleNoclip(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        if (status[client].Clip == false)
        {
            status[client].Clip = true;
            status[client].Freeze = false;
            status[client].Jet = false;
            SetEntityMoveType(client, MOVETYPE_NOCLIP);
        }
        else if (status[client].Clip == true)
        {
            status[client].Clip = false;
            SetEntityMoveType(client, MOVETYPE_WALK);
        }
    }
}

void ToggleRegen(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        if (status[client].Regen == false)
        {
            status[client].Regen = true;
        }
        else if (status[client].Regen == true)
        {
            status[client].Regen = false;
        }
    }
}

void ToggleRocket(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        if (status[client].Rocket == false)
        {
            status[client].Rocket = true;

            if (RocketType == 1)
            {
                SetEntityGravity(client, -0.1);
                float ABSORIGIN[3];
                GetClientAbsOrigin(client, ABSORIGIN);
                ABSORIGIN[2] += 5;
                TeleportEntity(client, ABSORIGIN, NULL_VECTOR, NULL_VECTOR);
            }
            else if (RocketType == 2)
            {
                SetEntityMoveType(client, MOVETYPE_NONE);
            }

            float spriteOrigin[3];
            GetClientAbsOrigin(client, spriteOrigin);
            sprite[client] = CreateEntityByName("env_spritetrail");
            PrecacheModel("sprites/sprite_fire01.vmt", false);

            DispatchKeyValue(sprite[client], "model", "sprites/sprite_fire01.vmt");
            DispatchKeyValue(sprite[client], "endwidth", "2.0");
            DispatchKeyValue(sprite[client], "lifetime", "2.0");
            DispatchKeyValue(sprite[client], "startwidth", "16.0");
            DispatchKeyValue(sprite[client], "renderamt", "255");
            DispatchKeyValue(sprite[client], "rendercolor", "255 255 255");
            DispatchKeyValue(sprite[client], "rendermode", "5");
            DispatchSpawn(sprite[client]);
            TeleportEntity(sprite[client], spriteOrigin, NULL_VECTOR, NULL_VECTOR);
            SetVariantString("");
            AcceptEntityInput(sprite[client], "SetParent");

            PrecacheSound("weapons/rpg/rocketfire1.wav", false);
            EmitSoundToAll("weapons/rpg/rocketfire1.wav", SOUND_FROM_PLAYER, SNDCHAN_STATIC, SNDLEVEL_NORMAL, SND_NOFLAGS, SNDVOL_NORMAL, SNDPITCH_NORMAL, -1, NULL_VECTOR, NULL_VECTOR, true, 0.0);
        }
        else
        {
            status[client].Rocket = false;

            if (RocketType == 1)
            {
                SetEntityGravity(client, 1.0);
            }
            else if (RocketType == 2)
            {
                SetEntityMoveType(client, MOVETYPE_WALK);
            }

            AcceptEntityInput(sprite[client], "Kill", -1, -1, 0);
        }
    }
}

void ToggleSpeed(int client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client))
    {
        switch (status[client].SpeedIndex)
        {
            case 0:
            {
                status[client].SpeedIndex = 1;
                SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 2.0);
            }
            case 1:
            {
                status[client].SpeedIndex = 2;
                SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 3.0);
            }
            case 2:
            {
                status[client].SpeedIndex = 3;
                SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 4.0);
            }
            case 3:
            {
                status[client].SpeedIndex = 4;
                SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 0.5);
            }
            case 4:
            {
                status[client].SpeedIndex = 0;
                SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 1.0);
            }
        }
    }
}

void BecomeBird(int client, int target)
{
    status[target].Beacon = true;   //Маяк

    //Модель птицы 
    GetClientModel(target, playermodel[target], sizeof(playermodel));
    SetEntityModel(target, sModels[22]);
    status[target].Disguise = true;

    //Полёт
    status[target].Jet = true;
    status[target].Freeze = false;
    status[target].Clip = false;
    SetEntityMoveType(target, MOVETYPE_FLY);

    //Разоружить
    int weapon;
    for(int j = 0; j <= 6; j++)
    {
        weapon = GetPlayerWeaponSlot(target, j);
        if(weapon != -1)
            RemovePlayerItem(target, weapon);
    }

    //Вид от 3 лица
    SetEntPropEnt(target, Prop_Send, "m_hObserverTarget", 0);
    SetEntProp(target, Prop_Send, "m_iObserverMode", 1);
    SetEntProp(target, Prop_Send, "m_bDrawViewmodel", 0);
    SetEntProp(target, Prop_Send, "m_iFOV", 100);

    PrintToChatAll("[FSA] Админ [%N] превратил в птицу игрока [%N]", client, target);

    status[target].Bird = true;
}
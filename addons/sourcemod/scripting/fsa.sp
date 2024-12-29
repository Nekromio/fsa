//*
//Какие ракеты вы хотите.
//
//Ракеты типа 1 использует отрицательнуюю гравитацию, чтобы заставить игрока летать. Игроки могут направить их //направлении свободно, и будут двигаться по реальной скорости, которая увеличивается с течением времени. Это не //работает в Zombie: Reloaded(Зомби Моде).
//[+] Плавный полёт / реалистичная скорость.
//[+] Свободное перемещение игрока.
//[-] Не работает в Zombie: Reloaded(Зомби Моде).
//
//Ракеты типа 2 используют периодические телепортации игрока на небольшие расстояния вверх, чтобы имитировать //подъем . Движения идут рывками, так как это телепорт, а не плавное движение игрока вверх. Передвижения игрока //заморожены, чтобы предотвратить от падения вниз после телепорта. Это работает в Zombie: Reloaded.
//[+] Работает в Zombie: Reloaded.
//[-] Нет свободного передвижения игрока.
//[-] Немного рывками.
//[-] С постоянной скоростью все время.
//
//Решите какой RocketType номер вы хотите (1 или 2).
//*/
///*
//По умолчанию флаг для авторизации администраторов использовать ФСА-это флаг буквы "р" (который ADMFLAG_CUSTOM1).
//Просто дать админ-флаг "р" и он будет в состоянии использовать ФСА меню.
//Команду, чтобы открыть главное меню !fsa или /FSA в чат, или fsa в консоли.
//Есть также чат-команды для удобства, так что вам не нужно заходить в меню, чтобы сделать команду.
//Синтаксис их таков: !command playername (!Команда ИмяИгрока)
//Команды:   !jet     (jetpack)
//			!godmode (godmode)
//			!bury    (bury)
//			!unbury  (unbury)
//			!disarm  (disarm)
//			!invis   (invisiblity)
//			!clip    (noclip)
//			!regen   (regeneration)
//			!respawn (respawn)
//			!rocket  (rocket)
//			!speed   (speed)
//Если вы хотели бы изменить в админ-флаг алфавит из-за конфликтующих плагинов, используя те же флаги:
//Если вы используете Notepad, нажмите кнопку Редактировать на верхней, а затем нажмите кнопку заменить. Найти //то, что, типа ADMFLAG_CUSTOM1. Под "заменить на" введите имя флага, который вы хотите изменить. Затем нажмите //кнопку заменить все.
//Если вы используете Pawn Studio, нажмите кнопку Поиск сверху, затем нажмите кнопку заменить, при поиске, типа //ADMFLAG_CUSTOM1. Под "заменить на" введите имя флага, который вы хотите изменить. Затем нажмите кнопку заменить.
//Вот несколько админ-флаг имена вы могли бы хотеть.
//ADMFLAG_GENERIC = b
//ADMFLAG_SLAY    = f
//ADMFLAG_CUSTOM1 = o
//ADMFLAG_CUSTOM2 = p
//ADMFLAG_CUSTOM3 = q
//ADMFLAG_CUSTOM1 = r
//*/

#pragma semicolon 1
#pragma newdecls required

#include <sdktools_functions>
#include <sdktools_sound>
#include <sdktools_engine>
#include <sdktools_entinput>
#include <sdktools_trace>
#include <sdktools_variant_t>
#include <sdktools_tempents>
#include <sdktools_tempents_stocks>
#include <cstrike>

ConVar
	cvEnable,
	cvRocketKill,
	cvRocketSpeed;

int
	PropHealth,
	Explode,
	Rocket1[MAXPLAYERS + 1] = {1,...},
	RocketType = 1,		//Это переменная ракты.
	Engine_Version,
	iBanTime[MAXPLAYERS+1] = {-1, ...},
	iSelectModel[MAXPLAYERS+1],
	iSlapDamage[MAXPLAYERS+1],
	iGlow,
	iLaser,
	sprite[MAXPLAYERS + 1];

float
	RocketVec1[MAXPLAYERS + 1][3],
	RocketVec2[MAXPLAYERS + 1][3],
	RocketZ1[MAXPLAYERS + 1],
	RocketZ2[MAXPLAYERS + 1],
	RotateVec[3],
	fSpeed[MAXPLAYERS+1];
	
char
	name_1[64],
	playermodel[MAXPLAYERS+1][256];

char sSoundList[][] =
{
	"music/HL2_song4.mp3",
	"music/HL2_song31.mp3",
	"music/HL1_song17.mp3",
	"music/HL2_song16.mp3",
	"music/HL2_song12_long.mp3",
	"music/HL2_song7.mp3",
	"music/HL2_song6.mp3",
	"music/HL1_song25_REMIX3.mp3",
	"music/HL2_song3.mp3",
	"music/HL2_song15.mp3",
	"music/HL2_song10.mp3",
	"music/HL2_song17.mp3",
	"music/HL2_song28.mp3",
	"music/HL2_song29.mp3",
	"music/HL2_song14.mp3",
	"music/HL2_song25_Teleporter.mp3",
	"music/HL2_song23_SuitSong3.mp3",
	"music/HL2_song19.mp3",
	"music/Ravenholm_1.mp3",
	"music/HL1_song10.mp3",
	"music/HL2_song20_submix0.mp3",
	"music/HL2_song20_submix4.mp3",
	"music/HL2_song32.mp3",
	"music/HL1_song11.mp3",
	"music/HL2_song33.mp3",
	"music/HL1_song19.mp3",
	"music/HL1_song15.mp3",
};

char sSoundNameList[][] =
{
	"Адреналин",
	"Спокойный Бой",
	"Спокойной Поездки",
	"Осторожный Проезд",
	"Легкий Бой",
	"Начало Ravenholm",
	"Окончательное Восхождение",
	"Half-Life 1 Кредит",
	"Half-Life 2 Кредит",
	"Half-Life 2 Кредит 2",
	"Небеса",
	"Ужасающее Открытие",
	"Ужас",
	"Интенсивный Побег",
	"Путешествие",
	"Величественный Ужас",
	"Воспоминания",
	"Новый Проспект",
	"Ravenholm Концовка",
	"Река Чейз",
	"Медленный Бой",
	"Медленный Бой 2",
	"Печальный Конец",
	"Движок Source",
	"Жуткое Место",
	"Жуткий Туннель",
	"Strider Битва"
};

char sModels[][] =
{
	"models/props_wasteland/barricade001a.mdl",
	"models/props_lab/bewaredog.mdl",
	"models/props_junk/bicycle01a.mdl",
	"models/props/de_inferno/cactus.mdl",
	"models/props/de_inferno/flower_barrel.mdl",
	"models/props/de_inferno/crate_fruit_break.mdl",
	"models/props_combine/breenbust.mdl",
	"models/props/de_inferno/wine_barrel.mdl",
	"models/combine_turrets/floor_turret.mdl",
	"models/combine_super_soldier.mdl",
	"models/combine_soldier.mdl",
	"models/advisor.mdl",
	"models/antlion.mdl",
	"models/headcrabclassic.mdl",
	"models/player.mdl",
	"models/headcrabblack.mdl",
	"models/zombie/classic.mdl",
	"models/props_c17/oildrum001.mdl",
	"models/props/cs_militia/fern01.mdl",
	"models/props/de_nuke/lifepreserver.mdl",
	"models/props/cs_office/snowman_face.mdl",
	"models/props/de_inferno/de_inferno_boulder_01.mdl",
	"models/crow.mdl",
	"models/pigeon.mdl",
	"models/seagull.mdl",
};

char sNameModels[][] =
{
	"Баррикада",
	"Знак: остерегайтесь собак!",
	"Прокат",
	"Кактус",
	"Цветочный Бочонок",
	"Ящик с фруктами",
	"Фигурка",
	"Винная бочка",
	"Башенки",
	"Комбайн Элитный",
	"Комбайн Солдат",
	"Советник",
	"Антлион",
	"ХэдКраб",
	"Загадочный Человек",
	"Ядовитый ХэдКраб",
	"Зомби",
	"Бочка",
	"Папоротник",
	"Поплавок",
	"Голова Снеговика",
	"Камень",
	"Ворона",
	"Голубь",
	"Чайка",
};

char sPhysicModelPerec[][] = 
{
	"models/props/cs_italy/bananna_bunch.mdl",
	"models/props/cs_italy/bananna.mdl",
	"models/props/cs_italy/banannagib1.mdl",
	"models/props/cs_italy/banannagib2.mdl",
	"models/props/cs_italy/bananna_bunch.mdl",
	"models/props_c17/oildrum001.mdl",
	"models/props_c17/oildrum001_explosive.mdl",
	"models/props_c17/oildrumchunk01a.mdl",
	"models/props_c17/oildrumchunk01b.mdl",
	"models/props_c17/oildrumchunk01c.mdl",
	"models/props_c17/oildrumchunk01d.mdl",
	"models/props_c17/oildrumchunk01e.mdl",
	"models/props_c17/oildrum001_explosive.mdl",
	"models/props/cs_office/file_cabinet3.mdl",
	"models/props/cs_italy/orange.mdl",
	"models/props/cs_italy/orangegib1.mdl",
	"models/props/cs_italy/orangegib2.mdl",
	"models/props/cs_italy/orangegib3.mdl",
	"models/props/de_tides/vending_turtle.mdl",
	"models/props/cs_office/vending_machine.mdl",
	"models/props_interiors/vendingmachinesoda01a.mdl",
	"models/props_junk/watermelon01.mdl",
	"models/props_junk/watermelon01_chunk01a.mdl",
	"models/props_junk/watermelon01_chunk01b.mdl",
	"models/props_junk/watermelon01_chunk01c.mdl",
	"models/props_junk/watermelon01_chunk02a.mdl",
	"models/props_junk/watermelon01_chunk02b.mdl",
	"models/props_junk/watermelon01_chunk02c.mdl",
	"models/props/de_inferno/wine_barrel.mdl",
	"models/props/de_inferno/wine_barrel_p1.mdl",
	"models/props/de_inferno/wine_barrel_p2.mdl",
	"models/props/de_inferno/wine_barrel_p3.mdl",
	"models/props/de_inferno/wine_barrel_p4.mdl",
	"models/props/de_inferno/wine_barrel_p5.mdl",
	"models/props/de_inferno/wine_barrel_p6.mdl",
	"models/props/de_inferno/wine_barrel_p7.mdl",
	"models/props/de_inferno/wine_barrel_p8.mdl",
	"models/props/de_inferno/wine_barrel_p9.mdl",
	"models/props/de_inferno/wine_barrel_p10.mdl",
	"models/props/de_inferno/wine_barrel_p11.mdl",
	"models/props/cs_havana/bookcase_large.mdl",
	"models/props/cs_militia/dryer.mdl",
	"models/props/cs_office/sofa.mdl",
};

char sPhysicModelList[][] = 
{
	"models/props/cs_italy/bananna_bunch.mdl",
	"models/props_c17/oildrum001.mdl",
	"models/props_c17/oildrum001_explosive.mdl",
	"models/props/cs_office/file_cabinet3.mdl",
	"models/props/cs_italy/orange.mdl",
	"models/props/de_tides/vending_turtle.mdl",
	"models/props/cs_office/vending_machine.mdl",
	"models/props_interiors/vendingmachinesoda01a.mdl",
	"models/props_junk/watermelon01.mdl",
	"models/props/de_inferno/wine_barrel.mdl",
	"models/props/cs_havana/bookcase_large.mdl",
	"models/props/cs_militia/dryer.mdl",
	"models/props/cs_office/sofa.mdl",
};

char sPhysicNameModelList[][] = 
{
	"Банан",
	"Бочка",
	"Бочка Взрывчатая",
	"Картотечный шкаф",
	"Апельсин",
	"Болотная черепаха",
	"Торговый автомат",
	"Тяжелый торговый автомат",
	"Арбуз",
	"Винная бочка",
	"Книжный шкаф",
	"Сушилка для белья",
	"Софа",
};

char sStaticModelList[][] = 
{
	"models/props/de_inferno/fountain.mdl",
	"models/props/de_inferno/fountain.mdl",
	"models/props_c17/lamppost03a_off.mdl",
	"models/props_pipes/pipecluster32d_001a.mdl",
	"models/props/de_train/processor_nobase.mdl",
	"models/props/de_inferno/de_inferno_boulder_01.mdl",
	"models/props/cs_militia/couch.mdl",
	"models/props/cs_militia/table_kitchen.mdl",
	"models/props_vehicles/apc001.mdl",
	"models/props/cs_militia/toilet.mdl",
};

char sStaticNameModelList[][] = 
{
	"Воздушная лодка",
	"Фонтан",
	"Фонарный столб",
	"Труба",
	"Пропановая машина",
	"Камень",
	"Тканевая Софа",
	"Стол",
	"Танк",
	"Туалет",
};

char sPhysicNPCList[][] = 
{
	"models/props/cs_militia/crate_extralargemill.mdl",
	"models/buggy.mdl",
	"models/props_lab/blastdoor001c.mdl",
	"models/alyx.mdl",
	"models/antlion.mdl",
	"models/antlion_guard.mdl",
	"models/barney.mdl",
	"models/breen.mdl",
	"models/player/ct_gign.mdl",
	"models/crow.mdl",
	"models/dog.mdl",
	"models/eli.mdl",
	"models/headcrab.mdl",
	"models/zombie/fast.mdl",
	"models/headcrabclassic.mdl",
	"models/characters/hostage_02.mdl",
	"models/kleiner.mdl",
	"models/headcrabblack.mdl",
	"models/zombie/poison.mdl",
	"models/player/t_guerilla.mdl",
	"models/vortigaunt.mdl",
	"models/zombie/classic.mdl",
};

char sPhysicNameNPCList[][] = 
{
	"Деревянная коробка",
	"Джип",
	"Взрывная дверь",
	"Аликс",
	"Антлион",
	"Страж антлионов",
	"Барни",
	"Брин",
	"Контр-Террорист",
	"Ворон",
	"Собака",
	"Илай",
	"Быстрый хедкраб",
	"Быстрый зомби",
	"Хедкраб",
	"Заложник",
	"Кляйнер",
	"Отравляющий хедкраб",
	"Отравляющий зомби",
	"Террорист",
	"Вортигонт",
	"Зомби",
};

char sClass[][] = 
{
	"prop_physics",
	"prop_physics_override",
	"prop_dynamic",
	"prop_dynamic_override",
	"prop_physics_multiplayer",
	"prop_dynamic_ornament",
	"prop_static",
};

enum
{
	UNDEFINED = 0,
	GAME_CSS34,
	GAME_CSS,
	GAME_CSGO
}

enum struct Settings
{
	ArrayList hSoundPlay;

	bool Freeze;
	bool Clip;
	bool Disguise;
	bool Drug;
	bool God;
	bool Invis;
	bool Jet;
	bool Rocket;
	bool Regen;
	bool Beacon;
	bool Mute;
	bool Bird;

	int SpeedIndex;
	int BlindAlpha;

	void temporaryData()
    {
        this.hSoundPlay = new ArrayList(ByteCountToCells(256));
    } 

	void Reset()
    {
        this.hSoundPlay.Clear();
    }

	void ResetStatus()
	{
		this.Freeze = false;
		this.Clip = false;
		this.Disguise = false;
		this.Drug = false;
		this.God = false;
		this.Invis = false;
		this.Jet = false;
		this.Rocket = false;
		this.Regen = false;
		this.Beacon = false;
		this.SpeedIndex = 0;
		this.Bird = false;
	}
}

Settings status[MAXPLAYERS+1];

int GetCSGame()
{
	if (GetFeatureStatus(FeatureType_Native, "GetEngineVersion") == FeatureStatus_Available) 
	{
		switch (GetEngineVersion())
		{
			case Engine_SourceSDK2006: return GAME_CSS34; 
			case Engine_CSS: return GAME_CSS; 
			case Engine_CSGO: return GAME_CSGO; 
		}
	}
	return UNDEFINED;
}

#include "fsa/menu/base.sp"
#include "fsa/menu/punishments.sp"
#include "fsa/menu/fun.sp"
#include "fsa/menu/model.sp"
#include "fsa/function.sp"
#include "fsa/commands.sp"

public Plugin myinfo = 
{
	name = "FSA/ФСА Админ",
	author = "LightningZLaser( rewritten Nek.'a 2x2 | ggwp.site )",
	description = "Расширенные возможности администратора",
	version = "1.5.7",
}

public APLRes AskPluginLoad2()
{
	Engine_Version = GetCSGame();

	if(!Engine_Version)
		SetFailState("Game is not supported!");

	return APLRes_Success;
}

public void OnPluginStart()
{
	cvEnable = CreateConVar("sm_fsa_enable", "1", "Включить плагин");
	cvRocketKill = CreateConVar("sm_fsa_rocket_kill", "1", "Если значение 1, то игроки будут умирать, когда взлетают ракетой");
	cvRocketSpeed = CreateConVar("sm_fsa_rocket_speed", "20.0", "Устанавливает скорость ракеты. Важное Примечание: должно быть больше 5 (6 как минимум)");

	HookEvent("round_start", Event_RoundStart);
	HookEvent("player_death", Event_PlayerDeath);

	RegAdminCmd("sm_fsa", Cmd_MenuBasic, ADMFLAG_CUSTOM1);
	RegAdminCmd("fsa", Cmd_MenuBasic, ADMFLAG_CUSTOM1);
	
	RegAdminCmd("sm_fsa_bury", Cmd_Bury, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_unbury", Cmd_Unbury, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_disarm", Cmd_Disarm, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_godmode", Cmd_God, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_invis", Cmd_Invis, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_jet", Cmd_Jet, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_jetpack", Cmd_Jet, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_clip", Cmd_Clip, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_regen", Cmd_Regen, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_rocket", Cmd_Rocket, ADMFLAG_CUSTOM1);
	RegAdminCmd("sm_fsa_speed", Cmd_Speed, ADMFLAG_CUSTOM1);
	
	CreateTimer(1.0, TimerRepeat, _, TIMER_REPEAT);
	if(RocketType == 1) CreateTimer(0.1, RocketTimer, _, TIMER_REPEAT);
	if(RocketType == 2) CreateTimer(0.1, RocketTimer2, _, TIMER_REPEAT);
	CreateTimer(1.0, Timer_Beacon, _, TIMER_REPEAT);

	CheckPlayer();
}

void CheckPlayer()
{
	for(int i = 1; i <= MaxClients; i++) if(IsClientInGame(i))
		status[i].temporaryData();
}

public void OnClientPostAdminCheck(int client)
{
	if(IsFakeClient(client))
		return;

	status[client].temporaryData();
}

public void OnClientDisconnect(int client)
{
	if(!IsClientValid(client) || IsFakeClient(client) || !status[client].hSoundPlay)
		return;
	
	status[client].Reset();
}

public void OnMapStart()
{
	for(int i = 0; i < sizeof(sSoundList); i++)
	{
		PrecacheSound(sSoundList[i], true);
	}

	for(int i = 0; i < sizeof(sModels); i++)
	{
		PrecacheModel(sModels[i], true);
	}

	for(int i = 0; i < sizeof(sPhysicModelPerec); i++)
	{
		PrecacheModel(sPhysicModelPerec[i], true);
	}

	for(int i = 0; i < sizeof(sStaticModelList); i++)
	{
		PrecacheModel(sStaticModelList[i], true);
	}

	for(int i = 0; i < sizeof(sPhysicNPCList); i++)
	{
		PrecacheModel(sPhysicNPCList[i], true);
	}

	if(Engine_Version != GAME_CSGO)
	{
		PrecacheSound("tools/ifm/beep.wav", false);
		iLaser = PrecacheModel("sprites/bluelaser1.vmt");
		iGlow = PrecacheModel("sprites/blueglow1.vmt");
		
	}
	else
	{
		PrecacheSound("buttons/button17.wav", false);
		iLaser = PrecacheModel("sprites/blueflare1.vmt");
		iGlow = PrecacheModel("sprites/blueglow1.vmt");
	}
	PrecacheSound("weapons/rpg/rocket1.wav", false);
}

void Event_RoundStart(Event event, const char[] name, bool Broadcast)
{
	for (int i = 1; i <= MaxClients; i++) if(IsClientInGame(i))
	{
		status[i].ResetStatus();
	}
}

void Event_PlayerDeath(Event event, const char[] name, bool Broadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));

	if(status[client].Rocket)
	{
		for (int i = 1; i <= MaxClients; i++)
		{
			StopSound(i, SNDCHAN_STATIC, "weapons/rpg/rocket1.wav");
		}
		AcceptEntityInput(sprite[client], "Kill", -1, -1, 0);
	}
	status[client].ResetStatus();
	SetEntityGravity(client, 1.0);
}

Action TimerRepeat(Handle timer)
{
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i))
		{
			if (((status[i].Regen == true) && (GetClientHealth(i) <= 10000) && (IsClientInGame(i)) && (IsPlayerAlive(i))))
			{
				int HealthHP = GetClientHealth(i);
				int ResultingHP = HealthHP + 500;
				SetEntityHealth(i, ResultingHP);
			}
		}
	}
	return Plugin_Continue;
}

Action RocketTimer(Handle timer)
{
	for (int i = 1; i <= MaxClients; i++)
	{
		if ((status[i].Rocket == true) && (IsClientInGame(i)) && (IsPlayerAlive(i)))
		{
			if (Rocket1[i] == 1)
			{
				GetClientAbsOrigin(i, RocketVec1[i]);
				RocketZ1[i] = RocketVec1[i][2];
				if (RocketZ1[i] == RocketZ2[i])
				{
					if (cvRocketKill.BoolValue)
					{
						ForcePlayerSuicide(i);
					}
					for (int k = 1; k <= MaxClients; k++)
					{
						StopSound(k, SNDCHAN_STATIC, "weapons/rpg/rocket1.wav");
					}
					if(sprite[i] && IsValidEntity(sprite[i]))
						AcceptEntityInput(sprite[i], "Kill", -1, -1, 0);
					PrecacheSound("weapons/explode3.wav", false);
					EmitSoundToAll("weapons/explode3.wav", SOUND_FROM_PLAYER, SNDCHAN_STATIC, SNDLEVEL_NORMAL, SND_NOFLAGS, SNDVOL_NORMAL, SNDPITCH_NORMAL, -1, NULL_VECTOR, NULL_VECTOR, true, 0.0);
				}
				Rocket1[i] = 0;
			}
			else if (Rocket1[i] == 0)
			{
				GetClientAbsOrigin(i, RocketVec2[i]);
				RocketZ2[i] = RocketVec2[i][2];
				if (RocketZ2[i] == RocketZ1[i])
				{
					if(cvRocketKill.BoolValue)
					{
						ForcePlayerSuicide(i);
					}
					for (int k = 1; k <= MaxClients; k++)
					{
						StopSound(k, SNDCHAN_STATIC, "weapons/rpg/rocket1.wav");
					}
					if(IsValidEntity(sprite[i])) AcceptEntityInput(sprite[i], "Kill", -1, -1, 0);
					PrecacheSound("weapons/explode3.wav", false);
					EmitSoundToAll("weapons/explode3.wav", SOUND_FROM_PLAYER, SNDCHAN_STATIC, SNDLEVEL_NORMAL, SND_NOFLAGS, SNDVOL_NORMAL, SNDPITCH_NORMAL, -1, NULL_VECTOR, NULL_VECTOR, true, 0.0);
				}
				Rocket1[i] = 1;
			}
		}
	}
	return Plugin_Continue;
}

Action RocketTimer2(Handle timer)
{
	for (int i = 1; i <= MaxClients; i++)
	{
		if ((status[i].Rocket == true) && (IsClientInGame(i)) && (IsPlayerAlive(i)))
		{
			float RocketAbsOrigin[3], RocketEndOrigin[3], AbsAngle[3];
			GetClientEyePosition(i, RocketAbsOrigin);
			AbsAngle[0] = -90.0;
			AbsAngle[1] = 0.0;
			AbsAngle[2] = 0.0;
			TR_TraceRayFilter(RocketAbsOrigin, AbsAngle, MASK_SOLID, RayType_Infinite, TraceRayDontHitSelf);
			TR_GetEndPosition(RocketEndOrigin);
			float DistanceBetween = RocketEndOrigin[2] - RocketAbsOrigin[2];
			if (DistanceBetween <= (cvRocketSpeed.FloatValue + 0.1))
			{
				if (cvRocketKill.BoolValue)
				{
					ForcePlayerSuicide(i);
				}
				for (int k = 1; k <= MaxClients; k++)
				{
					StopSound(k, SNDCHAN_STATIC, "weapons/rpg/rocket1.wav");
				}
				CreateTimer(2.0, StopRocketSound);
				AcceptEntityInput(sprite[i], "Kill", -1, -1, 0);
				PrecacheSound("weapons/explode3.wav", false);
				EmitSoundToAll("weapons/explode3.wav", SOUND_FROM_PLAYER, SNDCHAN_STATIC, SNDLEVEL_NORMAL, SND_NOFLAGS, SNDVOL_NORMAL, SNDPITCH_NORMAL, -1, NULL_VECTOR, NULL_VECTOR, true, 0.0);
				if (IsPlayerAlive(i))
				{
					status[i].Rocket = false;
					SetEntityMoveType(i, MOVETYPE_WALK);
					float ClientOrigin[3];
					GetClientAbsOrigin(i, ClientOrigin);
					ClientOrigin[2] = ClientOrigin[2] - (cvRocketSpeed.FloatValue + 0.1);
					TeleportEntity(i, ClientOrigin, NULL_VECTOR, NULL_VECTOR);
				}
			}
			else if (DistanceBetween >= (cvRocketSpeed.FloatValue + 0.1))
			{
				float ClientOrigin[3];
				GetClientAbsOrigin(i, ClientOrigin);
				ClientOrigin[2] = ClientOrigin[2] + cvRocketSpeed.FloatValue;
				TeleportEntity(i, ClientOrigin, NULL_VECTOR, NULL_VECTOR);
			}
		}
	}
	return Plugin_Continue;
}

Action RocketLaunchTimer(Handle timer)
{
	EmitSoundToAll("weapons/rpg/rocket1.wav", SOUND_FROM_PLAYER, SNDCHAN_STATIC, SNDLEVEL_NORMAL, SND_NOFLAGS, SNDVOL_NORMAL, SNDPITCH_NORMAL, -1, NULL_VECTOR, NULL_VECTOR, true, 0.0);
	return Plugin_Continue;
}

Action Timer_Beacon(Handle timer)
{
	int color[4];
	for (int i = 1; i <= MaxClients; i++)
	{
		if ((status[i].Beacon == true) && (IsClientInGame(i)) && (IsPlayerAlive(i)))
		{
			float vec[3];
			GetClientAbsOrigin(i, vec);
			vec[2] += 30;
			
			color[0] = 0;
			color[1] = 255;
			color[2] = 0;
			color[3] = 255;
			
			TE_SetupBeamRingPoint(vec, 10.0, 750.0, iLaser, iGlow, 0, 10, 0.6, 10.0, 0.5, color, 10, 0);
			TE_SendToAll();

			GetClientEyePosition(i, vec);
			if(Engine_Version != GAME_CSGO)
			{
				EmitAmbientSound("tools/ifm/beep.wav", vec, i, SNDLEVEL_RAIDSIREN);
			}
			else
			{
				EmitAmbientSound("buttons/button17.wav", vec, i, SNDLEVEL_RAIDSIREN);
			}
		}
	}
	return Plugin_Continue;
}

Action StopRocketSound(Handle timer)
{
	for (int k = 1; k <= MaxClients; k++)
	{
		PrecacheSound("weapons/rpg/rocket1", false);
		StopSound(k, SNDCHAN_STATIC, "weapons/rpg/rocket1.wav");
	}
	return Plugin_Continue;
}
-- Prepared from the verified classicmangos1 snapshot; server must be stopped.
START TRANSACTION;
UPDATE creature_template SET AIName='EventAI', ScriptName='' WHERE Entry=6206;
UPDATE creature_template SET AIName='EventAI', ScriptName='npc_gnomeregan_radiation' WHERE Entry=6218;
UPDATE creature_template SET AIName='EventAI', ScriptName='npc_gnomeregan_radiation' WHERE Entry=6219;
UPDATE creature_template SET AIName='EventAI', ScriptName='npc_gnomeregan_radiation' WHERE Entry=6220;
UPDATE creature_template SET AIName='EventAI', ScriptName='npc_gnomeregan_mechanical_support' WHERE Entry=6222;
UPDATE creature_template SET AIName='EventAI', ScriptName='npc_gnomeregan_mechanical_support' WHERE Entry=6224;
UPDATE creature_template SET AIName='EventAI', ScriptName='' WHERE Entry=6225;
UPDATE creature_template SET AIName='EventAI', ScriptName='' WHERE Entry=7603;
UPDATE creature_template SET AIName='EventAI', ScriptName='' WHERE Entry=7915;
DELETE FROM creature_ai_scripts WHERE creature_id IN (6206,6218,6219,6220,6222,6224,6225,7603,7915);
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
(620601,6206,4,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Set Phase 1 on Aggro'),
(620602,6206,0,0,100,1025,1100,4800,182900,184500,0,0,11,7164,0,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Cast Defensive Stance'),
(620603,6206,9,5,100,1025,0,5,6100,9700,0,0,11,7405,1,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Cast Sunder Armor (Phase 1)'),
(620604,6206,24,5,100,1,7405,5,5000,5000,0,0,22,2,0,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
(620605,6206,28,3,100,1,7405,1,5000,5000,0,0,22,1,0,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
(620606,6206,8,0,100,0,9798,-1,0,0,0,0,1,3367,0,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Emote on Radiation Spellhit'),
(620607,6206,2,0,100,0,15,0,0,0,0,0,25,0,0,0,1,1150,0,0,0,0,0,0,'Caverndeep Burrower - Flee at 15% HP'),
(620608,6206,7,0,100,0,0,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Set Phase to 0 on Evade'),
(621801,6218,1,0,100,0,1000,1000,0,0,0,0,11,21862,0,32,0,0,0,0,0,0,0,0,'Irradiated Slime - Cast Radiation Visual OOC'),
(621802,6218,6,0,100,0,0,0,0,0,0,0,11,10341,0,7,0,0,0,0,0,0,0,0,'Irradiated Slime - Cast Radiation Cloud on Death'),
(622001,6220,11,0,100,0,0,0,0,0,0,0,11,9205,0,34,0,0,0,0,0,0,0,0,'Irradiated Horror - Cast Hate to Zero on Spawn'),
(622002,6220,0,0,100,1025,8000,19300,9700,21700,0,0,11,8211,1,0,0,0,0,0,0,0,0,0,'Irradiated Horror - Cast Chain Burn'),
(622003,6220,1,0,100,0,1000,1000,0,0,0,0,11,21862,0,32,0,0,0,0,0,0,0,0,'Irradiated Horror - Cast Radiation Visual OOC'),
(622201,6222,8,0,100,0,9798,-1,0,0,0,0,1,3367,0,0,0,0,0,0,0,0,0,0,'Leprous Technician - Emote on Radiation Spellhit'),
(622202,6222,1,0,100,1,10000,45000,30000,70000,0,0,11,10348,0,0,0,0,0,0,0,0,0,0,'Leprous Technician - Cast Tune Up OOC'),
(622203,6222,4,0,10,0,0,0,0,0,0,0,54,0,0,3,0,0,0,0,0,0,0,0,'Leprous Technician - Random Say on Aggro'),
(622204,6222,4,0,100,0,0,0,0,0,0,0,57,2,35,0,39,10,0,0,0,0,0,0,'Leprous Technician - Enable Range Mode and Call For Help on Aggro'),
(622206,6222,0,0,100,1025,5000,12000,9000,18000,0,0,11,12024,1,0,0,0,0,0,0,0,0,0,'Leprous Technician - Net (AzerothCore 3.3.5a)'),
(622401,6224,8,0,100,0,9798,-1,0,0,0,0,1,3367,0,0,0,0,0,0,0,0,0,0,'Leprous Machinesmith - Emote on Radiation Spellhit'),
(622402,6224,1,0,100,1,10000,45000,30000,70000,0,0,11,10348,0,0,0,0,0,0,0,0,0,0,'Leprous Machinesmith - Cast Tune Up OOC'),
(622403,6224,4,0,10,0,0,0,0,0,0,0,54,0,0,3,0,0,0,0,0,0,0,0,'Leprous Machinesmith - Random Say on Aggro'),
(622404,6224,4,0,100,0,0,0,0,0,0,0,57,2,35,0,39,10,0,0,0,0,0,0,'Leprous Machinesmith - Enable Range Mode and Call For Help on Aggro'),
(622501,6225,4,0,100,0,0,0,0,0,0,0,57,2,25,0,0,0,0,0,0,0,0,0,'Mechano-Tank - Enable Range Mode on Aggro'),
(622502,6225,9,0,100,1025,5,30,1000,3700,0,0,11,10346,1,256,0,0,0,0,0,0,0,0,'Mechano-Tank - Cast Machine Gun'),
(622503,6225,0,0,20,1025,0,1000,20000,20000,0,0,11,17174,1,0,0,0,0,0,0,0,0,0,'Mechano-Tank - Concussive Shot (VMaNGOS, 20 percent)'),
(760301,7603,4,0,100,0,0,0,0,0,0,0,39,10,0,0,0,0,0,0,0,0,0,0,'Leprous Assistant - Call for Help on Aggro'),
(760302,7603,4,0,20,0,0,0,0,0,0,0,54,0,0,3,0,0,0,0,0,0,0,0,'Leprous Assistant - Random Say on Aggro'),
(760303,7603,8,0,100,0,9798,-1,0,0,0,0,1,3367,0,0,0,0,0,0,0,0,0,0,'Leprous Assistant - Emote on Radiation Spellhit'),
(760304,7603,0,0,100,1025,5000,12000,9000,18000,0,0,11,12024,1,0,0,0,0,0,0,0,0,0,'Leprous Assistant - Net (AzerothCore 3.3.5a)'),
(791501,7915,9,0,100,1024,0,5,0,0,0,0,11,11504,0,6,0,0,0,0,0,0,0,0,'Walking Bomb - Detonate within 5 yards (ClassicDB/VMaNGOS)'),
(791502,7915,11,0,100,0,0,0,0,0,0,0,20,0,0,0,0,0,0,0,0,0,0,0,'Walking Bomb - Disable normal melee on spawn (VMaNGOS)');
UPDATE creature_template_addon SET auras=NULL WHERE entry=6219;
UPDATE creature_template_addon SET auras=NULL WHERE entry=7915;
DELETE FROM spell_scripts WHERE Id IN (10341,10345,10732);
INSERT INTO `spell_scripts` (`Id`,`ScriptName`) VALUES
(10341,'spell_gnomeregan_trash_radiation_cloud'),
(10345,'spell_gnomeregan_mechanical_support'),
(10732,'spell_gnomeregan_mechanical_support');
COMMIT;

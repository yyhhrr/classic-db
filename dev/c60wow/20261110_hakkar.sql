-- Lock all four tables because the creature template and EventAI use MyISAM.
SET NAMES utf8;
CREATE TEMPORARY TABLE `hakkar_guard` (`Present` TINYINT NOT NULL PRIMARY KEY) ENGINE=MEMORY;
INSERT INTO `hakkar_guard` VALUES (1);

LOCK TABLES `spell_scripts` WRITE, `creature_template` WRITE,
    `creature_ai_scripts` WRITE, `creature_spell_list` WRITE;

SELECT COUNT(*) = 2 INTO @hakkar_templates_ok
FROM `creature_template`
WHERE (`Entry` = 14834 AND `SpellList` = 1483401 AND BINARY `AIName` = '' AND BINARY `ScriptName` = 'boss_hakkar')
    OR (`Entry` = 14989 AND `SpellList` = 0 AND BINARY `AIName` = 'EventAI'
        AND BINARY `ScriptName` IN ('','npc_hakkar_poison_cloud'));

SELECT COUNT(*) = COALESCE(SUM(
    (`Flags`,`CombatCondition`,`ScriptId`,`Availability`,`Probability`) = (0,-1,0,100,1)
    AND (`Position`,`SpellId`,`TargetId`,`InitialMin`,`InitialMax`,`RepeatMin`,`RepeatMax`,BINARY `Comments`) IN
        ((2,24327,7,17000,17000,10000,15000,'Hakkar - Cause Insanity on Current'),
         (3,24178,101,17000,17000,25000,35000,'Hakkar - Will of Hakkar on Random non tank'),
         (4,24318,0,6000000,6000000,6000000,6000000,'Hakkar - Enrage on None'))),0)
INTO @hakkar_spells_ok
FROM `creature_spell_list`
WHERE `Id` = 1483401 AND (`Position` IN (2,3,4) OR `SpellId` IN (24327,24178,24318));

SELECT COUNT(*) = COALESCE(SUM(
    `creature_id` = 14989 AND (`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`) = (11,0,100,0)
    AND (`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`) = (0,0,0,0,0,0)
    AND (`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`) = (11,24320,0,0)
    AND (`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`) = (0,0,0,0)
    AND (`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`) = (0,0,0,0)
    AND BINARY `comment` = 'Poisonous Cloud - Cast Poisonous Blood on Spawn'),0)
INTO @hakkar_cloud_event_ok
FROM `creature_ai_scripts` WHERE `id` = 1498901;

SELECT COALESCE(SUM(`Id` = 24324 AND BINARY `ScriptName` = 'spell_hakkar_blood_siphon'),0) = 1
    AND COALESCE(SUM(`Id` = 24693 AND BINARY `ScriptName` = 'spell_hakkar_power_down'),0) = 1
    AND COUNT(*) = COALESCE(SUM((`Id`,BINARY `ScriptName`) IN
        ((24320,'spell_hakkar_poisonous_cloud'),(24323,'spell_hakkar_blood_siphon_poisoned'),(24324,'spell_hakkar_blood_siphon'),
         (24328,'spell_hakkar_corrupted_blood'),(24693,'spell_hakkar_power_down'))),0)
INTO @hakkar_bindings_ok
FROM `spell_scripts` WHERE `Id` IN (24320,24323,24324,24328,24693);

-- Accept a known partially applied state so the migration can be retried.
SET @hakkar_ok = @hakkar_templates_ok AND @hakkar_spells_ok AND @hakkar_cloud_event_ok AND @hakkar_bindings_ok;
-- The duplicate key stops batch clients and each write stays gated under --force.
INSERT INTO `hakkar_guard` SELECT 1 WHERE NOT @hakkar_ok;

-- Mind control and enrage timing now live in the Hakkar AI.
DELETE FROM `creature_spell_list` WHERE @hakkar_ok AND `Id` = 1483401 AND `Position` IN (2,3,4);

-- The cloud AI manages repeat pulses for its original summoned lifetime.
UPDATE `creature_template` SET `ScriptName` = 'npc_hakkar_poison_cloud' WHERE @hakkar_ok AND `Entry` = 14989;
DELETE FROM `creature_ai_scripts` WHERE @hakkar_ok AND `id` = 1498901;

INSERT IGNORE INTO `spell_scripts` (`Id`,`ScriptName`)
SELECT 24320,'spell_hakkar_poisonous_cloud' WHERE @hakkar_ok;
INSERT IGNORE INTO `spell_scripts` (`Id`,`ScriptName`)
SELECT 24323,'spell_hakkar_blood_siphon_poisoned' WHERE @hakkar_ok;
INSERT IGNORE INTO `spell_scripts` (`Id`,`ScriptName`)
SELECT 24328,'spell_hakkar_corrupted_blood' WHERE @hakkar_ok;

UNLOCK TABLES;
DROP TEMPORARY TABLE `hakkar_guard`;

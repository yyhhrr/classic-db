-- Verify the reviewed Jin'do rows before changing them. Both directions are repeatable.
-- The four changed tables include MyISAM. Locks keep the guards and writes together.
CREATE TEMPORARY TABLE `jindo_guard` (`ok` TINYINT NOT NULL PRIMARY KEY) ENGINE=MEMORY;
INSERT INTO `jindo_guard` VALUES (1);
LOCK TABLES `creature_template` WRITE, `creature_spell_list` WRITE, `creature_ai_scripts` WRITE,
    `spell_scripts` WRITE, `spell_script_target` READ;

SELECT COUNT(*) = 2 INTO @jindo_templates_ok
FROM `creature_template`
WHERE (`Entry` = 11380 AND BINARY `AIName` = 'EventAI' AND `SpellList` = 1138001
       AND BINARY `ScriptName` IN ('', 'boss_jindo'))
   OR (`Entry` = 14986 AND BINARY `AIName` = 'EventAI' AND `SpellList` = 0
       AND BINARY `ScriptName` IN ('', 'npc_shade_of_jindo'));

SELECT COUNT(*) = 2 INTO @jindo_spells_ok
FROM `creature_spell_list`
WHERE (`Id` = 1138001 AND `Position` = 2 AND `SpellId` = 24309
       AND `Flags` = 0 AND `CombatCondition` = -1 AND `TargetId` = 0 AND `ScriptId` = 0
       AND `Availability` = 100 AND `Probability` = 1 AND `InitialMin` = 16000 AND `InitialMax` = 16000
       AND (`RepeatMin`, `RepeatMax`) IN ((60000, 90000), (14000, 20000))
       AND BINARY `Comments` = 'Jin''do the Hexxer - Powerful Healing Ward on None')
   OR (`Id` = 1498701 AND `Position` = 0 AND `Flags` = 0 AND `CombatCondition` = -1
       AND `ScriptId` = 0 AND `Availability` = 100 AND `Probability` = 1
       AND (`SpellId`, `TargetId`, `InitialMin`, `InitialMax`, `RepeatMin`, `RepeatMax`) IN
           ((24684, 101, 4000, 10000, 8000, 16000), (24310, 0, 0, 0, 0, 0))
       AND BINARY `Comments` = 'Powerful Healing Ward - passive spell Powerful Healing Ward');

SELECT COUNT(*) = COALESCE(SUM(
    `creature_id` = 14986 AND `event_type` = 11 AND `event_inverse_phase_mask` = 0
    AND `event_chance` = 100 AND `event_flags` = 0
    AND `event_param1` = 0 AND `event_param2` = 0 AND `event_param3` = 0
    AND `event_param4` = 0 AND `event_param5` = 0 AND `event_param6` = 0
    AND (`action1_type`, `action1_param1`, `action1_param2`, `action1_param3`) = (11, 24307, 0, 34)
    AND (`action2_type`, `action2_param1`, `action2_param2`, `action2_param3`) = (11, 24313, 0, 34)
    AND (`action3_type`, `action3_param1`, `action3_param2`, `action3_param3`) = (0, 0, 0, 0)
    AND BINARY `comment` = 'Shade of Jin''do - Cast Shade of Jin''do Passive, Shade Visual on Spawn'), 0)
INTO @jindo_event_ok
FROM `creature_ai_scripts` WHERE `id` = 1498601;

SELECT COUNT(*) = COALESCE(SUM(
    (`Id`, BINARY `ScriptName`) IN (
        (24262, 'spell_jindo_brain_wash_totem'), (24306, 'spell_delusions_of_jindo'),
        (24308, 'spell_summon_shade_of_jindo'), (24310, 'spell_jindo_healing_ward'),
        (24311, 'spell_jindo_healing_ward_heal'))), 0)
INTO @jindo_bindings_ok
FROM `spell_scripts` WHERE `Id` IN (24262, 24306, 24308, 24310, 24311);

SELECT COUNT(*) = 1 AND COALESCE(SUM(`type` = 1 AND `targetEntry` = 11380 AND `inverseEffectMask` = 0), 0) = 1
INTO @jindo_target_ok
FROM `spell_script_target` WHERE `entry` = 24311;

SET @jindo_ok = @jindo_templates_ok AND @jindo_spells_ok AND @jindo_event_ok
    AND @jindo_bindings_ok AND @jindo_target_ok;
-- Abort on a conflicting row and gate writes even if a client continues after the error.
INSERT INTO `jindo_guard` SELECT 1 FROM DUAL WHERE NOT @jindo_ok;

UPDATE `creature_template`
SET `ScriptName` = CASE `Entry` WHEN 11380 THEN 'boss_jindo' WHEN 14986 THEN 'npc_shade_of_jindo' END
WHERE @jindo_ok AND `Entry` IN (11380, 14986);

UPDATE `creature_spell_list` SET `RepeatMin` = 14000, `RepeatMax` = 20000
WHERE @jindo_ok AND `Id` = 1138001 AND `Position` = 2;
UPDATE `creature_spell_list`
SET `SpellId` = 24310, `TargetId` = 0, `InitialMin` = 0, `InitialMax` = 0, `RepeatMin` = 0, `RepeatMax` = 0
WHERE @jindo_ok AND `Id` = 1498701 AND `Position` = 0;

DELETE FROM `creature_ai_scripts` WHERE @jindo_ok AND `id` = 1498601;

DELETE FROM `spell_scripts`
WHERE @jindo_ok AND (`Id`, `ScriptName`) IN
    ((24306, 'spell_delusions_of_jindo'), (24308, 'spell_summon_shade_of_jindo'));
INSERT IGNORE INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24262, 'spell_jindo_brain_wash_totem' FROM DUAL WHERE @jindo_ok;
INSERT IGNORE INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24310, 'spell_jindo_healing_ward' FROM DUAL WHERE @jindo_ok;
INSERT IGNORE INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24311, 'spell_jindo_healing_ward_heal' FROM DUAL WHERE @jindo_ok;

UNLOCK TABLES;
DROP TEMPORARY TABLE `jindo_guard`;

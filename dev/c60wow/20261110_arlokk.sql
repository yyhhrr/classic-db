-- Guard the touched rows against the verified Arlokk baseline.
CREATE TEMPORARY TABLE `arlokk_expected_spells` LIKE `creature_spell_list`;
INSERT INTO `arlokk_expected_spells` VALUES
(1451501,1,24210,0,-1,100,0,100,1,5000,5000,30000,30000,'High Priestess Arlokk Phase 1 - Mark of Arlokk on Random'),
(1451501,2,12540,0,-1,1,0,100,1,14000,14000,17000,27000,'High Priestess Arlokk Phase 1 - Gouge on Current'),
(1451502,2,24236,0,-1,0,0,100,1,15000,15000,17000,27000,'High Priestess Arlokk Phase 2 - Whirlwind on None'),
(1451502,3,24223,0,-1,0,0,100,1,5000,10000,85000,85000,'High Priestess Arlokk Phase 2 - Vanish on None');

CREATE TEMPORARY TABLE `arlokk_guard` (`Present` TINYINT NOT NULL PRIMARY KEY) ENGINE=MEMORY;
INSERT INTO `arlokk_guard` VALUES (1);

-- The event and target tables can use MyISAM.
LOCK TABLES `spell_scripts` WRITE, `spell_script_target` WRITE, `creature_spell_list` WRITE,
    `gameobject_template` WRITE, `dbscripts_on_event` WRITE;

SELECT COUNT(*) = COALESCE(SUM(
    (`Id` IN (24223,24228) AND BINARY `ScriptName` = 'spell_arlokk_vanish') OR
    (`Id` = 24211 AND BINARY `ScriptName` = 'spell_arlokk_mark_threat')), 0)
    AND COALESCE(SUM(`Id` IN (24223,24228)), 0) > 0
INTO @arlokk_bindings_ok
FROM `spell_scripts`
WHERE `Id` IN (24211,24223,24228);

SELECT COUNT(*) = COALESCE(SUM(`type` = 1 AND `targetEntry` = 15101 AND `inverseEffectMask` = 0), 0)
INTO @arlokk_targets_ok
FROM `spell_script_target` WHERE `entry` = 24211;

SELECT COUNT(*) = COUNT(`arlokk_expected_spells`.`Id`) INTO @arlokk_spells_ok
FROM `creature_spell_list`
LEFT JOIN `arlokk_expected_spells` ON
    (`creature_spell_list`.`Id`, `creature_spell_list`.`Position`, `creature_spell_list`.`SpellId`,
     `creature_spell_list`.`Flags`, `creature_spell_list`.`CombatCondition`, `creature_spell_list`.`TargetId`,
     `creature_spell_list`.`ScriptId`, `creature_spell_list`.`Availability`, `creature_spell_list`.`Probability`,
     `creature_spell_list`.`InitialMin`, `creature_spell_list`.`InitialMax`, `creature_spell_list`.`RepeatMin`,
     `creature_spell_list`.`RepeatMax`, BINARY `creature_spell_list`.`Comments`) =
    (`arlokk_expected_spells`.`Id`, `arlokk_expected_spells`.`Position`, `arlokk_expected_spells`.`SpellId`,
     `arlokk_expected_spells`.`Flags`, `arlokk_expected_spells`.`CombatCondition`, `arlokk_expected_spells`.`TargetId`,
     `arlokk_expected_spells`.`ScriptId`, `arlokk_expected_spells`.`Availability`, `arlokk_expected_spells`.`Probability`,
     `arlokk_expected_spells`.`InitialMin`, `arlokk_expected_spells`.`InitialMax`, `arlokk_expected_spells`.`RepeatMin`,
     `arlokk_expected_spells`.`RepeatMax`, BINARY `arlokk_expected_spells`.`Comments`)
WHERE (`creature_spell_list`.`Id`, `creature_spell_list`.`Position`) IN ((1451501,1),(1451501,2),(1451502,2),(1451502,3))
   OR (`creature_spell_list`.`Id` IN (1451501,1451502) AND `creature_spell_list`.`SpellId` IN (12540,24210,24223,24236));

SELECT COUNT(*) = 1 INTO @arlokk_gong_ok
FROM `gameobject_template`
WHERE `entry` = 180526 AND `type` = 10 AND `data2` IN (0,9066)
  AND BINARY `ScriptName` = 'go_gong_of_bethekk';

SELECT COUNT(*), COUNT(*) <= 1 AND COUNT(*) = COALESCE(SUM(
    `delay` = 10000 AND `priority` = 0 AND `command` = 10 AND `datalong` = 14515 AND `datalong2` = 900000
    AND `datalong3` = 0 AND `buddy_entry` = 0 AND `search_radius` = 0 AND `data_flags` = 0
    AND `dataint` = 0 AND `dataint2` = 0 AND `dataint3` = 0 AND `dataint4` = 0 AND `datafloat` = 0
    AND `x` = -11540.7001953125 AND `y` = -1627.7099609375 AND `z` = 41.27000045776367
    AND `o` = 0.10000000149011612 AND `speed` = 0 AND `condition_id` = 0 AND BINARY `comments` = ''), 0)
INTO @arlokk_event_count, @arlokk_event_ok
FROM `dbscripts_on_event` WHERE `id` = 9066;

SET @arlokk_ok = @arlokk_bindings_ok AND @arlokk_targets_ok AND @arlokk_spells_ok AND @arlokk_gong_ok AND @arlokk_event_ok;
-- Reject a conflicting baseline. The checks also gate writes if the client continues after errors.
INSERT INTO `arlokk_guard` SELECT 1 WHERE NOT @arlokk_ok;

-- The script effect is on Vanish (24223). Teleport (24228) remains a child spell.
INSERT IGNORE INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24223, 'spell_arlokk_vanish' WHERE @arlokk_ok;
DELETE FROM `spell_scripts` WHERE @arlokk_ok AND `Id` = 24228 AND `ScriptName` = 'spell_arlokk_vanish';

INSERT IGNORE INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24211, 'spell_arlokk_mark_threat' WHERE @arlokk_ok;
INSERT IGNORE INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`)
SELECT 24211, 1, 15101, 0 WHERE @arlokk_ok;

-- These abilities are now scheduled by the encounter script.
DELETE FROM `creature_spell_list`
WHERE @arlokk_ok AND (`Id`, `Position`, `SpellId`) IN
    ((1451501,1,24210),(1451501,2,12540),(1451502,2,24236),(1451502,3,24223));

-- The instance now owns the delayed summon. Remove the old automatic event and its orphaned action.
UPDATE `gameobject_template` SET `data2` = 0 WHERE @arlokk_ok AND `entry` = 180526 AND `data2` = 9066;
DELETE FROM `dbscripts_on_event` WHERE @arlokk_ok AND `id` = 9066;

UNLOCK TABLES;
DROP TEMPORARY TABLE `arlokk_guard`, `arlokk_expected_spells`;

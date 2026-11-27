-- Apply with the matching CMaNGOS scripts for map 409.
SET NAMES utf8mb4;

UPDATE `creature_template`
SET `ScriptName` = 'npc_molten_core_firelord'
WHERE `Entry` = 11668;

UPDATE `creature_template`
SET `ScriptName` = 'npc_molten_core_lava_spawn'
WHERE `Entry` = 12265;

DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 12265 AND `id` IN (1226502, 1226503);
INSERT IGNORE INTO `spell_scripts` (`Id`, `ScriptName`) VALUES
    (19392, 'spell_molten_core_summon_lava_spawn');

INSERT INTO `scripted_areatrigger` (`entry`, `ScriptName`) VALUES
    (3528, 'at_molten_core_window'),
    (3529, 'at_molten_core_window')
ON DUPLICATE KEY UPDATE `ScriptName` = VALUES(`ScriptName`);

-- Check attunement on the two shortcuts. Worldport acknowledgement can fall
-- back to any entrance for the map, including when entering by the bridge.
UPDATE `areatrigger_teleport`
SET `required_quest_done` = 0, `condition_id` = 44
WHERE `id` IN (3528, 3529) AND `target_map` = 409
    AND `required_quest_done` = 7848 AND `condition_id` = 0;

UPDATE `areatrigger_teleport` AS lava
JOIN `areatrigger_teleport` AS window_entrance ON window_entrance.`id` = 3528
SET lava.`status_failed_text` = window_entrance.`status_failed_text`
WHERE lava.`id` = 3529 AND lava.`target_map` = 409;

INSERT INTO `locales_areatrigger_teleport` (`Entry`, `Text_loc4`) VALUES
    (3528, '你必须完成熔火之心的开门任务并加入团队才能进入。'),
    (3529, '你必须完成熔火之心的开门任务并加入团队才能进入。')
ON DUPLICATE KEY UPDATE `Text_loc4` = VALUES(`Text_loc4`);

-- Reuse the minimum-standing condition when present. The unique key on
-- condition values prevents storing the same check under a second ID.
INSERT IGNORE INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `comments`) VALUES
    (60569, 5, 749, 5, 'Molten Core - Requires Honored with the Hydraxian Waterlords');

SET @c60wow_aqual_standing = (
    SELECT MIN(`condition_entry`) FROM `conditions`
    WHERE `condition_entry` < 60570 AND `type` = 5 AND `value1` = 749 AND `value2` = 5
        AND `value3` = 0 AND `value4` = 0 AND `flags` = 0
);

-- AND nodes must reference lower IDs and gossip reads a 16-bit condition ID.
-- Keep both private nodes above their children and within the gossip ID range.
UPDATE `conditions`
SET `condition_entry` = 60570, `value2` = @c60wow_aqual_standing,
    `comments` = REPLACE(`comments`, 'Maximum Rank Honored', 'Minimum Rank Honored')
WHERE `condition_entry` = 70 AND `type` = -1 AND `value1` = 68
    AND @c60wow_aqual_standing IS NOT NULL;
UPDATE `conditions`
SET `condition_entry` = 60573, `value1` = 60570,
    `comments` = REPLACE(`comments`, 'Maximum Rank Honored', 'Minimum Rank Honored')
WHERE `condition_entry` = 73 AND `type` = -1 AND `value1` = 70 AND `value2` = 72
    AND @c60wow_aqual_standing IS NOT NULL;

UPDATE `gossip_menu_option`
SET `condition_id` = 60573
WHERE `menu_id` = 5065 AND `id` = 0 AND `condition_id` = 73
    AND @c60wow_aqual_standing IS NOT NULL;

UPDATE `gossip_menu_option`
SET `option_text` = 'I require a vial of Aqual Quintessence, Hydraxis, to extinguish a rune of the Firelords.'
WHERE `menu_id` = 5065 AND `id` = 0;

INSERT INTO `locales_gossip_menu_option` (`menu_id`, `id`, `option_text_loc4`) VALUES
    (5065, 0, '海达克西斯公爵，我需要一瓶水之精萃来熄灭火焰之王的符文。')
ON DUPLICATE KEY UPDATE `option_text_loc4` = VALUES(`option_text_loc4`);

-- GUID 4090039 already contains the matching reachable deposit.
DELETE FROM `pool_gameobject` WHERE `guid` = 4090020 AND `pool_entry` = 47138;
DELETE FROM `gameobject`
WHERE `guid` = 4090020 AND `id` = 165658 AND `map` = 409 AND `position_x` BETWEEN 2550.8 AND 2551;

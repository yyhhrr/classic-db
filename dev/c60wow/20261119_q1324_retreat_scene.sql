-- Limit the quest's respawn link to the same two static camp sentries used by the AI.
DELETE FROM `creature_linking_template` WHERE `entry` = 5184 AND `map` = 1 AND `master_entry` = 4966;
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES
(31271, 31274, 128),
(31268, 31274, 128)
ON DUPLICATE KEY UPDATE `master_guid` = VALUES(`master_guid`), `flag` = VALUES(`flag`);

-- Temporary escape paths selected by the quest; ordinary movement continues to use path 0.
DELETE FROM `creature_movement_template` WHERE `Entry` = 5184 AND `PathId` IN (1, 2);
INSERT INTO `creature_movement_template`
    (`Entry`, `PathId`, `Point`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `WaitTime`, `ScriptId`, `Comment`)
VALUES
(5184, 1, 1, -2906.15, -3345.12, 31.3324, 100, 0, 0, 'q1324: camp sentry 31271 escapes'),
(5184, 1, 2, -2910.64, -3353.77, 30.4347, 100, 0, 1, 'q1324: camp sentry 31271 leaves'),
(5184, 2, 1, -2897.26, -3330.35, 33.442, 100, 0, 0, 'q1324: camp sentry 31268 escapes'),
(5184, 2, 2, -2908.55, -3336.71, 32.0493, 100, 0, 0, 'q1324: camp sentry 31268 escapes'),
(5184, 2, 3, -2914.51, -3346.08, 30.843, 100, 0, 1, 'q1324: camp sentry 31268 leaves');

UPDATE `broadcast_text_locale`
SET `Text_lang` = '是普罗德摩尔女士！快跑！'
WHERE `Id` = 7325 AND `Locale` = 'zhCN';
-- The relay starts when the party appears, independently of Tervosh's movement to the scene.
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 496701 AND (`delay` IN (113000, 119000, 121000, 124000));
DELETE FROM `dbscripts_on_relay` WHERE `id` = 496701;
INSERT INTO `dbscripts_on_relay` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `datafloat`, `x`, `y`, `z`, `o`, `speed`, `condition_id`, `comments`)
VALUES
(496701, 79000, 0, 0, 0, 0, 0, 0, 0, 0, 1772, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Tervosh - Say 4'),
(496701, 85000, 0, 1, 3, 0, 0, 4968, 50, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaina Proudmore - Emote Wave'),
(496701, 87000, 0, 15, 7078, 0, 0, 4968, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaina Proudmore - Cast Simple Teleport Group'),
(496701, 90000, 0, 18, 0, 0, 0, 4968, 50, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Tervosh - Despawn Jaina Proudmoore'),
(496701, 90000, 1, 18, 0, 0, 0, 4965, 50, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Tervosh - Despawn Pained'),
(496701, 90000, 2, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Tervosh - Despawn Self');

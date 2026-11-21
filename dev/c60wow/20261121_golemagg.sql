-- Install the Golemagg encounter group and Attract Rager binding.
START TRANSACTION;

INSERT INTO `spawn_group`
    (`Id`, `Name`, `Type`, `MaxCount`, `WorldState`, `WorldStateExpression`, `Flags`, `StringId`, `RespawnOverrideMin`, `RespawnOverrideMax`)
VALUES
    (4090004, 'The Molten Core - Golemagg the Incinerator', 0, 0, 0, 0, 3, 0, NULL, NULL)
ON DUPLICATE KEY UPDATE `Id` = VALUES(`Id`);

INSERT INTO `spawn_group_spawn` (`Id`, `Guid`, `SlotId`, `Chance`) VALUES
    (4090004, 4090222, 0, 0),
    (4090004, 4090204, 1, 0),
    (4090004, 4090205, 2, 0)
ON DUPLICATE KEY UPDATE `SlotId` = VALUES(`SlotId`);

INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 20544, 'spell_golemagg_attract_rager'
WHERE NOT EXISTS (
    SELECT 1 FROM `spell_scripts` WHERE `Id` = 20544 AND `ScriptName` = 'spell_golemagg_attract_rager'
);

COMMIT;

-- The legacy link is MyISAM. Remove it after the new group has been installed.
DELETE FROM `creature_linking_template`
WHERE `entry` = 11672 AND `map` = 409 AND `master_entry` = 11988
  AND `flag` = 1031 AND `search_range` = 0;

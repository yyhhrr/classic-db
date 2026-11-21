-- Run with the world server stopped. Both spawn-group tables use InnoDB.
START TRANSACTION;

INSERT INTO `spawn_group`
    (`Id`, `Name`, `Type`, `MaxCount`, `WorldState`, `WorldStateExpression`, `Flags`, `StringId`, `RespawnOverrideMin`, `RespawnOverrideMax`)
VALUES
    (4090002, 'The Molten Core - Gehennas', 0, 0, 0, 0, 3, 0, NULL, NULL)
ON DUPLICATE KEY UPDATE `Id` = VALUES(`Id`);

INSERT INTO `spawn_group_spawn` (`Id`, `Guid`, `SlotId`, `Chance`) VALUES
    (4090002, 4090269, 0, 0),
    (4090002, 4090023, 1, 0),
    (4090002, 4090024, 2, 0)
ON DUPLICATE KEY UPDATE `SlotId` = VALUES(`SlotId`);

COMMIT;

-- The legacy link is MyISAM. Remove it after the full replacement is committed.
DELETE FROM `creature_linking_template`
WHERE `entry` = 11661 AND `map` = 409 AND `master_entry` = 12259
  AND `flag` = 1031 AND `search_range` = 0;

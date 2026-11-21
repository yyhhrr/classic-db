-- Replace the legacy link with the Sulfuron encounter group.
START TRANSACTION;

INSERT INTO `spawn_group`
    (`Id`, `Name`, `Type`, `MaxCount`, `WorldState`, `WorldStateExpression`, `Flags`, `StringId`, `RespawnOverrideMin`, `RespawnOverrideMax`)
VALUES
    (4090003, 'The Molten Core - Sulfuron Harbinger', 0, 0, 0, 0, 3, 0, NULL, NULL)
ON DUPLICATE KEY UPDATE `Id` = VALUES(`Id`);

INSERT INTO `spawn_group_spawn` (`Id`, `Guid`, `SlotId`, `Chance`) VALUES
    (4090003, 4090239, 0, 0),
    (4090003, 4090025, 1, 0),
    (4090003, 4090026, 2, 0),
    (4090003, 4090027, 3, 0),
    (4090003, 4090028, 4, 0)
ON DUPLICATE KEY UPDATE `SlotId` = VALUES(`SlotId`);

COMMIT;

-- The legacy link is MyISAM. Remove it after the replacement is committed.
DELETE FROM `creature_linking_template`
WHERE `entry` = 11662 AND `map` = 409 AND `master_entry` = 12098
  AND `flag` = 1031 AND `search_range` = 0;

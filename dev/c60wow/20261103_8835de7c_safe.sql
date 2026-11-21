-- Scoped changes rebased onto the current Classic-DB content.
SET NAMES utf8;

INSERT INTO `spawn_group` (`Id`, `Name`, `Type`, `MaxCount`, `WorldState`, `WorldStateExpression`, `Flags`, `StringId`, `RespawnOverrideMin`, `RespawnOverrideMax`) SELECT '8000100', 'Stonetalon Mountains - Gerenzo Wrenchwhistle (4202)', '0', '1', '0', '0', '0', '0', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `spawn_group` WHERE `Id` <=> '8000100');
INSERT INTO `spawn_group_spawn` (`Id`, `Guid`, `SlotId`, `Chance`) SELECT '8000100', '191723', '-1', '0' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `spawn_group_spawn` WHERE `Id` <=> '8000100' AND `Guid` <=> '191723');
INSERT INTO `spawn_group_spawn` (`Id`, `Guid`, `SlotId`, `Chance`) SELECT '8000100', '191724', '-1', '0' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `spawn_group_spawn` WHERE `Id` <=> '8000100' AND `Guid` <=> '191724');
INSERT INTO `spawn_group_spawn` (`Id`, `Guid`, `SlotId`, `Chance`) SELECT '8000100', '29254', '-1', '0' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `spawn_group_spawn` WHERE `Id` <=> '8000100' AND `Guid` <=> '29254');

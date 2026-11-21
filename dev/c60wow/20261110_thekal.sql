CREATE TEMPORARY TABLE `thekal_expected_spell_rows` (`Present` TINYINT NOT NULL PRIMARY KEY) ENGINE=MEMORY;
INSERT INTO `thekal_expected_spell_rows` VALUES (1);

START TRANSACTION;

SELECT `Id`, `Position`
FROM `creature_spell_list`
WHERE (`Id`, `Position`) IN ((1134801, 1), (1450902, 0))
FOR UPDATE;

SELECT COUNT(*) = 2 INTO @thekal_spell_rows_ok
FROM `creature_spell_list`
WHERE (`Id` = 1134801 AND `Position` = 1 AND `SpellId` = 12540 AND
       ((`TargetId` = 0 AND BINARY `Comments` = 'Zealot Zath - Gouge on None') OR
        (`TargetId` = 1 AND BINARY `Comments` = 'Zealot Zath - Gouge on Current')))
   OR (`Id` = 1450902 AND `Position` = 0 AND `TargetId` = 100 AND `SpellId` IN (24408, 24193));

-- A duplicate key rejects an unexpected baseline on MySQL versions without SIGNAL.
INSERT INTO `thekal_expected_spell_rows` SELECT 1 WHERE NOT @thekal_spell_rows_ok;

UPDATE `creature_spell_list`
SET `TargetId` = 1, `Comments` = 'Zealot Zath - Gouge on Current'
WHERE @thekal_spell_rows_ok AND `Id` = 1134801 AND `Position` = 1 AND `SpellId` = 12540;

UPDATE `creature_spell_list`
SET `SpellId` = 24193
WHERE @thekal_spell_rows_ok AND `Id` = 1450902 AND `Position` = 0 AND `SpellId` = 24408;

COMMIT;
DROP TEMPORARY TABLE `thekal_expected_spell_rows`;

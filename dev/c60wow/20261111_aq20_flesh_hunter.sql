-- Restore verified AQ20 world-data changes from the archived deployment.
SET NAMES utf8;

INSERT INTO `spell_scripts` (`Id`, `ScriptName`) SELECT '25371', 'spell_aq20_flesh_hunter_consume' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `spell_scripts` WHERE `Id` <=> '25371');
UPDATE `creature_template` SET `ScriptName` = 'mob_aq20_flesh_hunter' WHERE `Entry` <=> '15335' AND `ScriptName` <=> '';

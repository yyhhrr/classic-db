-- High Priestess Mar'li and her spawn.
SET NAMES utf8;

UPDATE `creature_spell_list` SET `InitialMin`=30000, `InitialMax`=30000, `RepeatMin`=20000, `RepeatMax`=20000 WHERE `Id`=1451001 AND `Position`=2;
UPDATE `creature_spell_list` SET `TargetId`=1, `Comments`=CONVERT(UNHEX('4869676820507269657374657373204d6172276c692050686173652032202d20436f72726f7369766520506f69736f6e206f6e2043757272656e74') USING utf8) WHERE `Id`=1451002 AND `Position`=1;
DELETE FROM `dbscripts_on_go_template_use` WHERE `id`=179985 AND `delay`=1000 AND `priority`=0 AND `command`=10 AND `datalong`=15041;
UPDATE `creature_template_addon` SET `auras`=NULL WHERE `entry`=15041;
UPDATE `creature_template` SET `ScriptName`=CONVERT(UNHEX('6e70635f737061776e5f6f665f6d61726c69') USING utf8) WHERE `entry`=15041;

INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24082, 'spell_marli_hatch_eggs' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `spell_scripts` WHERE `Id` = 24082 AND `ScriptName` = 'spell_marli_hatch_eggs');
INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24083, 'spell_marli_hatch_eggs' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `spell_scripts` WHERE `Id` = 24083 AND `ScriptName` = 'spell_marli_hatch_eggs');

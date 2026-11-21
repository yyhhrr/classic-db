-- The matching CMaNGOS instance handles lure validation and the actual summon.
INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 24325, 'spell_gahzranka_lure' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `spell_scripts` WHERE `Id` = 24325 AND `ScriptName` = 'spell_gahzranka_lure');
DELETE FROM `dbscripts_on_event`
WHERE `id` = 9104 AND `delay` = 2000
  AND ((`priority` = 1 AND `command` = 31 AND `datalong` = 15140)
    OR (`priority` = 2 AND `command` = 10 AND `datalong` = 15114)
    OR (`priority` = 3 AND `command` = 18 AND `buddy_entry` = 15140));

-- Keep the EventAI timer and move threat reset to the successful geyser hit.
UPDATE `creature_template` SET `ScriptName` = 'boss_gahzranka'
WHERE `Entry` = 15114 AND `AIName` = 'EventAI' AND `ScriptName` IN ('', 'boss_gahzranka');
INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 22422, 'spell_gahzranka_geyser' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `spell_scripts` WHERE `Id` = 22422 AND `ScriptName` = 'spell_gahzranka_geyser');
UPDATE `creature_ai_scripts`
SET `action2_type` = 0, `action2_param1` = 0, `comment` = 'Gahz''ranka - Cast Massive Geyser'
WHERE `id` = 1511403 AND `creature_id` = 15114 AND `action1_type` = 11 AND `action1_param1` = 22421
  AND `action2_type` = 14 AND `action2_param1` = -100;

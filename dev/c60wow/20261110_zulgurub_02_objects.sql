-- Allow all 17 distinct spawn slots. Each slot still rolls one pile variant.
UPDATE `spawn_group` SET `MaxCount` = 17 WHERE `Id` = 3091001 AND `Type` = 1;

-- Scripted trap owns the summon lifecycle and preserves its passive, rooted state.
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_jinxed_voodoo_pile'
WHERE `Entry` = 15047 AND `ScriptName` IN ('', 'npc_jinxed_voodoo_pile');

DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 15047 AND `id` BETWEEN 1504701 AND 1504703;

-- Keep the Berserker's EventAI, and reset threat after either successful cast.
UPDATE `creature_template` SET `ScriptName` = 'npc_gurubashi_berserker'
WHERE `Entry` = 11352 AND `AIName` = 'EventAI'
  AND `ScriptName` IN ('', 'npc_gurubashi_berserker');

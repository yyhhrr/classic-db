-- Retain COMBAT_ACTION (0x400) so action 2 runs only if the cast succeeds.
UPDATE `creature_ai_scripts`
SET `action2_type` = 14, `action2_param1` = -100
WHERE `creature_id` = 11352 AND `event_type` = 0 AND (`event_flags` & 1024) <> 0
  AND `action1_type` = 11
  AND ((`id` = 1135201 AND `action1_param1` = 16508)
    OR (`id` = 1135202 AND `action1_param1` = 11130))
  AND `action2_param2` = 0 AND `action2_param3` = 0
  AND ((`action2_type` = 0 AND `action2_param1` = 0)
    OR (`action2_type` = 14 AND `action2_param1` = -100));

UPDATE `creature_template`
SET `ScriptName` = ''
WHERE `Entry` = 11352 AND `AIName` = 'EventAI' AND `ScriptName` = 'npc_gurubashi_berserker';

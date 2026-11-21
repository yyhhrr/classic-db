-- Gurubashi Champion: Strike and Shield Slam use the current hostile target.
UPDATE `creature_ai_scripts`
SET `action1_param2` = 1
WHERE `creature_id` = 11356 AND `action1_type` = 11
  AND ((`id` = 1135602 AND `action1_param1` = 22591)
    OR (`id` = 1135603 AND `action1_param1` = 15655));

-- Gurubashi Blood Drinker: the encounter AI fills TARGET_T_EVENT_SPECIFIC for
-- 24435. Keep the existing health threshold and timers.
UPDATE `creature_template`
SET `ScriptName` = 'npc_gurubashi_blood_drinker'
WHERE `Entry` = 11353 AND `AIName` = 'EventAI'
  AND `ScriptName` IN ('', 'npc_gurubashi_blood_drinker');

UPDATE `creature_ai_scripts`
SET `action1_param2` = 12,
    `comment` = 'Gurubashi Blood Drinker - Cast Drain Life on Nearest Friendly at 30% Health'
WHERE `id` = 1135302 AND `creature_id` = 11353
  AND `action1_type` = 11 AND `action1_param1` = 24435;

-- Hakkari Blood Priest: SpellList 1134001 owns the combat spells. Keep aggro text.
DELETE FROM `creature_ai_scripts`
WHERE `creature_id` = 11340 AND `id` BETWEEN 1134002 AND 1134006;

-- Atal'ai Mistress: Pummel the casting victim, then wait 5-20 seconds.
UPDATE `creature_ai_scripts`
SET `event_type` = 13, `event_param1` = 5000, `event_param2` = 20000,
    `event_param3` = 0, `event_param4` = 0
WHERE `id` = 1488202 AND `creature_id` = 14882
  AND `action1_type` = 11 AND `action1_param1` = 15615;

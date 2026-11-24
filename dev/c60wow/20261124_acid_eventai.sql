-- Apply after ACID from d1747143. The upstream data already includes the Duke
-- of Fathoms cast flag, Geolord death event, Sergra's shout and the Naxxramas
-- combat timers. Sergra's shout requires the matching CMaNGOS targeting fix.

-- Keep Twilight Avenger's own low-health Vengeance alongside the death event.
INSERT INTO `creature_ai_scripts`
    (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`,
     `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`,
     `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
    (1188003, 11880, 2, 0, 30, 1024, 30, 0, 0, 0, 0, 0, 11, 8602, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Avenger - Cast Vengeance at 30% HP')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`);

-- The rider templates already supply these auras on spawn. Keep the EventAI
-- fallback if a database lacks the corresponding template auras.
DELETE ai
FROM `creature_ai_scripts` AS ai
JOIN `creature_template_addon` AS addon ON addon.`entry` = ai.`creature_id`
WHERE ai.`event_type` = 0
  AND ai.`action1_type` = 11
  AND ai.`action1_param3` = 34
  AND FIND_IN_SET('27987', REPLACE(TRIM(addon.`auras`), ' ', ',')) > 0
  AND (
      (ai.`id` = 1612604 AND ai.`creature_id` = 16126 AND ai.`action1_param1` = 27987 AND ai.`action2_type` = 0)
      OR
      (ai.`id` = 1615004 AND ai.`creature_id` = 16150 AND ai.`action1_param1` = 10848
       AND ai.`action2_type` = 11 AND ai.`action2_param1` = 27987 AND ai.`action2_param3` = 34
       AND FIND_IN_SET('10848', REPLACE(TRIM(addon.`auras`), ' ', ',')) > 0)
  );

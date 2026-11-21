-- Apply to the world database. Re-running either update is safe.

-- EffectBasePoints1 excludes the base die. 59 + 1 allows targets through level 60.
-- Disable per-level scaling for this effect so the cap is independent of the caster.
UPDATE `spell_template`
SET `EffectBasePoints1` = 59, `EffectRealPointsPerLevel1` = 0
WHERE `Id` = 20604 AND `Effect1` = 6 AND `EffectApplyAuraName1` = 6
  AND `EffectBaseDice1` = 1 AND `EffectDieSides1` = 1
  AND `EffectBasePoints1` = 24 AND `EffectRealPointsPerLevel1` = 1;

-- Hate to 50% needs an explicit enemy unit. Use the protector's current victim.
UPDATE `creature_ai_scripts`
SET `action1_param2` = 1
WHERE `id` = 1211903 AND `creature_id` = 12119 AND `action1_type` = 11
  AND `action1_param1` = 19707 AND `action1_param2` = 15 AND `action1_param3` = 0;

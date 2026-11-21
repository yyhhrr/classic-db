-- CMaNGOS Classic 8ec338a1704e7dcb1c0213eb7ed58f9231ade40f.
-- Preserve all 206 custom buff scripts; add SCRIPT_EFFECT (77) in unused third slots.
-- Copy the aura's target (self for elixirs, friendly target for scrolls).
-- No aura values, durations, existing effects or conditions are changed.
SET NAMES utf8;
UPDATE spell_template SET Effect3=77,EffectImplicitTargetA3=EffectImplicitTargetA1 WHERE Id IN(673,2367,2374,3160,3164,3219,3220,3222,3223,8091,8094,8095,8099,8100,8101,8112,8113,8114,8115,8116,8117,8118,8119,8120,11328,11334,11348,11349,11405,12174,12175,12177,12178,12179,17538,24361) AND Effect3=0 AND EffectImplicitTargetA3=0;
SELECT ROW_COUNT();

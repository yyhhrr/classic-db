-- Gate of Shazzrah: choose one living player on Shazzrah's threat list.
INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 23138, 'spell_shazzrah_gate'
WHERE NOT EXISTS (
    SELECT 1 FROM `spell_scripts` WHERE `Id` = 23138 AND `ScriptName` = 'spell_shazzrah_gate'
);

-- Counterspell: use the native frontal cone and retain its existing radius and school lockout.
UPDATE `spell_template`
SET `EffectImplicitTargetA1` = 24, `EffectImplicitTargetB1` = 0
WHERE `Id` = 19715;

START TRANSACTION;

-- Boss AI now casts the shout only after the ordinary charge arrives.
DELETE FROM `creature_spell_list`
WHERE `Id` = 1138201 AND `Position` = 4 AND `SpellId` = 19134;

-- Keep the gaze active until expiration if the watched player uses stealth.
UPDATE `spell_template`
SET `AuraInterruptFlags` = `AuraInterruptFlags` & ~0x00100000
WHERE `Id` = 24314;

-- Leave the charge effect intact and let the arrival handler cast Guillotine.
INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
VALUES (24315, 'spell_mandokir_gaze_charge');

COMMIT;

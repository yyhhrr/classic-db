-- Install with the world server stopped alongside the Majordomo encounter scripts.
INSERT IGNORE INTO `spell_scripts` (`Id`, `ScriptName`) VALUES
    (20619, 'spell_majordomo_encounter_adds'),
    (21075, 'spell_majordomo_encounter_adds'),
    (21086, 'spell_majordomo_encounter_adds'),
    (21087, 'spell_majordomo_encounter_adds'),
    (21090, 'spell_majordomo_encounter_adds'),
    (21094, 'spell_majordomo_encounter_adds');

DELETE FROM `creature_linking_template`
WHERE `map` = 409 AND `master_entry` = 12018 AND `entry` IN (11663, 11664);

START TRANSACTION;

INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT 20475, 'spell_baron_geddon_living_bomb'
WHERE NOT EXISTS (
    SELECT 1 FROM `spell_scripts`
    WHERE `Id` = 20475 AND BINARY `ScriptName` = 'spell_baron_geddon_living_bomb'
);

INSERT INTO `spell_area` (`spell`, `area`)
SELECT 20475, 2717
WHERE NOT EXISTS (
    SELECT 1 FROM `spell_area`
    WHERE `spell` = 20475 AND `area` = 2717 AND `quest_start` = 0
      AND `quest_start_active` = 0 AND `quest_end` = 0 AND `condition_id` = 0
      AND `aura_spell` = 0 AND `racemask` = 0 AND `gender` = 2 AND `autocast` = 0
);

COMMIT;

-- SPELL_ATTR_EX3_ONLY_ON_PLAYER
UPDATE `spell_template` SET `AttributesEx3` = `AttributesEx3` | 256 WHERE `Id` = 19659;

-- Run with the world server stopped. The spell target and creature link tables use MyISAM.
START TRANSACTION;

INSERT INTO `spell_scripts` (`Id`, `ScriptName`)
SELECT `scripts`.`Id`, `scripts`.`ScriptName`
FROM (
    SELECT 20482 AS `Id`, 'spell_garr_eruption_trigger' AS `ScriptName`
    UNION ALL
    SELECT 23487, 'spell_garr_separation_anxiety'
) AS `scripts`
WHERE NOT EXISTS (
    SELECT 1 FROM `spell_scripts` AS `existing`
    WHERE `existing`.`Id` = `scripts`.`Id`
      AND BINARY `existing`.`ScriptName` = BINARY `scripts`.`ScriptName`
);

-- Limit Separation Anxiety's periodic aura to Firesworn.
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`)
SELECT 23487, 1, 12099, 0
WHERE NOT EXISTS (
    SELECT 1 FROM `spell_script_target`
    WHERE `entry` = 23487 AND `type` = 1 AND `targetEntry` = 12099 AND `inverseEffectMask` = 0
);

COMMIT;

-- Group 4090001 already provides the Firesworn formation, aggro, and respawn.
DELETE FROM `creature_linking_template`
WHERE `entry` = 12099 AND `map` = 409 AND `master_entry` = 12057
  AND `flag` = 1543 AND `search_range` = 0;

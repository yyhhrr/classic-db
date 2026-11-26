-- The UBRS portal is the walk-in entrance. Orb of Command keeps its quest condition.
UPDATE areatrigger_teleport
SET required_quest_done = 0
WHERE id = 3726 AND target_map = 469 AND required_quest_done = 7761;

-- The instance owns the lever, cage door and Chromaggus's release movement.
UPDATE gameobject_template SET ScriptName = 'go_chromaggus_lever' WHERE entry = 179148 AND type = 0;
DELETE FROM dbscripts_on_go_template_use
WHERE id = 179148 AND ((command = 11 AND buddy_entry = 179116) OR (command IN (3, 25) AND buddy_entry = 14020));

-- Fire, Nature, Frost and Arcane immunity for red, green, blue and bronze whelps.
UPDATE creature_template
SET SchoolImmuneMask = SchoolImmuneMask | CASE entry
    WHEN 14022 THEN 4
    WHEN 14023 THEN 8
    WHEN 14024 THEN 16
    WHEN 14025 THEN 64
END
WHERE entry IN (14022, 14023, 14024, 14025);

-- Link Krixix to the leader of his three Wyrmguards in both aggro directions.
INSERT INTO creature_linking (guid, master_guid, flag)
SELECT krixix.guid, wyrmguard.guid, 3
FROM creature AS krixix
JOIN creature AS wyrmguard ON wyrmguard.guid = 4690039 AND wyrmguard.id = 12460 AND wyrmguard.map = krixix.map
WHERE krixix.guid = 4690322 AND krixix.id = 14401 AND krixix.map = 469
ON DUPLICATE KEY UPDATE master_guid = VALUES(master_guid), flag = VALUES(flag);

-- The instance rolls the shield and brood power for each living Wyrmguard or Overseer.
UPDATE creature_template_addon
SET auras = NULLIF(TRIM(REPLACE(REPLACE(CONCAT(' ', auras, ' '), ' 22276 ', ' '), ' 22282 ', ' ')), '')
WHERE entry IN (12460, 12461);

-- VMaNGOS Wyrmguard Cleave and the Hatcher's combat-only Growing Flames aura.
DELETE FROM creature_ai_scripts
WHERE (creature_id = 12460 AND id = 1246002) OR (creature_id = 12468 AND id IN (1246802, 1246803));
INSERT INTO creature_ai_scripts
    (id, creature_id, event_type, event_flags, event_param1, event_param2, event_param3, event_param4,
     action1_type, action1_param1, action1_param2, action1_param3, comment)
VALUES
    (1246002, 12460, 0, 1025, 5000, 9000, 5000, 9000, 11, 15284, 1, 0, 'Death Talon Wyrmguard - Cast Cleave'),
    (1246802, 12468, 4, 0, 0, 0, 0, 0, 11, 22441, 0, 2, 'Death Talon Hatcher - Apply Growing Flames on Aggro'),
    (1246803, 12468, 7, 0, 0, 0, 0, 0, 28, 0, 22441, 0, 'Death Talon Hatcher - Remove Growing Flames on Evade');

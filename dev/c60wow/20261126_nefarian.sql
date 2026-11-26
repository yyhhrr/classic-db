-- These four hostile summons are creatures. The separate totem-slot marker 14667 is a Totem.
UPDATE creature_template
SET AIName = '', ScriptName = 'npc_nefarian_corrupted_totem'
WHERE Entry IN (14662, 14663, 14664, 14666);

INSERT INTO spell_scripts (Id, ScriptName) VALUES
    (23343, 'spell_nefarian_tunnel_selection'),
    (23414, 'spell_nefarian_paralyze')
ON DUPLICATE KEY UPDATE ScriptName = VALUES(ScriptName);

-- The instance validates and saves the tunnel pair together.
DELETE FROM scripted_event_id
WHERE id BETWEEN 8520 AND 8529 AND ScriptName = 'event_weekly_chromatic_selection';

-- Wild Polymorph selects one player per pulse.
UPDATE spell_template SET MaxAffectedTargets = 1 WHERE Id = 23603;

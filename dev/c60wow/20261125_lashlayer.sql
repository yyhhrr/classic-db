-- Blackwing Lair: suppression devices cast their aura on the scripted pulse.
UPDATE gameobject_template SET data2 = 0 WHERE entry = 179784 AND type = 6 AND data3 = 22247;

-- Exclude stealthed units from the suppression aura.
INSERT INTO spell_scripts (Id, ScriptName) VALUES (22247, 'spell_bwl_suppression_aura')
ON DUPLICATE KEY UPDATE ScriptName = VALUES(ScriptName);

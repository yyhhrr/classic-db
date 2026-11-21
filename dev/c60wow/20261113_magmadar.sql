START TRANSACTION;

INSERT INTO spell_scripts (Id, ScriptName) VALUES
(19411, 'spell_magmadar_lava_bomb'),
(20474, 'spell_magmadar_lava_bomb');

UPDATE creature_template
SET ScriptName = 'npc_molten_core_hound'
WHERE Entry = 11671 AND AIName = 'EventAI' AND ScriptName = '';

COMMIT;

-- User-selected behavior: VMaNGOS 12709 selector and AzerothCore 7079 abilities.
INSERT INTO spell_scripts (Id,ScriptName) VALUES (12709,'spell_gnomeregan_collecting_fallout');
UPDATE creature_template SET AIName='', ScriptName='boss_viscous_fallout' WHERE Entry=7079;

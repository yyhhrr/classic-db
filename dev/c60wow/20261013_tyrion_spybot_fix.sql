-- The Attack (434): true template changes, stable spawn lookup, separate disguise path.
-- CMaNGOS command 44 = UpdateEntry (VMaNGOS command 27). Flags 16 = buddy by DB GUID.
-- Apply with the server stopped; retain the existing dialogue and waypoint timing.
UPDATE dbscripts_on_quest_start SET command=44 WHERE id=434 AND delay=9000 AND priority=2 AND command=23 AND datalong=7779;
UPDATE dbscripts_on_quest_start SET search_radius=45707,data_flags=(data_flags|16) WHERE id=434 AND buddy_entry=8856;
UPDATE creature_movement_template SET Entry=7779 WHERE Entry=8856 AND PathId=1;
UPDATE dbscripts_on_creature_movement SET command=44 WHERE id=885604 AND delay=5000 AND priority=0 AND command=23 AND datalong=8856;
-- Protect the disguised quest actor from players and NPCs, as in VMaNGOS.
UPDATE creature_template SET UnitFlags=(UnitFlags|768) WHERE Entry=7779;

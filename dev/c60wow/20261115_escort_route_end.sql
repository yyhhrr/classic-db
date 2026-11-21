-- Sentinel Aynasha / One Shot. One Kill. (5713)
-- Hold the final waypoint until the existing 20-second despawn fires.
UPDATE creature_movement_template
SET WaitTime = 20000
WHERE Entry = 11711 AND PathId = 0 AND Point = 6 AND WaitTime = 0 AND ScriptId = 0
  AND EXISTS (
    SELECT 1 FROM dbscripts_on_quest_start
    WHERE id = 5713 AND delay = 175000 AND command = 18 AND datalong = 20000
  );

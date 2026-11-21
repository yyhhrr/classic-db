-- Remove 51 idle legacy waypoints from three valid random group spawns.
-- 23120: official update 4827 changed this to a standing Dune Smasher / Raging Dune Smasher.
-- 3090175/3090562: official Zul'Gurub update uses group 3090040 and waypoint_path 3090027.
-- Preserve entry=0, all spawns and random candidates, and the active six-node formation path.
-- The reported template(0) warning comes from the legacy waypoint validation in WaypointManager.
SET NAMES utf8;
DELETE FROM creature_movement WHERE Id IN(23120,3090175,3090562);
SELECT ROW_COUNT();

-- Resolve the audited spawn-group and pool conflicts.
-- Requires the verified baseline in the companion PowerShell Apply mode.
-- Preserve every current group member and existing spawn record.
-- Restore the legacy pool 3129 mithril node under an unused GUID, without changing its chances.
SET NAMES utf8;
INSERT INTO gameobject (guid,id,map,spawnMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecsmin,spawntimesecsmax) SELECT 9000294,2040,map,spawnMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecsmin,spawntimesecsmax FROM gameobject WHERE guid=70652 AND id=1734;
SELECT ROW_COUNT();
UPDATE pool_gameobject SET guid=9000294 WHERE guid=70651 AND pool_entry=3129 AND chance=0;
SELECT ROW_COUNT();
DELETE FROM pool_gameobject WHERE guid IN (70601,70602,70604,70606,70607,70609,70626,70627,70629,70631,70632,70634,70636,70637,70639);
SELECT ROW_COUNT();
DELETE FROM pool_creature_template WHERE (id=3204 AND pool_entry=1202) OR (id=14479 AND pool_entry=25492);
SELECT ROW_COUNT();
DELETE FROM pool_pool WHERE pool_id IN (3068,3090,3091,3147,3179);
SELECT ROW_COUNT();
DELETE FROM pool_template WHERE entry IN (1202,3068,3090,3091,3147,3179,25492);
SELECT ROW_COUNT();

-- Active chest 181366 uses loot id 18036; preserve the chest and all active loot.
-- Companion Apply mode checks the complete baseline and verified rollback.
SET NAMES utf8;
DELETE FROM gameobject_loot_template WHERE entry=181366;
SELECT ROW_COUNT();

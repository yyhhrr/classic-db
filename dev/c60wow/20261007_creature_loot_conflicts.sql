-- Fix only the errors in the audited attachment; use companion Apply mode for baseline guards.
SET NAMES utf8;
-- Remove only the 70 unused creature loot templates reported in the attached log.
DELETE FROM creature_loot_template WHERE entry IN(467,888,1244,1374,1497,2214,2775,2992,3193,3338,3341,3421,3663,3994,4080,4625,4661,5389,5476,5723,5781,5899,7233,7549,7607,7849,9136,9598,10260,10262,10387,10619,11141,11347,11521,11609,11690,11748,11806,11856,11948,13118,13159,13533,13736,14122,14372,14757,14826,14874,14884,14965,14983,14986,14987,14988,15041,15068,15101,15112,15117,15146,15449,15620,16156,16157,16158,17070,17079,17080);
SELECT ROW_COUNT();
-- All 207 direct colossus entries are exact copies of the two preserved reference pools.
DELETE FROM creature_loot_template WHERE entry IN(15740,15741,15742) AND mincountOrRef>0 AND groupid BETWEEN 1 AND 7 AND ChanceOrQuestChance=0;
SELECT ROW_COUNT();
-- Current core executes the complete reference pool; call each pool once, not once per internal group.
DELETE FROM creature_loot_template WHERE entry IN(15740,15741,15742) AND item IN(2,3,4,5,7) AND mincountOrRef IN(-30101,-30102);
SELECT ROW_COUNT();
UPDATE creature_loot_template SET groupid=0 WHERE entry IN(15740,15741,15742) AND item IN(30101,30102) AND mincountOrRef=-item;
SELECT ROW_COUNT();
-- Preserve Kazzak's guaranteed two epic rolls, Eye of Shadow, gem sack and independent green/blue loot.
DELETE FROM creature_loot_template WHERE entry=12397 AND mincountOrRef>0 AND groupid IN(1,2) AND ChanceOrQuestChance=0;
SELECT ROW_COUNT();
DELETE FROM creature_loot_template WHERE entry=12397 AND item=190003 AND mincountOrRef=-34003 AND groupid=1 AND ChanceOrQuestChance=100;
SELECT ROW_COUNT();
-- Preserve AQ20 book/enchant references in group zero; remove the obsolete competing book reference.
DELETE FROM creature_loot_template WHERE entry IN(15339,15340,15341,15348,15369) AND item=190024 AND mincountOrRef=-34024 AND groupid=1 AND ChanceOrQuestChance=5;
SELECT ROW_COUNT();

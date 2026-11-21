SET NAMES utf8;

UPDATE `creature_template` SET `CreatureTypeFlags`=4096 WHERE `Entry` <=> 5644;
UPDATE `script_waypoint` SET `WaitTime`=1000 WHERE `Entry` <=> 5644 AND `PathId` <=> 0 AND `Point` <=> 19;

-- Remove the eight underwater Shipwreck Debris spawns for the TBC salvage quest.
DELETE FROM `gameobject`
WHERE `id` = 186283
  AND `map` = 1
  AND `position_z` < 0
  AND `guid` IN (11181, 14609, 14616, 40776, 40778, 40780, 40782, 40784);

SET NAMES utf8;

UPDATE `creature_template` SET ScriptName='npc_private_thorsen' WHERE Entry=738;
DELETE FROM `dbscripts_on_creature_movement` WHERE id IN (73803,73804,73805) OR (id IN (73801,73807) AND command=29);
UPDATE `creature_movement_template` SET ScriptId=0 WHERE Entry=738 AND PathId=0 AND Point IN (23,24,25);

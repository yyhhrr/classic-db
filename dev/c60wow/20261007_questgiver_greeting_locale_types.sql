-- Fix three questgiver locale records mislabeled in the startup log as questgiver_greeting.
-- Remove the all-NULL Entry=0 placeholder.
-- Preserve every locale text field and change gameobjects 142487/186420 from Type=0 to Type=1.
-- Preserve all 214 base greetings, including the existing 186420 object greeting.
-- 142487 has no base greeting in either the current DB or official ClassicDB; do not invent one.
SET NAMES utf8;
START TRANSACTION;
DELETE FROM locales_questgiver_greeting WHERE Entry=0 AND Type=0 AND Text_loc1 IS NULL AND Text_loc2 IS NULL AND Text_loc3 IS NULL AND Text_loc4 IS NULL AND Text_loc5 IS NULL AND Text_loc6 IS NULL AND Text_loc7 IS NULL AND Text_loc8 IS NULL;
SELECT ROW_COUNT();
UPDATE locales_questgiver_greeting SET Type=1 WHERE Entry IN(142487,186420) AND Type=0;
SELECT ROW_COUNT();
COMMIT;

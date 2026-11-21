-- Remove six dangling broadcast_text links from script_texts; keep every script-text row and every other field.
-- Current core already falls back to script_texts content when a referenced broadcast is missing.
-- Setting the link to zero explicitly selects the same fallback and suppresses the startup errors.
-- Affected text: Sylvanas (2), Kyle (3), Feero Ironhand escort start (1).
-- The broadcasts do not exist in the current or older DB, and no same-text alternative was found.
-- Checked matching official ScriptDevAI SQL and ObjectMgr::LoadMangosStrings/DoDisplayText source.
-- MyISAM table: use the verified scoped rollback if required.
SET NAMES utf8;
UPDATE script_texts s LEFT JOIN broadcast_text b ON b.Id=s.broadcast_text_id SET s.broadcast_text_id=0 WHERE ((s.entry=-1000196 AND s.broadcast_text_id=19263) OR (s.entry=-1000197 AND s.broadcast_text_id=19244) OR (s.entry=-1000340 AND s.broadcast_text_id=22068) OR (s.entry=-1000341 AND s.broadcast_text_id=22069) OR (s.entry=-1000342 AND s.broadcast_text_id=22070) OR (s.entry=-1000771 AND s.broadcast_text_id=21649)) AND b.Id IS NULL;
SELECT ROW_COUNT();

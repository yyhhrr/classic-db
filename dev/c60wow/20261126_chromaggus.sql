-- Bind the Chromaggus spell scripts from the matching CMaNGOS source update.
INSERT INTO spell_scripts (Id, ScriptName) VALUES
    (23173, 'spell_chromaggus_brood_affliction'),
    (23174, 'spell_chromaggus_mutation'),
    (23195, 'spell_chromaggus_breath_selection'),
    (23310, 'spell_chromaggus_time_lapse'),
    (23312, 'spell_chromaggus_time_lapse')
ON DUPLICATE KEY UPDATE ScriptName = VALUES(ScriptName);

-- The instance now selects and saves both breaths together.
DELETE FROM scripted_event_id
WHERE id BETWEEN 8446 AND 8455 AND ScriptName = 'event_weekly_chromatic_selection';

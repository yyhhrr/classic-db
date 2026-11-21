-- Preserve Ironeye's 45% unique blade and 55% random green reference; clear unreachable duplicates.
-- Add four missing reference descriptions without changing their loot rows.
-- Companion Apply mode validates the complete baseline and verified rollback.
SET NAMES utf8;
DELETE FROM reference_loot_template WHERE entry=65282 AND groupid=1 AND ChanceOrQuestChance=0 AND mincountOrRef=1;
SELECT ROW_COUNT();
INSERT INTO reference_loot_template_names (entry,name) VALUES
(16882,'ITEM LOOT - Battered Junkbox (16882) - Rings, Necklaces and Patterns'),
(30101,'AQ War Effort - Colossus of Zora/Regal/Ashi - Rare Items'),
(30102,'AQ War Effort - Colossus of Zora/Regal/Ashi - Epic Items'),
(35032,'World Boss Loot - Lord Kazzak / Highlord Kruul - Epic Items');
SELECT ROW_COUNT();

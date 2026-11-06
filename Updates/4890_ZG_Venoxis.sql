-- Match AzerothCore's Phase 1 Holy Nova cadence.
UPDATE `creature_spell_list`
SET `InitialMin` = 5000, `InitialMax` = 15000, `RepeatMin` = 10000, `RepeatMax` = 24000
WHERE `Id` = 1450701 AND `Position` = 3 AND `SpellId` = 23858;

-- Cast the summon in Phase 3. The boss AI gives the serpent its poison proc.
UPDATE `creature_spell_list`
SET `SpellId` = 23866, `TargetId` = 0,
    `Comments` = 'High Priest Venoxis Phase 3 - Summon Parasitic Serpent on None'
WHERE `Id` = 1450703 AND `Position` = 2 AND `SpellId` = 23867;

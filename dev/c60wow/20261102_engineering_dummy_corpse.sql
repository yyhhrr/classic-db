-- Engineering dummy corpse time, in seconds; live template cache requires a world-server restart.
UPDATE creature_template SET CorpseDecay=300 WHERE Entry IN (2673,2674,12426) AND CorpseDecay=10;

SET NAMES utf8;

-- Classic-DB 4858 uses the same list for Kurzen Medicine Man at different positions.
DELETE FROM `creature_spell_list` WHERE `Id` = 94001 AND `SpellId` IN (6064, 6077);

REPLACE INTO `unit_condition` (`Id`,`Flags`,`Variable_0`,`Variable_1`,`Variable_2`,`Variable_3`,`Variable_4`,`Variable_5`,`Variable_6`,`Variable_7`,`Op_0`,`Op_1`,`Op_2`,`Op_3`,`Op_4`,`Op_5`,`Op_6`,`Op_7`,`Value_0`,`Value_1`,`Value_2`,`Value_3`,`Value_4`,`Value_5`,`Value_6`,`Value_7`) VALUES (94001,0,12,31,17,17,17,17,17,17,3,1,2,2,2,2,2,2,80,1,6077,6078,10927,10928,10929,25315);
REPLACE INTO `creature_spell_targeting` (`Id`,`Type`,`Param1`,`Param2`,`Param3`,`UnitCondition`,`Comments`) VALUES (94001,2,20,1,1,94001,CONVERT(UNHEX('4b75727a656e204d65646963696e65204d616e202d20496e6a7572656420636f6d62617420667269656e646c7920776974686f75742073616d65206f72207374726f6e6765722052656e65772028696e636c7564696e672073656c6629') USING utf8));
REPLACE INTO `creature_spell_list_entry` (`Id`,`Name`,`ChanceSupportAction`,`ChanceRangedAttack`) VALUES (94001,CONVERT(UNHEX('537472616e676c6574686f726e2056616c65202d204b75727a656e204d65646963696e65204d616e202d20436f6d626174206865616c696e67') USING utf8),100,0);
INSERT INTO `creature_spell_list` (`Id`,`Position`,`SpellId`,`Flags`,`CombatCondition`,`TargetId`,`ScriptId`,`Availability`,`Probability`,`InitialMin`,`InitialMax`,`RepeatMin`,`RepeatMax`,`Comments`) VALUES (94001,0,6064,0,-1,201,0,100,0,0,0,30000,40000,CONVERT(UNHEX('4b75727a656e204d65646963696e65204d616e202d204865616c202d204d697373696e67206d6f7265207468616e2035302520696e636c7564696e672073656c66') USING utf8));
INSERT INTO `creature_spell_list` (`Id`,`Position`,`SpellId`,`Flags`,`CombatCondition`,`TargetId`,`ScriptId`,`Availability`,`Probability`,`InitialMin`,`InitialMax`,`RepeatMin`,`RepeatMax`,`Comments`) VALUES (94001,1,6077,0,-1,94001,0,100,0,0,0,20000,30000,CONVERT(UNHEX('4b75727a656e204d65646963696e65204d616e202d2052656e6577202d204d697373696e67206d6f7265207468616e203230252077697468206e6f2073616d65206f72207374726f6e6765722052656e6577') USING utf8));
UPDATE `creature_template` SET SpellList=94001 WHERE Entry=940;
DELETE FROM `creature_ai_scripts` WHERE id IN (94003,94004) AND creature_id=940;

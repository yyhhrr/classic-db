SET NAMES utf8;

INSERT INTO `unit_condition` (`Id`,`Flags`,`Variable_0`,`Variable_1`,`Variable_2`,`Variable_3`,`Variable_4`,`Variable_5`,`Variable_6`,`Variable_7`,`Op_0`,`Op_1`,`Op_2`,`Op_3`,`Op_4`,`Op_5`,`Op_6`,`Op_7`,`Value_0`,`Value_1`,`Value_2`,`Value_3`,`Value_4`,`Value_5`,`Value_6`,`Value_7`) VALUES (639201,0,12,31,17,0,0,0,0,0,3,1,2,0,0,0,0,0,80,1,22168,0,0,0,0,0);
INSERT INTO `creature_spell_targeting` (`Id`,`Type`,`Param1`,`Param2`,`Param3`,`UnitCondition`,`Comments`) VALUES (639201,2,20,1,1,639201,CONVERT(UNHEX('476e6f6d65726567616e202d20486f6c646f7574204d65646963202d20496e6a7572656420636f6d62617420667269656e646c7920776974686f75742052656e65772032323136382028696e636c7564696e672073656c6629') USING utf8));
INSERT INTO `creature_spell_list_entry` (`Id`,`Name`,`ChanceSupportAction`,`ChanceRangedAttack`) VALUES (622101,CONVERT(UNHEX('476e6f6d65726567616e202d204164646c6564204c65706572202d20436f6d626174206865616c696e67') USING utf8),100,0);
INSERT INTO `creature_spell_list_entry` (`Id`,`Name`,`ChanceSupportAction`,`ChanceRangedAttack`) VALUES (639201,CONVERT(UNHEX('476e6f6d65726567616e202d20486f6c646f7574204d65646963202d20436f6d626174206865616c696e67') USING utf8),100,0);
INSERT INTO `creature_spell_list` (`Id`,`Position`,`SpellId`,`Flags`,`CombatCondition`,`TargetId`,`ScriptId`,`Availability`,`Probability`,`InitialMin`,`InitialMax`,`RepeatMin`,`RepeatMax`,`Comments`) VALUES (622101,0,2055,0,-1,201,0,100,0,0,0,23800,26900,CONVERT(UNHEX('4164646c6564204c65706572202d204865616c202d204d697373696e67206d6f7265207468616e2035302520696e636c7564696e672073656c66') USING utf8));
INSERT INTO `creature_spell_list` (`Id`,`Position`,`SpellId`,`Flags`,`CombatCondition`,`TargetId`,`ScriptId`,`Availability`,`Probability`,`InitialMin`,`InitialMax`,`RepeatMin`,`RepeatMax`,`Comments`) VALUES (639201,0,22167,0,-1,201,0,100,0,0,0,14000,21000,CONVERT(UNHEX('486f6c646f7574204d65646963202d204865616c202d204d697373696e67206d6f7265207468616e2035302520696e636c7564696e672073656c66') USING utf8));
INSERT INTO `creature_spell_list` (`Id`,`Position`,`SpellId`,`Flags`,`CombatCondition`,`TargetId`,`ScriptId`,`Availability`,`Probability`,`InitialMin`,`InitialMax`,`RepeatMin`,`RepeatMax`,`Comments`) VALUES (639201,1,22168,0,-1,639201,0,100,0,0,0,12000,16000,CONVERT(UNHEX('486f6c646f7574204d65646963202d2052656e6577202d204d697373696e67206d6f7265207468616e2032302520776974686f75742052656e65773232313638') USING utf8));
UPDATE `creature_template` SET SpellList=622101 WHERE Entry=6221;
UPDATE `creature_template` SET SpellList=639201 WHERE Entry=6392;
DELETE FROM `creature_ai_scripts` WHERE id=622104 AND creature_id=6221;
DELETE FROM `creature_ai_scripts` WHERE id=639203 AND creature_id=6392;
DELETE FROM `creature_ai_scripts` WHERE id=639204 AND creature_id=6392;
UPDATE `spell_template` SET EffectMultipleValue1=1 WHERE Id=10860;

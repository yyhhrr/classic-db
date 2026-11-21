-- Nat Pagle sells the Mudskunk Lure after Nat's Measuring Tape is rewarded.
UPDATE `npc_vendor` SET `condition_id` = 259
WHERE `entry` = 12919 AND `item` = 19974;

-- Each Zanza head and leg enchant quest requires the class on its voodoo doll.
UPDATE `quest_template`
SET `RequiredClasses` = CASE `entry`
    WHEN 8184 THEN 1
    WHEN 8185 THEN 2
    WHEN 8186 THEN 8
    WHEN 8187 THEN 4
    WHEN 8188 THEN 64
    WHEN 8189 THEN 128
    WHEN 8190 THEN 256
    WHEN 8191 THEN 16
    WHEN 8192 THEN 1024
END
WHERE `entry` BETWEEN 8184 AND 8192;

-- Classic one-time turn-in reputation for the Bijou.
UPDATE `quest_template` SET `RewRepValue1` = 150
WHERE `entry` = 8240 AND `RewRepFaction1` = 270;

-- Zanza's Potent Potables already consumes one Zandalar Honor Token.
UPDATE `quest_template`
SET `RequestItemsText` = REPLACE(`RequestItemsText`, 'three Zandalar Honor Tokens', 'one Zandalar Honor Token')
WHERE `entry` = 8243;
UPDATE `locales_quest`
SET `RequestItemsText_loc4` = REPLACE(`RequestItemsText_loc4`, '我需要赞达拉荣誉勋章', '我需要一枚赞达拉荣誉勋章')
WHERE `entry` = 8243;

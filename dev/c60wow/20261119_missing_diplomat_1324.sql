-- Restore Tervosh's opening line and make the scripted handover resolve before despawn.
-- 10 = TRIGGERED_INSTANT_CAST | TRIGGERED_IGNORE_HIT_CALCULATION.
UPDATE `dbscripts_on_creature_movement`
SET `datalong2` = 10
WHERE `id` = 496701 AND `delay` = 13000 AND `command` = 15
  AND `datalong` = 7079 AND `buddy_entry` = 4966 AND `datalong2` = 0;

DELETE FROM `dbscripts_on_creature_movement`
WHERE `id` = 496701 AND `delay` = 1000 AND `priority` = 1
  AND `command` = 0 AND `dataint` = 1657
  AND `comments` = 'Archmage Tervosh - Address Private Hendel';

INSERT INTO `dbscripts_on_creature_movement`
    (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`,
     `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`,
     `datafloat`, `x`, `y`, `z`, `o`, `speed`, `condition_id`, `comments`)
VALUES (496701, 1000, 1, 0, 0, 0, 0, 0, 0, 0, 1657, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        'Archmage Tervosh - Address Private Hendel');

UPDATE `broadcast_text_locale`
SET `Text_lang` = CASE `Id`
    WHEN 1657 THEN '啊，亨德尔下士。为了自己的脸面就背叛王国的人，今天总算见到一个了。'
    WHEN 1663 THEN '现在就该处理你的事了，亨德尔。回到塔里，普罗德摩尔女士会亲自跟你谈。'
    WHEN 1759 THEN '求求您……普罗德摩尔小姐。我不是有意要……'
    WHEN 1761 THEN '抱歉，让你久等了。我想请普罗德摩尔女士也到场。'
    WHEN 1772 THEN '再见。我想我们还会再谈的。'
    WHEN 1808 THEN '我们只能在这里待一会儿，随后就得回塔里。还有话想说的话，可以去塔里找我们。'
END
WHERE `Locale` = 'zhCN' AND `Id` IN (1657, 1663, 1759, 1761, 1772, 1808);

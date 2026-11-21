-- Joachim Brenlow (1311), gossip menu 700: option 1 duplicates option 0.
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 700 AND `id` = 1;
DELETE FROM `locales_gossip_menu_option` WHERE `menu_id` = 700 AND `id` = 1;

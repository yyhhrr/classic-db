-- Keep the earlier functional option; preserve all remaining IDs and child menus.
DELETE FROM gossip_menu_option WHERE (menu_id,id) IN ((435,15),(1951,12),(2121,11),(2849,12),(2849,13));
SELECT ROW_COUNT() AS deleted_option_rows;
DELETE FROM locales_gossip_menu_option WHERE (menu_id,id) IN ((435,15),(1951,12),(2121,11),(2849,12),(2849,13));
SELECT ROW_COUNT() AS deleted_locale_rows;

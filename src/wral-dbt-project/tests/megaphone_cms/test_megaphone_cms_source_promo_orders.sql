SELECT max(date(_airbyte_emitted_at)) as updated_date FROM "wral-datalake"."megaphone_cms_source_promo_orders" having current_date != max(date(_airbyte_emitted_at))
SELECT max(date(_airbyte_emitted_at)) as updated_date FROM "wral-datalake"."megaphone_cms_source_agencies" having current_date != max(date(_airbyte_emitted_at))
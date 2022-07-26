

with source_channel as (

    select * from
        {{ source('wetube', 'channel') }}
),

source_channel_subs as (

    select * from
        {{ source('wetube','channel_subs') }}

),

number_of_subs_by_channel as (

    select
        source_channel.id_channel,
        source_channel.name,
        count(source_channel_subs.id_subscriber) num_subs
    FROM source_channel_subs
    	inner join source_channel using (id_channel)
    GROUP BY 1, 2
)

select * from number_of_subs_by_channel



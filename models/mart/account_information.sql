

with source_channel as (
    select * from
        {{ source('wetube', 'channel') }}
),

source_city as (
    select * from
        {{ source('wetube','city') }}
),

source_state as (
    select * from
        {{ source('wetube','state') }}
),

source_user_address as (
    select * from
        {{ source('wetube','user_address') }}
),

source_account as (
    select * from
        {{ source('wetube','account') }}
),

account_info as (
    select
        account.id_user as id_account,
        account.first_name,
        account.last_name,
        account.email,
        city.name as city_name,
        state.name as state_name,
        channel.id_channel,
        channel.name as channel,
        channel.creation_date as channel_creation
    FROM source_account account
    	inner join source_channel channel on (channel.id_account = account.id_user)
    	inner join source_user_address user_address using (id_user)
    	inner join source_state state using (id_state)
    	inner join source_city city using (id_city)
)

select * from account_info


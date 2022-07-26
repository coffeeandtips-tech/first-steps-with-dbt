with source_video as (
    select * from
        {{ source('wetube','video') }}
),


source_video_like as (
    select * from
        {{ source('wetube','video_like') }}
),

source_account_info as (
    select * from
        {{ ref('account_information') }}
),

source_total_like_by_video as (

    select source_account_info.id_channel, source_account_info.channel,
        source_video.id_video, source_video.title, count(*) as total_likes
    FROM source_video_like
        inner join source_video using (id_video)
        inner join source_account_info using (id_channel)
    GROUP BY source_account_info.id_channel,
             source_account_info.channel,
             source_video.id_video,
             source_video.title
    ORDER BY  total_likes DESC
)

select * from source_total_like_by_video



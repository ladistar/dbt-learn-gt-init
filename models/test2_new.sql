select
 distinct status

from {{ source('stripe', 'payment') }}
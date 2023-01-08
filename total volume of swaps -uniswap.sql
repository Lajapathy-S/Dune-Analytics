--0xb4e16d0168e52d35cacd2c6185b44281ec28c9dc
with 
frequency as 
(select date_trunc('week',evt_block_time) as time,count(*)
from uniswap_v2_ethereum.Pair_evt_Swap
where contract_address = '0xb4e16d0168e52d35cacd2c6185b44281ec28c9dc'
group by 1),

volume as 
( select date_trunc('week',s.evt_block_time) as time,
case when cast (amount0Out as double) = 0 then p.token1 else p.token0 end as token_bought,
case when cast (amount0Out as double) = 0 then amount1out else amount0Out end  as token_purchase_amt

from uniswap_v2_ethereum.Pair_evt_Swap s
left join uniswap_v2_ethereum.Factory_evt_PairCreated p
on p.pair = s.contract_address
where s.contract_address = '0xb4e16d0168e52d35cacd2c6185b44281ec28c9dc'
)

select time ,sum(cast (token_purchase_amt as double) /pow(10 ,coalesce (t.decimals,18) * p.price )) as total_usd_amt
from volume v
left join tokens.erc20 t on t.contract_address = v.token_bought
left join prices.usd p on p.minute = v.time and p.blockchain = 'ethereum' and p.contract_address = v.token_bought 
group by 1

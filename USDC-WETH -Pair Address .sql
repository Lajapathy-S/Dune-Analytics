select
p.evt_block_time as time,
p.pair as pair_address,
p.token0,
t0.symbol as t0_symbol,
p.token1,
t1.symbol as t1_symbol,
t0.blockchain as t0_chain,
t1.blockchain as t1_chain
from uniswap_v2_ethereum.Factory_evt_PairCreated  p
left join tokens.erc20 t0
on t0.contract_address = p.token0
left join tokens.erc20 t1 
on t1.contract_address = p.token1
where token0 in (0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2)
and token1 in (0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2)
 and t0.blockchain = 'ethereum' and t1.blockchain = 'ethereum'
 

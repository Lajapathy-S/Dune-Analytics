with 
fund as 
(select sum(value/1e18) as eth_fund,count(distinct "from") as supporters
from ethereum."transactions"
where "to" = '\x90B3832e2F2aDe2FE382a911805B6933C056D6ed' or 
"to" = '\x3545192b340F50d77403DC0A64cf2b32F03d00A9' or 
"to" = '\x5663e3E096f1743e77B8F71b5DE0CF9Dfd058523'
limit 10),

usdprice(currentprice) as 
  (select "price" as Ethcurrentprice 
from prices.usd 
where "symbol" = 'WETH' and minute < now() - interval '1 day'
order by minute desc
limit 1
),
usdprice1(Launchprice) as
(select "price" as EthLaunchprice 
from prices.usd 
where "symbol" = 'WETH' and minute > '2022-05-01'
order by minute desc
limit 1
)


select f.eth_fund,f.supporters,u.currentprice,n.launchprice,(f.eth_fund*u.currentprice) as current_usd_value,(f.eth_fund*n.launchprice) as launch_usd_value
from fund f 
cross join usdprice u
cross join usdprice1 n 

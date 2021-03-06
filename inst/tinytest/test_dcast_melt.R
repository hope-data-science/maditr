cat("\nContext:","dcast/melt", "\n")
# examples are borrowed from 'tidyr' package
set.seed(123)
stocks = data.frame(
    time = as.Date('2009-01-01') + 0:9,
    X = rnorm(10, 0, 1),
    Y = rnorm(10, 0, 2),
    Z = rnorm(10, 0, 4)
)

res = structure(list(time = structure(c(14245, 14246, 14247, 14248,
14249, 14250, 14251, 14252, 14253, 14254, 14245, 14246, 14247,
14248, 14249, 14250, 14251, 14252, 14253, 14254, 14245, 14246,
14247, 14248, 14249, 14250, 14251, 14252, 14253, 14254), class = "Date"),
stock = structure(c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L,
3L, 3L, 3L, 3L, 3L), class = "factor", .Label = c("X", "Y",
"Z")), price = c(-0.560475646552213, -0.23017748948328, 1.55870831414912,
0.070508391424576, 0.129287735160946, 1.71506498688328, 0.460916205989202,
-1.26506123460653, -0.686852851893526, -0.445661970099958,
2.44816359487892, 0.719627654114728, 0.801542901188104, 0.221365431890239,
-1.11168226950815, 3.57382627360616, 0.995700956458479, -3.93323431325928,
1.40271180312737, -0.945582815455868, -4.27129482394738,
-0.871899658633181, -4.10401779322896, -2.91556491716456,
-2.50015707139703, -6.74677324296965, 3.3511481779781, 0.613492471346061,
-4.55254774804779, 5.01525968427971)), row.names = c(NA,
-30L), class = c("data.table", "data.frame"))

stocksm = stocks %>% melt(id.vars = "time", variable.name = "stock", value.name = "price")
expect_equal(stocksm, res)

stocksm = stocks %>% melt(id.vars = "time", variable.name = "stock",
                          measure.vars = patterns("X|Y|Z"),
                          value.name = "price")
expect_equal(stocksm, res)

stocksm_dt = as.data.table(stocks) %>% melt(id.vars = "time", variable.name = "stock",
                                            value.name = "price")
expect_equal(stocksm_dt, res)

stocksm_dt = as.data.table(stocks) %>% melt(id.vars = "time", variable.name = "stock",
                                            measure.vars = patterns("X|Y|Z"),
                                            value.name = "price")
expect_equal(stocksm_dt, res)

res2 = structure(list(time = structure(c(14245, 14246, 14247, 14248,
14249, 14250, 14251, 14252, 14253, 14254), class = "Date"), X = c(-0.560475646552213,
-0.23017748948328, 1.55870831414912, 0.070508391424576, 0.129287735160946,
1.71506498688328, 0.460916205989202, -1.26506123460653, -0.686852851893526,
-0.445661970099958), Y = c(2.44816359487892, 0.719627654114728,
0.801542901188104, 0.221365431890239, -1.11168226950815, 3.57382627360616,
0.995700956458479, -3.93323431325928, 1.40271180312737, -0.945582815455868
), Z = c(-4.27129482394738, -0.871899658633181, -4.10401779322896,
-2.91556491716456, -2.50015707139703, -6.74677324296965, 3.3511481779781,
0.613492471346061, -4.55254774804779, 5.01525968427971)), row.names = c(NA,
-10L), class = c("data.table", "data.frame"), sorted = "time")
stock_wide = as.data.frame(stocksm) %>% dcast(time ~ stock)
expect_equal(res2, stock_wide)
stock_wide_dt = stocksm %>% dcast(time ~ stock)
expect_equal(res2, stock_wide_dt)

res3 = structure(list(stock = structure(1:3, class = "factor", .Label = c("X",
"Y", "Z")), `2009-01-01` = c(-0.560475646552213, 2.44816359487892,
-4.27129482394738), `2009-01-02` = c(-0.23017748948328, 0.719627654114728,
-0.871899658633181), `2009-01-03` = c(1.55870831414912, 0.801542901188104,
-4.10401779322896), `2009-01-04` = c(0.070508391424576, 0.221365431890239,
-2.91556491716456), `2009-01-05` = c(0.129287735160946, -1.11168226950815,
-2.50015707139703), `2009-01-06` = c(1.71506498688328, 3.57382627360616,
-6.74677324296965), `2009-01-07` = c(0.460916205989202, 0.995700956458479,
3.3511481779781), `2009-01-08` = c(-1.26506123460653, -3.93323431325928,
0.613492471346061), `2009-01-09` = c(-0.686852851893526, 1.40271180312737,
-4.55254774804779), `2009-01-10` = c(-0.445661970099958, -0.945582815455868,
5.01525968427971)), row.names = c(NA, -3L), class = c("data.table",
"data.frame"), sorted = "stock")

stock_wide2 = as.data.frame(stocksm) %>% dcast(stock ~ time)
expect_equal(res3, stock_wide2)
stock_wide2_dt = stocksm %>% dcast(stock ~ time)
expect_equal(res3, stock_wide2_dt)

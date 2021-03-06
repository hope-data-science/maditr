cat("\nContext:","dt_count", "\n")

data(mtcars)

expect_equal(
    dt_count(mtcars, am, vs),
    take(mtcars, n = .N, by =.(am, vs))
)

expect_equal(
    dt_count(mtcars, am, vs, sort = TRUE),
    take(mtcars, n = .N, by =.(am, vs)) %>% sort_by(-n)
)

expect_equal(
    dt_count(mtcars, am, vs, name = "total"),
    take(mtcars, total = .N, by =.(am, vs))
)

expect_equal(
    dt_count(mtcars, am, vs, sort = TRUE, name = "total"),
    take(mtcars, total = .N, by =.(am, vs)) %>% sort_by(-total)
)

mtcars2 = mtcars

mtcars2$mpg[1:4] = NA

expect_equal(
    dt_count(mtcars2, am, vs, weight = mpg, name = "total"),
    take_if(mtcars2, !is.na(mpg), total = sum(mpg), by =.(am, vs))
)

expect_equal(
    dt_count(mtcars2,weight = mpg, sort = TRUE, name = "total"),
    take_if(mtcars2, !is.na(mpg), total = sum(mpg)) %>% sort_by(-total)
)

expect_equal(
    dt_count(mtcars2, am, vs, weight = mpg, sort = TRUE, name = "total"),
    take_if(mtcars2, !is.na(mpg), total = sum(mpg), by =.(am, vs)) %>% sort_by(-total)
)

############
cat("\nContext:","dt_add_count", "\n")

data(mtcars)

expect_equal(
    dt_add_count(mtcars, am, vs),
    let(mtcars, n = .N, by =.(am, vs))
)

expect_equal(
    dt_add_count(mtcars, am, vs, sort = TRUE),
    let(mtcars, n = .N, by =.(am, vs)) %>% sort_by(-n)
)

expect_equal(
    dt_add_count(mtcars, am, vs, name = "total"),
    let(mtcars, total = .N, by =.(am, vs))
)

expect_equal(
    dt_add_count(mtcars, am, vs, sort = TRUE, name = "total"),
    let(mtcars, total = .N, by =.(am, vs)) %>% sort_by(-total)
)

mtcars2 = mtcars

mtcars2$mpg[1:4] = NA

expect_equal(
    dt_add_count(mtcars, am, vs, weight = mpg, name = "total"),
    let_if(mtcars, !is.na(mpg), total = sum(mpg), by =.(am, vs))
)

expect_equal(
    dt_add_count(mtcars, am, vs, weight = mpg, sort = TRUE, name = "total"),
    let_if(mtcars, !is.na(mpg), total = sum(mpg), by =.(am, vs)) %>% sort_by(-total)
)

expect_equal(
    dt_add_count(mtcars,  weight = mpg, sort = TRUE, name = "total"),
    let_if(mtcars, !is.na(mpg), total = sum(mpg)) %>% sort_by(-total)
)

cat("\nContext:","dt_top_n", "\n")

data(mtcars)

expect_equal(
    dt_top_n(mtcars, 2),
    head(take_if(mtcars, order(-carb)), 2)
)


expect_equal(
    dt_top_n(mtcars, -2),
    tail(take_if(mtcars, order(-carb)), 2)
)


expect_equal(
    dt_top_n(mtcars, 2, order_by = mpg, by = list(am, vs)),
    query_if(mtcars, order(-mpg), head(.SD, 2), by = list(am, vs))
)


expect_equal(
    dt_top_n(mtcars, -2, order_by = mpg, by = list(am, vs)),
    query_if(mtcars, order(-mpg), tail(.SD, 2), by = list(am, vs))
)

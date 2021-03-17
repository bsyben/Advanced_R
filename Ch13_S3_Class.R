library(sloop)

# 13.2 Basics
f <- factor(c("a", "b", "c"))
typeof(f)
attributes(f)

unclass(f)

ftype(print)
ftype(str)
ftype(unclass)

print(f)

print(unclass(f))
time <- strptime(c("2017-01-01", "2020-05-04 03:21"), "%Y-%m-%d")
str(time)
str(unclass(time))
s3_dispatch(print(f))

print(time)
s3_dispatch(print(time))

ftype(t.test)
ftype(t.data.frame)

s3_get_method(weighted.mean.Date)
t.test()

ftype(as.data.frame.data.frame)
s3_get_method(as.data.frame.data.frame)

set.seed(1014)
some_days <- as.Date("2017-01-31") + sample(10, 5)

s3_dispatch(mean(some_days))
s3_dispatch(mean(unclass(some_days)))

x <- ecdf(rpois(100, 10))
str(x)
ftype(x)

x <- table(rpois(100, 5))
str(x)
s3_class(x)

x <- structure(list(), class = "my_class")
x <- list()
class(x) <- "my_class"

class(x)
inherits(x, "my_class")
inherits(x, "your_class")

mod <- lm(log(mpg) ~ log(disp), data = mtcars)
class(mod)
class(mod) <- "Date"
print(mod)

# 13.3.1 Constructors
new_Date <- function(x = double()) {
    stopifnot(is.double(x))
    structure(x, class = "Date")
}

new_difftime <- function(x = double(), units = "secs") {
    stopifnot(is.double(x))
    units <- match.arg(units, c("secs", "mins", "hours", "days", 
        "weeks"))

    structure(x, class = "difftime", units = units)
}

new_difftime(c(1, 10, 36000), "secs")

new_difftime(52, "weeks")

# 13.3.2 Validator
new_factor <- function(x = integer(), levels = character()) {
    stopifnot(is.integer(x))
    stopifnot(is.character(levels))

    structure(x, levels = levels, class = "factor")
}

validate_factor <- function(x) {
    values <- unclass(x)
    levels <- attr(x, "levels")

    if (!all(!is.na(values) & values > 0)) {
        stop("All `x` values must be non-missing and greater than zero", 
            call. = FALSE)
    }

    if (length(levels) < max(values)) {
        stop("There must be at least as many `levels` as possible values in `x`", 
            call. = FALSE)
    }

    x
}

validate_factor(new_factor(1:5, "a"))

validate_factor(new_factor(0:1, "a"))

factor <- function(x = character(), levels = unique(x)) {
    ind <- match(x, levels)
    validate_factor(new_factor(ind, levels))
}












library(Rcpp)

# No inputs, scalar output ----

## R function
one <- function() 1L # return scalar value 1 without any input

## Cpp function
cppFunction( #No assignment is needed like above
    # use int to delcare type of output returned by the function
    # there are four different types:
    #       double: a 64bit vlaue
    #       int: an integer
    #       string: a string value
    #       bool: True (1) or False (2)
    # every statement is terminated by ;
    'int one() { 
        return 1;
    }'
)

# Scalar input, scalar output ----

## R function
signR <- function(x){
    if(x > 0){
        return(1)
    }else if(x==0){
        return(0)
    }else{
        return(-1)
    }
}

## cpp function
cppFunction(
    # input x also need declaration
    'int signC(int x){
        if (x > 0){
            return 1;
        } else if (x==0){
            return 0;
        } else {
            return -1;
        }
    }'
)

# Vector input, scalar output ----

## R function
sumR <- function(x){
    total <- 0
    # seq_along retrive the index of vector x
    # seq_along(along.with = 2:10)
    #[1] 1 2 3 4 5 6 7 8 9
    for (i in seq_along(x)) {
        total <- total+x[i]
    }
    return(total)
}

## cpp function
cppFunction(
    # x.size() returns the length of vector x
    # for loop in cpp is differet: for (init;check;increment)
    #       init: create a new integer variable i and set it to 0
    #       check: loop termination condition. Before i reaches n, loop will continue
    #       increment: for each iteration, we add i by 1 using the special prefix ++
    # It is key to remeber index in cpp is the same as in python. It start with 0 and
    # end with length - 1. Unlike in R which start at 1 and end with length
    # Other inplace modify operator 
    'double sumC(NumericVector x){
        int n = x.size();
        double total = 0;
        for (int i = 0; i < n; ++i){
            total += x[i];
        }
        return total;
    }'
)

x <- runif(1e6)
bench::mark(
    sum(x),
    sumC(x),
    sumR(x)
)[1:6]

# vector input, vector output ----

#R function

pdistR <- function(x,y){
    sqrt((x-y)^2)
}

# cpp function
cppFunction(
    # we create a numeric vector out with length = n, which the size of y
    #       We can also use NumericVector out = clone(y)
    # for each value in out, calculate Euclidean distance with pow and sqrt
    'NumericVector pdistC(double x, NumericVector y){
        int n = y.size();
        NumericVector out(n);
        
        for(int i=0;i<n;++i){
            out[i] = sqrt(pow(y[i] - x, 2.0));
        }
        return out;
    }'
)

y <- runif(1e6)
bench::mark(
    pdistR(0.5,y),
    pdistC(0.5,y)
)[1:6]






















library(R6)

Accumulator <- R6::R6Class("Accumulator",list(
    sum=0,
    add = function(x=1){
        self$sum <- self$sum+x
        invisible(self)
    }
))

List <- R6::R6Class("List",
    private=list(
        l = list(),
        i = 1 
    ),
    public=list(
    initialize = function(value){
        self$l[[self$i]] <- value
    },
    append = function(x){
        self$i <- self$i + 1
        self$l[[self$i]] <- x
        invisible(self)
    },
    pop = function(){
        self$l[[self$i]] <- NULL
        self$i <- self$i - 1
        invisible(self)
    },
    print = function(...){
        print(self$l)
        invisible(self)
    })
)

x <- List$new(10)
x$append(1)$append(1)$append(1)
x$pop()$pop()$pop()

e1 <- rlang::env(a=FALSE,
                 b="a",
                 c=2.3,
                 d=1:3)
e1$d <- e1
e2a <- env(d=4,e=5)
e2b <- env(e2a,a=1,b=2,c=3)
e2c <- env(empty_env(),d=4,e=5)
e2d <- env(e2c,a=1,b=2,c=3)

x <- 0
f <- function(){
    x <<- x+1
    return(x)
}

e3 <- env(x=1,y=2)
e3$x
e3[["y"]]
e3[["z"]] <- 3
e3$z
e3$a
env_get(e3,"a",default = NA)
env_poke(e3,"a",100)

env_bind(e3,a=10,b=11,c=12)
env_names(e3)
list.test<- list(a=1,b=2,c=3)
env_poke_only <- function(env=current_env(),name,value){
    if(!env_has(env,name)){
        env_poke(env,name,value)
    }else{
        stop(paste0(name," already exists in ",env_name(env)),call. = F)
    }
}

env_poke_only(e3,"g",10)
env_unbind(e3,"g")

rebind <- function(name, value, env = caller_env()) {
    if (identical(env, empty_env())) {
        stop("Can't find `", name, "`", call. = FALSE)
    } else if (env_has(env, name)) {
        env_poke(env, name, value)
    } else {
        rebind(name, value, env_parent(env))
    }
}
rebind("a",10,env=e2a)
a <- 10

where <- function(name, env=caller_env()){
    if (identical(env,empty_env())){
        stop("Can't find ", name, call. = FALSE)
    }else if(env_has(env,name)){
        env
    }else{
        where(name, env_parent(env))
    }
}
where("yyy")
where("mean")

e4a <- env(empty_env(), a = 1, b = 2)
e4b <- env(e4a, x = 10, a = 11)

where("c",e4b)

library(rlang)




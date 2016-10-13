## Code used in the presentation on parallel computations in R
library(parallel)

print("Number of cores on PC", detectCores())

loss.dist <- function(seed, N)
{
  set.seed(seed)
  return(runif(N))
}

#N <- 4
#seed <- 1
#print(loss.dist(seed, N))

## parallel sum calculation
## first check if the split is correct
nc <- 2 # number of cores
cl <- makeCluster(nc)
sq <- 1:8
L <- length(sq)
clusterExport(cl, list("sq", "nc", "L"))
# check first that the split is correct
parLapply(cl, 1:nc
  , function(x) sq[(1+(x-1)*L/nc):(x*L/nc)]
	)
# [[1]] 
# [1] 1 2 3 4
# [[2]]
# [1] 5 6 7 8
## second, apply sum
res <- parLapply(cl, 1:nc
, function(x) sum(sq[(1+(x-1)*L/nc):(x*L/nc)])
	)
print(res)
# [[1]]
# [1] 10
# [[2]]
# [1] 26
print(sum(unlist(res))) # collect results
# [1] 36

## Farenheit to Celcius - wrong interpretation
#c <- function(t) t*5/9-32
#nc <- 4
#temps <- seq(10, 40, 10)
#cl <- makeCluster(nc)
#clusterExport(cl, list("temps"))
# parLapply(cl, 1:nc, function(x) c(temps[x]))

## Farenheit to Celcius - correct implementation
library(parallel)
C <- function(t) t*5/9-32
nc <- 4
temps <- seq(10, 40, 10)
cl <- makeCluster(nc)
clusterExport(cl, list("temps", "C"))
parLapply(cl, 1:nc, function(x) C(temps[x]))

## parallel loss distribution
parallel.loss.dist <- function(seed, N)
{
  no_cores <- 2
  cl <- makeCluster(no_cores)
  clusterExport(cl, list("loss.dist"))
  temp.res <- parLapply(
	cl
	, seed:(seed + 1)
	, function(x) loss.dist(x, N)
	)
  stopCluster(cl)
  return(unlist(temp.res))
}
print(parallel.loss.dist(1,4))
# [1] 0.2655087 0.3721239 0.1848823 0.7023740


measure.time <- function(command)
{
  start.time <- Sys.time()
  eval(parse(text = command))
  end.time <- Sys.time()
  return(difftime(end.time, start.time, units = "secs"))
}

measure.time("sum(parallel.loss.dist(1, 1e+07))")
measure.time("sum(loss.dist(1, 1e+07))")

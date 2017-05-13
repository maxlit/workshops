eta <- function(mu, sigma) sigma*dnorm(-mu/sigma)/(1 - pnorm(-mu/sigma))

mu_ <- function(mu, sigma) mu + eta(mu, sigma)
sigma_ <- function(mu, sigma) sigma^2 - mu*eta(mu, sigma) + eta(mu, sigma)^2


criterium <- function(mu_0, sigma_0) # function returns function
{
  return(
    function(par) 
    {
      mu <- par[1]
      sigma <- par[2]
      mu_0 <- 1 # can also be part of parameter
      sigma_0 <- 0.5
      return((mu_(mu, sigma) - mu_0)^2 + (sigma_(mu, sigma) - sigma_0)^2)
    }
  )
}

#collateral with 100% mean and 50% volatility
mu_0 <- 1
sigma_0 <- 0.5

res <- optim(c(mu_0, sigma_0), criterium(mu_0, sigma_0))

print(res$par)
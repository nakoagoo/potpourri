a <- matrix(data = 1:12, nrow = 4, ncol = 3)
b <- apply(a, 1, function(x) sqrt(x))
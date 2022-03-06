fac 0 = 0
fac 1 = 1
fac n = n * fac (n - 1)
main = interact $ show . fac . read

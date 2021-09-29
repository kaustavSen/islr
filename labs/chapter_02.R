# General operations
set.seed(3)
y <- rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)

# 2-D Plots using base R
x <- rnorm(100)
y <- rnorm(100)
plot(x, y)
plot(x, y, xlab = "this is the x-axis", ylab = "this is the y-axis",
     main = "Plot of X vs Y")

pdf("plots/Figure.pdf")
plot(x, y, col = "blue")
dev.off()


# 3-D Plots using base R

# Read in the data
Income <- read.csv("https://www.statlearning.com/s/Income2.csv")

# Fit a multiple linear regression plane
lm_fit <- lm(Income ~ Education + Seniority, data = Income)

# Setup for plotting the "best-fit" surface
x <- 10:22
y <- seq(20, 200, 10)
z <- outer(x, y, function(x, y) predict(lm_fit, newdata = data.frame(Education = x, Seniority = y)))

# Open file to save image
png("plots/figure_2_4.png", width = 9, height = 6, units = "in", res = 150)

# Plot the surface
surface <- persp(x, y, z, theta = 30, phi = 20, expand = 0.6, col = "darkgoldenrod2",
      xlab = "Years of Education", ylab = "Seniority", zlab = "Income")

# Add error lines
from <- trans3d(Income$Education, Income$Seniority, Income$Income, pmat = surface)
to <- trans3d(Income$Education, Income$Seniority, predict(lm_fit), pmat = surface)
segments(from$x, from$y, to$x, to$y)

# Add the points from data
points(trans3d(Income$Education, Income$Seniority, Income$Income, pmat = surface), 
       col = "red", pch = 16)

# Close file
dev.off()

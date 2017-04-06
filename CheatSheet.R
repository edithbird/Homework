#Code for generic time series plot for one year broken out by month

setwd("/Users/Chris Iyer/Documents/Assignment5Predictive/")
walMart <- read.csv("WalMartStock.csv", header = TRUE, stringsAsFactors = FALSE)
tail(walMart)
walMart.ts <- ts(walMart$Close, start = c(2001, 1), frequency = 248)

#walMart2.ts <- ts(walMart$Close, start = c(2001, 1), frequency = 365)
yrange <- range(walMart.ts)
# Set up the plot
plot(c(2001, 2002), yrange, type="n", xlab="Year ",  ylab = "Y Variable", main = "Title", bty="l", xaxt="n", yaxt="n")

# Add the time series data
lines(walMart.ts, bty="n", col = "black")
#lines(walMart2.ts, bty = "n", col ="blue")

# Add the x-axis broken out by month
axis(1, at=seq(2001,2001+11/12,1/12), labels=c("Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan"))

# Add the y-axis
axis(2, at=seq(40,65, 2), labels=format(seq(40,65, 2)), las=2)
legend(2001,60, c("Actual"), lty=c(1), col=c("black"), bty="n")

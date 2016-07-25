#!/usr/bin/Rscript
# Take care while adding print statement as it impacts calculateEditDistance.sh

#Read Command line arguments
args<-commandArgs(TRUE)
inputFile<-args[1]
chartPath<-args[2]
chartName<-args[3]

# Read Relative EditCost List
editcostTable=read.table(inputFile, header=TRUE)

removeOutliers<-function(editcostTable){
qnt_99<-quantile(editcostTable$X.RelativeEditcost, c(0.99))
non_outliers<-subset(editcostTable, editcostTable$X.RelativeEditcost<qnt_99[1])
}

calcMean <- function(editcostCol){
    # Find the Standard Deviation
    mean = mean(editcostCol)
    print(mean)
}

calcMedian <- function(editcostCol){
    # Find the Standard Deviation
    med = median(editcostCol)
    print(med)
}

calcSD <- function(editcostCol){
    # Find the Standard Deviation
    sd = sd(editcostCol)
    print(sd)
}

generateReport <- function(editcostCol){
    # Plot graph on RelativeEditcost
    jpeg(chartPath)
    plot(editcostCol,
        type='l',
        main= paste0(chartName,"\n \t Mean= ",mean," \t Median= ",med," \t StandardDeviation= ",sd),
        xlab="File Number",
        ylab="%RelativeEditcost",
        col="red"
        )
        dev.off()
}
non_outliers=removeOutliers(editcostTable)
mean=calcMean(non_outliers$X.RelativeEditcost)
med=calcMedian(non_outliers$X.RelativeEditcost)
sd=calcSD(non_outliers$X.RelativeEditcost)
generateReport(non_outliers$X.RelativeEditcost)

#!/usr/bin/Rscript
# Take care while adding print statement as it impacts calculateFragmentation.sh
#Read Command line arguments
args<-commandArgs(TRUE)
inputFile<-args[1]
chartPath<-args[2]
chartName<-args[3]

# Read Fragmentation List
fragTable=read.table(inputFile, header=TRUE)

removeOutliers<-function(fragTable){
qnt_99<-quantile(fragTable$X.Fragmentation, c(0.99))
non_outliers<-subset(fragTable, fragTable$X.Fragmentation<qnt_99[1])
}

calcMean <- function(fragCol){
    # Find the Standard Deviation
    mean = mean(fragCol)
    print(mean)
}

calcMedian <- function(fragCol){
    # Find the Standard Deviation
    med = median(fragCol)
    print(med)
}

calcSD <- function(fragCol){
    # Find the Standard Deviation
    sd = sd(fragCol)
    print(sd)
}

generateReport <- function(fragCol){
    # Plot graph on Fragmentation
    print(chartPath)
    jpeg(chartPath)
    plot(fragCol,
        type='l',
        main= paste0(chartName,"\n Mean= ",mean," Median= ",med," \n StandardDeviation= ",sd),
        xlab="File Number",
        ylab="%Fragmentation",
        col="red"
        )
        dev.off()
}
non_outliers=removeOutliers(fragTable)
mean=calcMean(non_outliers$X.Fragmentation)
med=calcMedian(non_outliers$X.Fragmentation)
sd=calcSD(non_outliers$X.Fragmentation)
generateReport(non_outliers$X.Fragmentation)

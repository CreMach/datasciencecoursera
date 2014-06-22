
##Cleaning and combining data for training set

trainxfile<-"./UCI Dataset/train/X_train.txt"
tr_X<-read.table(trainxfile)

featurefile<-"./UCI Dataset/features.txt"
feature<-read.table(featurefile)
colnames(tr_X)<-feature[,2]

tr_X2<-tr_X[,grepl("mean",colnames(tr_X))|grepl("std",colnames(tr_X))]

trainyfile<-"./UCI Dataset/train/y_train.txt"
tr_Y<-read.table(trainyfile)

trainsubfile<-"./UCI Dataset/train/subject_train.txt"
tr_Sub<-read.table(trainsubfile)

Train1<-cbind(tr_Sub,tr_Y)
Train1[,2]<-sapply(Train1[,2],switch, "1" = "Walking", "2" = "Walking_upstairs", "3" = "Walking_downstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying")
NewTrain<-do.call(paste,Train1)

Train2<-cbind(Train1,NewTrain,tr_X2)
colnames(Train2)[1:3]<-c("Subject_ID","Activity","ID_Activity")

##Cleaning and combining data for testing set

testxfile<-"./UCI Dataset/test/X_test.txt"
te_X<-read.table(testxfile)

colnames(te_X)<-feature[,2]
te_X2<-te_X[,grepl("mean",colnames(te_X))|grepl("std",colnames(te_X))]

testyfile<-"./UCI Dataset/test/y_test.txt"
te_Y<-read.table(testyfile)

testsubfile<-"./UCI Dataset/test/subject_test.txt"
te_Sub<-read.table(testsubfile)

Test1<-cbind(te_Sub,te_Y)
Test1[,2]<-sapply(Test1[,2],switch, "1" = "Walking", "2" = "Walking_upstairs", "3" = "Walking_downstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying")
NewTest<-do.call(paste,Test1)

Test2<-cbind(Test1,NewTest,te_X2)
colnames(Test2)[1:3]<-c("Subject_ID","Activity","ID_Activity")

##Combining both training and testing data

library(reshape2)
data<-rbind(Train2,Test2)
data2 <- data[,3:ncol(data)]
datamelt <- melt(data2,id="ID_Activity",measure.vars=colnames(data2[,2:ncol(data2)]))
cleandata <- dcast(datamelt,ID_Activity ~ variable,mean)
write.table(cleandata, "./clean.txt", sep="\t")


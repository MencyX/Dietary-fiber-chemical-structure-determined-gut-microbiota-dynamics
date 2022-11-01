library(networkD3)
mydata<-read.table('/Users/mx/Desktop/Sankey diagram.txt',sep="\t",head=T)

Sankeylinks <- mydata
Sankeynodes <- data.frame(name=unique(c(Sankeylinks$source,Sankeylinks$target)))
Sankeynodes$index <- 0:(nrow(Sankeynodes) - 1)       
Sankeylinks <- merge(Sankeylinks,Sankeynodes,by.x="source",by.y="name")  #替换source列
Sankeylinks <- merge(Sankeylinks,Sankeynodes,by.x="target",by.y="name")  #替换target列
Sankeydata <- Sankeylinks[,c(5,6,3,4)]  #只保留索引值列，用于绘图
names(Sankeydata) <- c("Source","Target","Value","group") 
Sankeyname <- Sankeynodes[,1,drop=FALSE]     

color <- 'd3.scaleOrdinal() .domain(["Badolescentis ATCC 15703","Llactis ATCC 19435","Lcasei ATCC 334","Bbreve ATCC 15700","Lbrevis ATCC 14869","Blongum ATCC 15707","Lacidophilus ATCC 4356","Lrhamnosus ATCC 53103","A1.2linker","A1.3linker","A1.4linker","A1.5linker","A1.6linker","B1.2linker","B1.4linker","B1.6linker","B2.6linker","Arabinose","Fructose","Galactose","Glucose","Mannose","Xylose","N", "Inu", "AssP"]) 
.range(["#46b8da","#21773c","#206d69","#566158","#4d4282","#4e2261","#6e6f70","#903245","#703063","#333a79","#434769","#764d42","#a01d27","#d21621","#82324e","#8b5c29","#861d48","#515374","#69365f","#B14224","#396347","#4b3166","#804559","#d7d7d7", "#d595a7","#7a65a5"])'

sankeyNetwork(Links=Sankeydata, Nodes=Sankeyname, Source ="Source", Target = "Target", Value = "Value", LinkGroup = 'group',NodeID = "name", fontSize = 12,colourScale = color, nodeWidth = 30, height = 750, width = 2000, sinksRight=FALSE) 


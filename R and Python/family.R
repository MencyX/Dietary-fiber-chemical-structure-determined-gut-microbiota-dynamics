species <- read.csv('/Users/mx/Desktop/family.csv', row.names = 1, stringsAsFactors = FALSE, check.names = FALSE,sep = ,)
species$sum <- rowSums(species)
species <- species[order(species$sum, decreasing = TRUE), ]
species_top30 <- species[1:30, -ncol(species)]
species_top30['Others', ] <- 1 - colSums(species_top30)
write.csv(species_top30, '/Users/mx/Desktop/speciestop30.csv', quote = FALSE)

library(reshape2)
library(ggplot2)

species_top30$Taxonomy <- factor(rownames(species_top30), levels = rev(rownames(species_top30)))
species_top30 <- melt(species_top30, id = 'Taxonomy')
group <- read.csv('/Users/mx/Desktop/mapping.csv', stringsAsFactors = FALSE, sep = ,)
names(group)[1] <- 'variable'
species_top30 <- merge(species_top30, group, by = 'variable')

species_top30$variable=factor(species_top30$variable)
ggplot(species_top30, aes(variable, value, fill = Taxonomy)) +
  geom_col(position = 'stack', width = 0.6) +
  scale_fill_manual(values =  rev(c( "#00468B","#42B540"  ,"#0099B4"  ,"#925E9F" ,"#FDAF91"  ,"#AD002A"  ,"#ADB6B6"  ,"#1B1919","#E64B35" ,"#4DBBD5" ,"#00A087" ,"#3C5488" ,"#F39B7F" ,"#8491B4","#91D1C2" ,  "#7E6148" ,"#B09C85" ,"#5C88DA" ,"#84BD00","#FFCD00", "#7C878E" , "#00B5E2"  , "#631879" , "#A20056", "#374E55" ,'#DF8F44','#B24745','#79AF97', "#80796B", "#CD534C","#FFCCCC"))) +
  labs(x = '', y = 'Relative abundance(%)') +
  theme_classic()+theme_prism(base_size = 12,base_line_size=0.3,base_family="Helvetica",base_fontface = "plain")+theme(text=element_text(family="Helvetica"),legend.position='none')


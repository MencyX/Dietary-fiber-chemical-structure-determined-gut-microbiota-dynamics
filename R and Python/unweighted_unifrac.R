library(ggplot2)
library(ggpubr)
library(ggsci)


PCOA<-read.csv('/Users/mx/Desktop/unweighted_unifrac.csv',header = T,sep = ,)
colnames(PCOA)[3]<-"group"
p<-ggscatter(PCOA,x="PC1", y="PC2", color="group",ellipse =TRUE,ellipse.level = 0.95,ellipse.alpha = 0.2,ellipse.border.remove =T ,mean.point = FALSE,star.plot = F) +labs(x ="PC1(23.9%)" ,y="PC2(21.4%)")+theme_classic()+theme_prism(base_size = 13,base_line_size=0.5,base_family="Helvetica",base_fontface = "plain")+theme(legend.position='none')
p<-ggpar(p, palette =c("#42B540FF","#925E9FFF","#00468BFF","#ED0000FF"))
p+ theme(text=element_text(family="Helvetica"))
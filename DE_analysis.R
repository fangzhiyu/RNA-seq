setwd('D:/OneDrive/学习/课题组/小课题exon splicnig/6 DESeq2')
library('DESeq2')


countData = as.matrix(read.csv("gene_count_matrix.csv", row.names="gene_id",encoding='UTF-8',check.names = F))
row = rownames(countData)
new_row=c()
for (i in row){
  tmp = unlist(strsplit(i,split="\\W"))[0:1][1] 
  new_row=c(new_row,tmp)
  rm(tmp,i)
}
rownames(countData) = new_row
rm(new_row,row)
colData = read.csv("colData.csv", sep=',',encoding = 'UTF-8')

rownames(colData) = colData$id
colData = colData[,-1]
colData$treatment = factor(colData$treatment)
colData$day = factor(colData$day)
all(rownames(colData) %in% colnames(countData))
countData <- countData[, rownames(colData)]
all(rownames(colData) == colnames(countData))


# construct dds matrix 
dds <- DESeqDataSetFromMatrix(countData = countData,
                                colData = colData, design = ~ day + treatment)

# normalization
dds = DESeq(dds)

# DE analysis 
res = DESeq2::results(dds)

#sort by adjusted p-value and display
(resOrdered <- res[order(res$padj), ])


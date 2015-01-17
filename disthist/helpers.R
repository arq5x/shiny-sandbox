distances<-function(i, sample_size, opt.string="")
{
  out = tempfile()
  
  command=paste("bedtools sample -i", i, "-n", sample_size, "| sort -k1,1 -k2n |",
    "bedtools spacing -i - ", opt.string, 
    " | awk '{if ($NF!=\".\"){print $NF}}' >", out, sep=" ")
  cat(command,"\n")
  try(system(command))
  
  res=read.table(out,header=F)
  head(res)
  unlink(out)
  return(res)
}
  
shuf<-function(i, sample_size, opt.string="")
{
  out = tempfile()
  shuf = tempfile()
  
  command=paste("bedtools sample -i ", i, "-n", sample_size, "|",
    "bedtools shuffle -i -", "-g", "data/human.hg19.genome | sort -k1,1 -k2,2n", ">", shuf, sep=" ")
  cat(command,"\n")
  try(system(command))

  command=paste("bedtools spacing -i", shuf,  opt.string, " | awk '{if ($NF!=\".\"){print $NF}}' >", out, sep=" ")
  cat(command,"\n")
  try(system(command))
  
  res=read.table(out,header=F)
  head(res)
  unlink(out)
  return(res)
}

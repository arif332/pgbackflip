import sys
import pandas as pd

inf=sys.argv[1]
outf=sys.argv[2]


data = pd.read_csv(inf,sep=";").T
data.to_csv(outf,sep=":",header=False)

#data = pd.read_csv("temp_call_metrics.txt",sep=";").T
#data.to_csv("final_metrics_for_openimscore.txt",sep=":",header=False)


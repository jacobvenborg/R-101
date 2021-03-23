# Problem

Jeg har lavet en dataframe `df.outmedicine` indeholdende data angående patienters medicin til respektive visits i et projekt. Dataframen er lavet ud fra en variabel `outmedicine` (fra et andet datasæt), hvor et udsnit af dennes indhold er vist her:

# Udsnit af variablen "outmedicine"
```R
# For alle udsnit gælder visit == "baseline"

# Subject 65
[['BIOLOGIC_PROJECT_MEDICINE','BIOPROJ','520','BIOFREQ_EVERY_4_WEEKS','20140918','',('WITHDRAWN_PROJECTPARTICIPATION',),None,('RADS_ALL1_RESEARCH_PROJECT',),1,1,0,'danbioordination.2015-01-29.4833204617'],'-','-']

# Subject 66
[['DMARD_FOLIMET',None,'5','BIOFREQ_5TW','20140702','',('WITHDRAWN_NO_EFFECT',),1,(),None,None,None,'danbioordination.2014-07-02.7827534775'],['DMARD_MTX',None,'25','BIOFREQ_WEEKLY','20140702','',('WITHDRAWN_ADVERSE_EVENTS',),2,(),None,None,None,'danbioordination.2014-07-02.6681206944'],['BIOLOGIC_PROJECT_MEDICINE','BIOPROJ','480','BIOFREQ_EVERY_1_MONTHS','20141001','',('WITHDRAWN_PROJECTPARTICIPATION',),None,('RESEARCH_PROJECT',),1,1,0,'danbioordination.2014-10-01.2598184359'],'-','-','-','-','-']

# Subject 68
[['DMARD_MTX',None,'20','BIOFREQ_WEEKLY','20140701','',('WITHDRAWN_PREGNANCYWANTED',),None,(),None,None,None,'danbioordination.2014-07-29.6393953637'],['BIOLOGIC_PROJECT_MEDICINE','BIOPROJ','460','','20140930','',('WITHDRAWN_PROJECTPARTICIPATION',),None,('RESEARCH_PROJECT',),1,1,0,'danbioordination.2014-09-30.0113759995'],'-','-']

# Subject 72
['-',['DMARD_MTX_SC',None,'20','BIOFREQ_WEEKLY','20140818','',(),None,(),None,None,None,'danbioordination.2014-08-18.6050791266'],['DMARD_FOLIMET',None,'15','BIOFREQ_WEEKLY','20140818','',(),None,(),None,None,None,'danbioordination.2014-08-18.6541013988'],['BIOLOGIC_PROJECT_MEDICINE','BIOPROJ','670','BIOFREQ_EVERY_4_WEEKS','20141020','',('WITHDRAWN_ADVERSE_EVENTS',),2,('RESEARCH_PROJECT',),1,1,0,'danbioordination.2014-10-27.1546554110'],'-','-','-','-']
```
Som det forhåbentlig fremgår, har jeg altså en variabel af variabel (høhø) længde, så det er jo bare super.Fandt heldigvis frem til `splitstackshape::cSplit()` som faktisk kan splitte sådanne ubrugelige variable, så det er helt kanon. Her er lidt kode, som ender med et udsnit af den kreerede dataframe:
# Lav df.outmedicine

```R
# Load pakker og data
require(tidyverse)
require(splitstackshape)
load("C:/R/DanACT/RData/all-in-one-DanACT.RData")

# Lav df med variable (vi tager de fem første kolonner fra df.visits + outmedicine)
df.outmedicine <- df.visits[ , c(1:5, grep("outmedicine", colnames(df.visits)))]
df.outmedicine <- df.outmedicine %>%
mutate(
count = str_count(outmedicine, ","),
split = str_split(outmedicine, "\\,")
) %>%
relocate(
c(count, split), .before = outmedicine)


# Split outmedicine i xxx antal kolonner.. Tak, cSplit
df.outsplit <- cSplit(
df.outmedicine,
"outmedicine",
sep = ",",
direction = "wide",
drop = FALSE)

df.outmedicine$count <- as.integer(df.outmedicine$count)

# Definér liste med vars til redigering
vars.outmedicine <- df.outmedicine %>%
select(starts_with("outmedicine_"))

# Lav lidt kedeligt, manuelt arbejde, før man vel kan give den gas
# Fjern "'"
df.outmedicine <- as.data.frame(
lapply(
df.outmedicine,
function(x) gsub("\\'", "", x)))

# Fjern "[" og "]"
df.outmedicine <- as.data.frame(
lapply(
df.outmedicine,
function(x) gsub("\\[", "", x)))
df.outmedicine <- as.data.frame(
lapply(
df.outmedicine,
function(x) gsub("\\]", "", x)))
df.outmedicine <- as.data.frame(
lapply(
df.outmedicine,
function(x) gsub("\\(", "", x)))
df.outmedicine <- as.data.frame(
lapply(
df.outmedicine,
function(x) gsub("\\)", "", x)))
df.outmedicine <- as.data.frame(
lapply(
df.outmedicine,
function(x) gsub("^\\-$", "", x)))

# Udsnit af df
df.outmedicine2 <- df.outmedicine[0:300, ]
dput(df.outmedicine2, file = "dput/df.outmedicine.txt")
df.outmedicine <- dget(df.outmedicine2, file = "dput/df.outmedicine.txt")
```
Her er et link til data:

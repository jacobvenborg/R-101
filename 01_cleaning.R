# Script til FÅ, når jeg fucker alting op hele tiden
library(tidyverse)


data.PV <- read.csv("VagalToneInInflammat-PatientVisitations_DATA_2020-R.csv")
# names(data.PV)[names(data.PV)=="redcap_event_name"] <- "visit"
data.PV <- rename(data.PV, visit = redcap_event_name)
data.PV <- rename(data.PV, id = subject_id)
# data.PV$visit <- gsub("_arm_1", "", data.PV$visit)
# data.PV$visit <- gsub("visit_", "", data.PV$visit)
data.PV$visit <- str_replace(data.PV$visit, "visit_", "")
data.PV$visit <- str_replace(data.PV$visit, "_arm_1", "")
data.PV$visit <- as.factor(data.PV$visit)
data.PV$visit <- factor(data.PV$visit, labels = c("Baseline", "24 hours", "Day 5"))
data.PV$visit <- as.factor(data.PV$visit)
data.PV$visit <- factor(data.PV$visit, labels = c("Baseline", "24 hours", "Day 5"))
# data.PV <- data.PV[, -grep("repeat", colnames(data.PV))]
# data.PV <- data.PV[, -grep("comment", colnames(data.PV))]
data.PV <- data.PV %>% 
  select(-contains("redcap"))


# ---

# Lad os lege med tidyverse


data.PV %>%
  select(contains("mhaq")) %>% 
  transmute(mhaq = rowMeans(.))

data.PV <- data.PV %>% 
  mutate(mhaq)


data.PV %>%
  select(contains("mhaq")) %>% 
  summarise()


# Lav en samlet MHAQ-score
data.PV %>% 
  mutate(mhaq = rowMeans(select(., contains("mhaq"))))

mhaq %>% 
  mutate(mhaq.total = rowSums(.)) %>% 
  mutate(mhaq = mhaq.total/8)

data.PV %>% 
  mutate(mhaq = rowSums(select(contains("mhaq"))))


data.PV$newdate_visitation <- strptime(as.character(data.PV$date_visitation), "%d/%m/%Y")  




# Dato
data.PV$date_visitation <- as.Date(data.PV$date_visitation, "%d/%m/%Y")
data.PV$date_visitation <- (format(data.PV$date_visitation, "%d/%m/%Y"))
data.PV$date_visitation <- as.Date(data.PV$date_visitation, format = "%d/%m/%Y")


# data.PV$date_visitation <- format(data.PV$date_visitation, "%d/m%/%Y")
# data.PV$date_visitation <- strptime(as.character(data.PV$date_visitation, "%d/%m/%Y"))

class(d)
[1] "character"
d = as.Date(d)
class(d)
[1] "Date"
d = format(d,"%Y-%b-%d")
d
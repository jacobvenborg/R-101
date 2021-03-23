#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('VagalToneInInflammat-PatientVisitations_DATA_2020')
#Setting Labels

label(data$subject_id)="Subject ID"
label(data$redcap_event_name)="Event Name"
label(data$redcap_repeat_instrument)="Repeat Instrument"
label(data$redcap_repeat_instance)="Repeat Instance"
label(data$date_visitation)="Visitation date"
label(data$bp_sys)="Blood pressure (systolic)"
label(data$bp_dia)="Blood pressure (diastolic)"
label(data$bp_pulse)="Pulse (from blood pressure)"
label(data$cvt_raw)="CVT average - raw data"
label(data$hr_raw)="Heartrate - raw data (BPM)"
label(data$cvt_edited)="CVT average - edited"
label(data$hr_edited)="Heartrate - edited (BPM)"
label(data$gc_dose_r)="Dose of stimulation (right)"
label(data$gc_dose_l)="Dose of stimulation (left)"
label(data$gc_stimulations_left)="Number of stimulations left"
label(data$bp_sys_20)="Blood pressure (systolic)"
label(data$bp_dia_20)="Blood pressure (diastolic)"
label(data$bp_pulse_20)="Pulse"
label(data$cvt_raw_20)="CVT average - raw data"
label(data$hr_raw_20)="Heartrate - raw data (BPM)"
label(data$cvt_edited_20)="CVT average - edited"
label(data$hr_edited_20)="Heartrate - edited (BPM)"
label(data$comments_pv)=""
label(data$crp)="CRP (mg/l)"
label(data$ld)="P-Laktatdehydrogenase, LDH (U/I)"
label(data$alat)="P-ALAT (U/I)"
label(data$basp1)="B-Basisk fosfatase (U/I)"
label(data$glc)="P-Glukose (mmol/l)"
label(data$tsh)="P-Thyrotropin, TSH (10^-3 IE/l)"
label(data$alb)="P-Albumin (g/l)"
label(data$crea)="P-Kreatinin (µmol/l)"
label(data$egfr2)="eGFR (ml/min)"
label(data$lkc)="B-Leukocytter (10^9/l)"
label(data$neutro)="B-Neutrofilocytter (10^9/l)"
label(data$meta)="B-Metamyelocytter (10^9/l)"
label(data$lymf)="B-Lymfocytter (10^9/l)"
label(data$mono)="B-Monocytter (10^9/l)"
label(data$eos)="B-Eosinofilocytter (10^9/l)"
label(data$baso)="B-Basofilocytter (10^9/l)"
label(data$hb)="B-Hæmoglobin /mmol/l)"
label(data$trc)="B-Trombocytter (10^9/l)"
label(data$mhaq1)="Kan du selv klæde dig på? (det gælder også snørrebånd og knapper)"
label(data$mhaq2)="Kan du selv klare at komme i og ud af en seng?"
label(data$mhaq3)="Kan du løfte en fyldt kop eller fyldt glas?"
label(data$mhaq4)="Kan du selv gå rundt udendørs, hvor der er fladt?"
label(data$mhaq5)="Kan du selv vaske og tørre dig over det hele?"
label(data$mhaq6)="Kan du selv samle f.eks. tøj op fra gulvet?"
label(data$mhaq7)="Kan du åbne og lukke en almindelig vandhane?"
label(data$mhaq8)="Kan du selv komme ind og ud af en bil?"
label(data$vas_pmr)="På en skala fra ingen effekt til maksimal negativ effekt, hvor meget påvirker din muskelgigt dig i dag?"
label(data$vas_hip)="På en skala fra ingen smerter til værst tænkelige smerter, hvor smertepræget er du i dine hofter?"
label(data$vas_global)="På en skala fra ingen smerter til værst tænkelige smerter, hvor smertepræget er du generelt set?"
label(data$morning_stiffness)="Hvor lang tid varer din morgenstivhed?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("enrollment_arm_1","visit_1_arm_1","visit_2_arm_1","visit_3_arm_1","extra_contacts_arm_1","adverse_effects_arm_1","end_of_study_arm_1"))
data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("adverse_events_ae","patient_visitation"))
data$mhaq1.factor = factor(data$mhaq1,levels=c("0","1","2","3"))
data$mhaq2.factor = factor(data$mhaq2,levels=c("0","1","2","3"))
data$mhaq3.factor = factor(data$mhaq3,levels=c("0","1","2","3"))
data$mhaq4.factor = factor(data$mhaq4,levels=c("0","1","2","3"))
data$mhaq5.factor = factor(data$mhaq5,levels=c("0","1","2","3"))
data$mhaq6.factor = factor(data$mhaq6,levels=c("0","1","2","3"))
data$mhaq7.factor = factor(data$mhaq7,levels=c("0","1","2","3"))
data$mhaq8.factor = factor(data$mhaq8,levels=c("0","1","2","3"))

levels(data$redcap_event_name.factor)=c("Enrollment","Visit 1","Visit 2","Visit 3","Extra Contacts","Adverse Effects","End of Study")
levels(data$redcap_repeat_instrument.factor)=c("Adverse Events (AE)","Patient Visitation")
levels(data$mhaq1.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")
levels(data$mhaq2.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")
levels(data$mhaq3.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")
levels(data$mhaq4.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")
levels(data$mhaq5.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")
levels(data$mhaq6.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")
levels(data$mhaq7.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")
levels(data$mhaq8.factor)=c("Ja, uden besvær","Ja, med noget besvær","Ja, med meget besvær","Nej, det kan jeg ikke")

## HELP FOR R GOD DAMN IT

## Skift placering af arbejdsmappe/working directory
setwd("C:\\Users\\Jacob Venborg\\Google Drev\\Forskningsår\\")
setwd("C:/Users/Jacob Venborg/Google Drev/Forskningsår/Vagal Tone in Inflammatory Diseases/STATA/")

## "Subsetting vectors" = kig på bestemte værdier i en vektor?
x[1:10] ## viser værdierne nr. 1-10 i den angivne vektor(x)
x[is.na(x)] ## viser alle N/A-værdier i den angivne vektor(x). Man kan bruge "!" for at gøre det modsatte
x > 0 ## viser værdier større end 0 i vektor(x)

## Få vist den 3., 5., 7., mv. værrdi af en vektor
x[c(3,5,7)] ## c = contrast. Vi får vist vektor(x), men angiver at vi kun vil se nr. 3, 5, 7 i vektor(x)
x[c(-3,-5,-7)] ## c = contrast. Vi får vist vektor(x), men angiver at vi vil se vektor(x) UNDTAGEN nr. 3, 5, 7 i vektor(x)

# DATAFRAMES ####
data.frame("vektor med f.eks. navne", "matrix, du vil indsætte navne i")

colnames("datasæt") <- "navne på rækketitler" ## Indsæt navne på kolonner

# Logik ####
#
test 

## slet variable
rm()

## Få ordentlig sti til en kopieret Windows-lokation
readClipboard()

## Eksport af plot, du kigger på - her som svg
dev.copy(svg, file = "C:\\Users\\Jacob Venborg\\Google Drev\\Forskningsår\\Vagal Tone in Inflammatory Diseases\\STATA\\R-grafer\\Rapport\\Figur 1 - CVT + HR + CRP + MHAQ.svg", width = 10, height = 7)
dev.off()

## Reshaping
reshape(outcomes.Pirateplot,
        direction = "wide",
        v.names = outcomes.Pirateplot[],
        timevar = outcomes.Pirateplot$visit,
        idvar = outcomes.Pirateplot$subjectID)

## Korrelations test
cor.test(outcomes.Pirateplot$crp_edited, outcomes.Pirateplot$mhaq, method = "pearson")

## Scatterplots
library(ggplot2)
ggplot(outcomes.Pirateplot, aes(x = crp_edited, y = morning_stiffness, group = subjectID, color = subjectID)) +
  geom_point() +
  theme_bw() 

?grep()

## Hvad er en factor?!
# En variable, som består af 'levels'/niveauer. Kategoriske data. 

## Atttach
# Hvis jeg skal bruge det samme datasæt HELE tiden, og bliver træt af at skrive "data$...". Så kan man attache. Detach for at deaktivere funktionen.

## Re-shape/transponering
pivot_longer()
pivot_wider(names_from = data$Species, values_from = data$Petal.Length)

## TIDYVERSE ##
# Pipes
# %>% CTRL + SHIFT + M

## og = &, eller = |, 
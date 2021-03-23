**Data** (som forhhåbentligt er reproducérbart!)

``` {.r}
df.smoking <- data.frame(
  subject_id = as.integer(c(1, 2, 3, 4, 5, 6)),
  smoking_status = as.factor(c("current", "previous", "never", "previous", "current", "current")),
  smoking_type = as.factor(c("cigarettes", "cigarettes", NA, "pipe", "cheroots", "cigars")),
  smoking_type_extra = as.factor(c(NA, "cigars", NA, NA, NA, NA)),
  smoking_amount_cigarettes = c(10, 15, NA, NA, NA, NA),
  smoking_amount_cheroots = c(NA, NA, NA, NA, 5, NA),
  smoking_amount_cigars = c(NA, 1, NA, NA, NA, 2),
  smoking_amount_pipe = c(NA, NA, NA, 1, NA, NA),
  smoking_amount = c(10, 15, NA, 1, 5, 2), ## OBS: blot eksempel, ønsker at lave denne variabel.
  smoking_amount_extra = c(NA, 1, NA, NA, NA, NA)) ## OBS: blot eksempel, ønsker at lave denne variabel.
```

**Som det muligvis fremgår af ovenstående**, har jeg subjects, der har røget FLERE ting. I dette tilfælde subject 2, som har røget både cigaretter og cigarer. Mit slutmål er som skrevet at udregne total antal pakkeår. Antal pakkeår afhænger naturligvis af rygeform og mængde. Før jeg kommer dertil, ønsker jeg at lave en `smoking_amount` samt `smoking_amount_extra` variabel. Jeg ønsker at lave disse variable på en "smart" måde via conditions. Jeg tænker, at koden skal kunne noget ala: 1) Tage værdien i `smoking_type` for hver subject (f.eks. *cigarettes*) 2) Bruge denne værdi/string til at søge i de eksisterende kolonners navne (søger efter *smoking_amount_cigarettes*) 3) Finde den rette kolonnes navn og udtrække værdien herfra (finder variablen `smoking_amount_cigarettes`) 4) Slutteligt putte data fra kolonne i den nye variabel smoking_amount og smoking_amount_extra (udtrækker data fra `smoking_amount_cigarettes` til de subjects, hvor `smoking_type == cigarettes`)

**Og ønsker hermed disse resultat (findes allerede i dataeksemplet)**

``` {.r}
> df.smoking$smoking_amount
[1] 10 15 NA  1  5  2
> df.smoking$smoking_amount_extra
[1] NA  1 NA NA NA NA
```

Initielt har jeg lavet variablen `smoking_type` via `paste()` (eller det vil sige `dplyr::unite()` og `dplyr::separate()`) som virkede super! Koden kommer lige her hvis det har interesse (**du skipper altså bare**):

``` {.r}
## smoking_type ----
#  Cigarettes
df.smoking$cigarettes_type <- ifelse(
  df.smoking$smoking_status == "current"
  & !is.na(df.smoking$TOBACCO_howmany_cigaret_64_es)
  & df.smoking$TOBACCO_howmany_cigaret_64_es > 0,
  "cigarettes",
  ifelse(
    df.smoking$smoking_status == "previous"
    & !is.na(df.smoking$TOBACCO_previous_cigare_64_es)
    & df.smoking$TOBACCO_previous_cigare_64_es > "0",
    "cigarettes",
    NA)
  )

# Cheroots
df.smoking$cheroots_type <- ifelse(
  df.smoking$smoking_status == "current"
  & !is.na(df.smoking$TOBACCO_howmany_cerut)
  & df.smoking$TOBACCO_howmany_cerut > 0,
  "cheroots",
  ifelse(
    df.smoking$smoking_status == "previous"
    & !is.na(df.smoking$TOBACCO_previous_cerut)
    & df.smoking$TOBACCO_previous_cerut > 0,
    "cheroots",
    NA)
)

# Cigars
df.smoking$cigars_type <- ifelse(
  df.smoking$smoking_status == "current"
  & !is.na(df.smoking$TOBACCO_howmany_cigars)
  & df.smoking$TOBACCO_howmany_cigars > 0,
  "cigars",
  ifelse(
    df.smoking$smoking_status == "previous"
    & !is.na(df.smoking$TOBACCO_previous_cigars)
    & df.smoking$TOBACCO_previous_cigars > 0,
    "cigars",
    NA)
)

# Pipe
df.smoking$pipes_type <- ifelse(
  df.smoking$smoking_status == "current"
  & !is.na(df.smoking$TOBACCO_pipe_packs)
  & df.smoking$TOBACCO_pipe_packs > 0,
  "pipes",
  ifelse(
    df.smoking$smoking_status == "previous"
    & !is.na(df.smoking$TOBACCO_pipe_previous_p_64_ks)
    & df.smoking$TOBACCO_pipe_previous_p_64_ks > 0,
    "pipes",
    NA)
)

# Få colnames på visse variable TIDYVERSE
varlist.smokingtypes <- df.smoking %>%
  select(contains("s_type")) %>%
  colnames

## Sammenflet (collapse/unite) de forskellige typer
df.smoking <- df.smoking %>%
  unite("smoking_type",
        varlist.smokingtypes,
        sep = ", ",
        remove = FALSE,
        na.rm = TRUE) %>% 
  relocate(smoking_type, .after = smoking_stop) %>% 
  separate(smoking_type,
           c("smoking_type", "smoking_type_extra"),
           sep = ", ") %>% 
  mutate(smoking_type = if_else(
    smoking_status == "never",
    as.character(NA),
    smoking_type))
```

**Jeg tænker, det kunne være en form for løsning igen**. Men denne gang drejer det sig om tal og ikke unikke factors/characters, hvorfor det i mine øjne er risikabelt at `unite()` + `separate()` tallene. Jeg vil gerne vide, at de respektive tal tilhører den respektive `smoking_type` (håber min tankegang giver mening). Det hele skal for resten smides ind i en `ifelse()` funktion.

**I stedet har jeg indtil videre forsøgt** en kombination af `get()` og `paste()` med inspiration fra dette link:\
<https://stackoverflow.com/questions/34052645/r-return-column-using-get-and-paste>

``` {.r}
> get(paste0("smoking_amount_", df.smoking$smoking_type))
Error in get(paste0("smoking_amount_", df. smoking $smoking_type)) : 
  object 'smoking_amount_cigarettes' not found
```

Fejlen skyldes så vidt jeg forstår, at `get()` kun virker på dataframe-objekter, ikke på selve kolonner i en dataframe.

**Lidt med samme tankegang har jeg forsøgt:**

``` {.r}
> grep(paste0("smoking_amount_", df.smoking$smoking_type), df.smoking, value = TRUE)
named character(0)
Warning message:
In grep(paste0("smoking_amount_", df.smoking$smoking_type), df.smoking,  :
  argument 'pattern' has length > 1 and only the first element will be used
```

Denne fejl forstår jeg dog ikke. Altså som i jeg ikke ved, hvad jeg laver.

Jeg ved, at jeg kan gøre ovenstående manuelt med en lang funktion med nested `if_else()`/`ifelse()`, men min tanke var, at det bør kunne gøres smart.

Jeg tænker næsten heller ikke, det skal være noget `lapply()`. Men hvad ved jeg! Men jeg er dog næsten sikker på, at der må være en "nem" løsning, som jeg simpelthen bare ikke fatter at fremsøge, da jeg stadig har lidt svært med korrekt r terminologi.

Jeg fandt også dette spørgsmål, men forstår ikke løsningen:\
<https://stackoverflow.com/questions/28297540/match-row-value-with-column-name-and-extract-value-in-r>

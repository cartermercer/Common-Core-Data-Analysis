library(tidyverse)

race = read.csv("~/Box/DS 803 Final Project/ELSI Data/ELSI_2018_2019_race_ethnicity.csv", skip = 6, header = TRUE)
fiscal = read.csv("~/Box/DS 803 Final Project/ELSI Data/ELSI_2016_2017_fiscal.csv", skip = 6, header = TRUE)
districtDirectory = read.csv("~/Box/DS 803 Final Project/ELSI Data/ELSI_2018_2019_district_directory.csv", skip = 6, header = TRUE)

ELSI = inner_join(fiscal, race, by = "Agency.ID...NCES.Assigned..District..Latest.available.year")

#get rid of duplicate columnns from join
ELSI[,"Agency.Name.y"] = NULL
ELSI[,"State.Name..District..Latest.available.year.y"] = NULL

#renmae columns
ELSI_Rename = 
ELSI %>% 
  rename(
    AgencyName = Agency.Name.x,
    State = State.Name..District..Latest.available.year.x,
    FallMembership_16_17 = Fall.Membership..V33...District.Finance..2016.17,
    RevenueLocalSources_16_17 = Total.Revenue...Local.Sources..TLOCREV...District.Finance..2016.17,
    RevenueGeneral_16_17 = Total.General.Revenue..TOTALREV...District.Finance..2016.17,
    RevenueStateSources_16_17 = Total.Revenue...State.Sources..TSTREV...District.Finance..2016.17,
    RevenueFederalSources_16_17 = Total.Revenue...Federal.Sources..TFEDREV...District.Finance..2016.17,
    CurrentExpendituresSecEdu_16_17 = Total.Current.Expenditures...El.Sec.Education..TCURELSC...District.Finance..2016.17,
    CurrentExpenditures_16_17 = Total.Expenditures..TOTALEXP...District.Finance..2016.17,
    RevenuePerPupil_16_17 = Total.Revenue..TOTALREV..per.Pupil..V33...District.Finance..2016.17,
    RevenueLocalSourcesPerPupil_16_17 = Total.Revenue...Local.Sources..TLOCREV..per.Pupil..V33...District.Finance..2016.17,
    RevenueStateSourcesPerPupil_16_17 = Total.Revenue...State.Sources..TSTREV..per.Pupil..V33...District.Finance..2016.17,
    RevenueFederalSourcesPerPupil_16_17 = Total.Revenue...Federal.Sources..TFEDREV..per.Pupil..V33...District.Finance..2016.17,
    AgencyID = Agency.ID...NCES.Assigned..District..Latest.available.year,
    AgencyType_18_19 = Agency.Type..District..2018.19,
    StartOfYearStatus_18_19 = Start.of.Year.Status..District..2018.19,
    TotalStudentsAllGrades_18_19 = Total.Students.All.Grades..Excludes.AE...District..2018.19,
    AmerIndAlaskaNative_18_19 = American.Indian.Alaska.Native.Students..District..2018.19,
    Asian_AsianPacificIsl_18_19 = Asian.or.Asian.Pacific.Islander.Students..District..2018.19,
    Hispanic_18_19 = Hispanic.Students..District..2018.19,
    Black_18_19 = Black.Students..District..2018.19,
    White_18_19 = White.Students..District..2018.19,
    Hawaiian_PacificIsl_18_19 = Hawaiian.Nat..Pacific.Isl..Students..District..2018.19,
    TwoOrMoreRaces_18_19 = Two.or.More.Races.Students..District..2018.19
  )

ELSI_Rename = as.data.frame(ELSI_Rename)
glimpse(ELSI_Rename)
#make columns that are characters that should be numeric into numeric
chr_to_numIndex = c(3:13,17:24) #columns that need to be numeric
for (i in chr_to_numIndex) {
  ELSI_Rename[,i] = as.numeric(ELSI_Rename[,i])
}
ELSI_Rename = as_tibble(ELSI_Rename)
glimpse(ELSI_Rename)

#write.csv(ELSI_Rename, "~/Box/DS 803 Final Project/ELSI Data/ELSI_RaceEthnicity_Fiscal.csv")

ELSI = read.csv("~/Box/DS 803 Final Project/ELSI Data/ELSI_RaceEthnicity_Fiscal.csv",header = T)


districtDirectoryRename = 
  districtDirectory %>% 
  rename(
    AgencyID = Agency.ID...NCES.Assigned..District..Latest.available.year)

ELSI_dist = ELSI = inner_join(ELSI, districtDirectoryRename[ , c("AgencyID" ,"County.Name..District..2018.19", "Urban.centric.Locale..District..2018.19")] , by = "AgencyID")


ELSI_distRename = 
  ELSI_dist %>% 
  rename(
    CountyName_18_19 = County.Name..District..2018.19,
    UrbanCentricLocale_18_19 = Urban.centric.Locale..District..2018.19)

write.csv(ELSI_distRename, "~/Box/DS 803 Final Project/ELSI Data/CompleteELSI.csv")








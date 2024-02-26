cd "C:\Users\vickm\Documents\The Library\Air Pollution"
import delimited "air_pollution_olexiy_combined.csv",clear
rename month case_mon
rename year case_yr

save pollution.dta, replace

import delimited "final_merged_air_pollution_cases_compact.csv",clear


*-------------------------------------------------------------------------------

/* 
I. cleaning state names => correcting them so they match the state names in the 
shapefile used to create air pollustion datset. Please see the list in Excel file 
List_locations_Viknesh_15012024, tab Our locations
*/
replace state = "Andhra Pradesh" if state == "andhra pradesh"
replace state = "Arunachal Pradesh" if state == "arunachal pradesh"
replace state = "Assam" if state == "assam"
replace state = "West Bengal" if state == "bengal"
replace state = "Bihar" if state == "bihar"
replace state = "Chandigarh" if state == "chandigarh"
replace state = "Chhattisgarh" if state == "chhattisgarh"
replace state = "Daman and Diu" if state == "daman and diu"
replace state = "Goa" if state == "goa"
replace state = "Gujarat" if state == "gujarat"
replace state = "Haryana" if state == "haryana"
replace state = "Himachal Pradesh" if state == "himachal pradesh"
replace state = "Jammu and Kashmir" if state == "jammu & kashmir"
replace state = "Jammu and Kashmir" if state == "jammu and kashmir"
replace state = "Jharkhand" if state == "jharkhand"
replace state = "Karnataka" if state == "karnataka"
replace state = "Kerala" if state == "kerala"
replace state = "Madhya Pradesh" if state == "madhya pradesh"
replace state = "Maharashtra" if state == "maharashtra"
replace state = "Manipur" if state == "manipur"
replace state = "Meghalaya" if state == "meghalaya"
replace state = "Mizoram" if state == "mizoram"
replace state = "Delhi" if state == "new delhi"
replace state = "Orissa" if state == "odisha"
replace state = "Bihar" if state == "patna"
replace state = "Puducherry" if state == "puducherry"
replace state = "Punjab" if state == "punjab"
replace state = "Rajasthan" if state == "rajasthan"
replace state = "Tamil Nadu" if state == "tamil nadu"
replace state = "Andhra Pradesh" if state == "telangana"
replace state = "Tripura" if state == "tripura"
replace state = "Uttar Pradesh" if state == "uttar pradesh"
replace state = "Uttarakhand" if state == "uttarakhand"
replace state = "Uttarakhand" if state == "uttaranchal"
replace state = "West Bengal" if state == "west bengal"

*-------------------------------------------------------------------------------

/* 
II. cleaning district names  => correcting them so they match the district names in the 
shapefile used to create air pollustion datset. the justification for corrections presented here can be
seen in more details in Excel file List_locations_Viknesh_15012024, tab Cleaning districts
*/
replace district = "Chennai" if district == "chennai"
replace district = "Devnagere" if district == "devnagere"
replace district = "Dharamshala" if district == "dharamshala"
replace district = "Gauhati" if district == "gauhati"
replace district = "Godhra" if district == "godhra"
replace district = "Guwahati" if district == "guwahati"
replace district = "Moh" if district == "moh"
replace district = "N.aa" if district == "n.aa"
replace district = "Nellore" if district == "nellore"
replace district = "Noamundi" if district == "noamundi"
replace district = "Sihora" if district == "sihora"
replace district = "Ganganagar" if district == "sri ganganagar"
replace district = "Ganganagar" if district == "sriganganagar"
replace district = "Tumkur" if district == "tumkur"

replace district = "Ahmadabad" if district == "Ahmedabad"
replace district = "Ahmadabad" if district == "Ahmedabad (Rural)"
replace district = "Allahabad" if district == "Allahabad District"
replace district = "Vishakhapatnam" if district == "Anakapalli"
replace district = "Anuppur" if district == "Annuppur"
replace district = "Sabar Kantha" if district == "Aravalli"
replace district = "Ashoknagar" if district == "Ashok Nagar"
replace district = "Adilabad" if district == "Asifabad"
replace district = "Belgaum" if district == "BELAGAVI"
replace district = "Bangalore" if district == "BENGALURU"
replace district = "Mumbai city" if district == "BOMBAY"
replace district = "Bolangir" if district == "Balangir"
replace district = "Baleshwar" if district == "Balasore"
replace district = "Bellary" if district == "Ballari"
replace district = "Raipur" if district == "Baloda Bazar"
replace district = "Raipur" if district == "Baloda Bazar - Bhatapara"
replace district = "Banas Kantha" if district == "Banaskantha"
replace district = "Bangalore Rural" if district == "Bangalore Rural District"
replace district = "Bangalore Urban" if district == "Bangalore urban"
replace district = "Bara Banki" if district == "Barabanki"
replace district = "Baramula" if district == "Baramulla"
replace district = "Baragarh" if district == "Bargarh"
replace district = "Bellary" if district == "Bellari"
replace district = "Bangalore" if district == "Bengaluru"
replace district = "Bangalore Urban" if district == "Bengaluru Urban"
replace district = "Bhopal" if district == "Bhopal District"
replace district = "Khordha" if district == "Bhubaneshwar"
replace district = "Khordha" if district == "Bhubeneshwar"
replace district = "Mumbai city" if district == "Bombay"
replace district = "Mumbai Suburban" if district == "Bombay Suburban District"
replace district = "Badaun" if district == "Budaun"
replace district = "South 24 Parganas" if district == "Budge Budge"
replace district = "Bulandshahr" if district == "Bulandshahar"
replace district = "Kolkata" if district == "Calcutta"
replace district = "Delhi" if district == "Central Delhi"
replace district = "Delhi" if district == "Central District"
replace district = "Chamrajnagar" if district == "Chamarajanagar"
replace district = "Chamrajnagar" if district == "Chamarajanagara"
replace district = "Chamrajnagar" if district == "Chamarajnagar"
replace district = "Janjgir-Champa" if district == "Champa"
replace district = "Kancheepuram" if district == "Chengalpattu"
replace district = "Kancheepuram" if district == "Chengalpet"
replace district = "Chennai" if district == "Chennai District"
replace district = "Vadodara" if district == "Chhota Udepur"
replace district = "Vadodara" if district == "Chhota-Udepur"
replace district = "Vadodara" if district == "Chhotaudepur"
replace district = "Chikmagalur" if district == "Chickmagalur"
replace district = "Kolar" if district == "Chikkaballapura"
replace district = "Chikmagalur" if district == "Chikkamagalur"
replace district = "Chikmagalur" if district == "Chikkamagaluru"
replace district = "Chittaurgarh" if district == "Chittorgarh"
replace district = "Coimbatore" if district == "Coimbatore District"
replace district = "Cuddalore" if district == "Cuddalore District"
replace district = "Dakshin Kannad" if district == "Dakshina Kannada"
replace district = "Davanagere" if district == "Davangere"
replace district = "Dehra Dun" if district == "Dehradun"
replace district = "Dehra Dun" if district == "Dehradun District"
replace district = "Davanagere" if district == "Devnagere"
replace district = "Dhaulpur" if district == "Dholpur"
replace district = "Godda" if district == "Dighi"
replace district = "Dindigul" if district == "Dindigul District"
replace district = "Purba Champaran" if district == "East Champaran"
replace district = "Delhi" if district == "East Delhi"
replace district = "Delhi" if district == "East Delhi District"
replace district = "East Godavari" if district == "East Godavari District"
replace district = "Purba Singhbhum" if district == "East Singhbhum"
replace district = "Erode" if district == "Erode District"
replace district = "Firozpur" if district == "Fazilka"
replace district = "Firozabad" if district == "Ferozabad"
replace district = "Firozpur" if district == "Ferozepore"
replace district = "Garhchiroli" if district == "Gadchiroli"
replace district = "Gandhinagar" if district == "Gandhi Nagar"
replace district = "Raipur" if district == "Gariyaband"
replace district = "Kamrup Metropolitan" if district == "Gauhati"
replace district = "Gautam Buddha Nagar" if district == "Gautam Budh Nagar"
replace district = "Junagadh" if district == "Gir Somnath"
replace district = "Junagadh" if district == "Gir-Somnath"
replace district = "Panch Mahals" if district == "Godhra"
replace district = "Gurgaon" if district == "Gurugram"
replace district = "Kamrup Metropolitan" if district == "Guwahati"
replace district = "Gwalior" if district == "Gwalior District"
replace district = "Ghaziabad" if district == "Hapur"
replace district = "Aurangabad" if district == "Haspura"
replace district = "Hazaribag" if district == "Hazaribagh"
replace district = "Hugli" if district == "Hooghly"
replace district = "Haora" if district == "Howrah"
replace district = "Indore" if district == "Indore District"
replace district = "Papum Pare" if district == "Itanagar"
replace district = "Jamui" if district == "JAMUI"
replace district = "Jaipur" if district == "Jaipur District"
replace district = "Jalor" if district == "Jalore"
replace district = "Jhunjhunun" if district == "Jhunjhunu"
replace district = "Jodhpur" if district == "Jodhpur District"
replace district = "Jalandhar" if district == "Jullundur"
replace district = "Kabirdham" if district == "Kabeerdham"
replace district = "Cuddapah" if district == "Kadapa District"
replace district = "Gulbarga" if district == "Kalaburagi"
replace district = "Kancheepuram" if district == "Kancheepuram District"
replace district = "Kancheepuram" if district == "Kanchipuram"
replace district = "Kanpur Nagar" if district == "Kanpur"
replace district = "Kanpur Nagar" if district == "Kanpur Nagar district"
replace district = "Kanniyakumari" if district == "Kanyakumari"
replace district = "Kanniyakumari" if district == "Kanyakumari District"
replace district = "Rohtas" if district == "Kargahar"
replace district = "Karur" if district == "Karur District"
replace district = "Kasaragod" if district == "Kasargod"
replace district = "Keonjhar" if district == "Kendujhar"
replace district = "Keonjhar" if district == "Kendujhar (Keonjhar)"
replace district = "Indore" if district == "Khajrana"
replace district = "East Nimar" if district == "Khandwa"
replace district = "West Midnapore" if district == "Kharagpur"
replace district = "West Nimar" if district == "Khargone"
replace district = "West Nimar" if district == "Khargone (West Nimar)"
replace district = "Lakhimpur Kheri" if district == "Kheri"
replace district = "Lakhimpur Kheri" if district == "Khiri"
replace district = "Ranchi" if district == "Khunti"
replace district = "Khordha" if district == "Khurda"
replace district = "Ernakulam" if district == "Kochi"
replace district = "Dindigul" if district == "Kodaikanal"
replace district = "Kolkata" if district == "Kolkata District"
replace district = "Koriya" if district == "Korea"
replace district = "Kozhikode" if district == "Kozhikkode"
replace district = "Dharmapuri" if district == "Krishnagiri"
replace district = "Kushinagar" if district == "Kushi Nagar"
replace district = "Kachchh" if district == "Kutch"
replace district = "Madurai" if district == "Madurai District"
replace district = "Mandya" if district == "Mandya District"
replace district = "Palakkad" if district == "Mannarkkad"
replace district = "Alappuzha" if district == "Mavelikkara"
replace district = "Nagapattinam" if district == "Mayiladuthurai"
replace district = "Mahesana" if district == "Mehsana"
replace district = "Salem" if district == "Mettur"
replace district = "Rajkot" if district == "Morbi"
replace district = "Mumbai city" if district == "Mumbai"
replace district = "Mumbai city" if district == "Mumbai City"
replace district = "Mumbai Suburban" if district == "Mumbai Suburban District"
replace district = "Mumbai Suburban" if district == "Mumbai suburban"
replace district = "Bilaspur" if district == "Mungeli"
replace district = "Muzaffarnagar" if district == "Muzzafar Nagar"
replace district = "Mysore" if district == "Mysuru"
replace district = "Nagapattinam" if district == "Nagapattinam District"
replace district = "Naini Tal" if district == "Nainital"
replace district = "Nalgonda" if district == "Nalgonda District"
replace district = "Namakkal" if district == "Namakkal District"
replace district = "Nawan Shehar" if district == "Nawanshahr"
replace district = "Nellore" if district == "Nellore District"
replace district = "Delhi" if district == "New Delhi"
replace district = "Pashchim Singhbhum" if district == "Noamundi"
replace district = "Gautam Buddha Nagar" if district == "Noida"
replace district = "Vellore" if district == "North Arcot"
replace district = "Delhi" if district == "North Delhi"
replace district = "Raisen" if district == "Obedullagan"
replace district = "Patna" if district == "PATNA"
replace district = "Thane" if district == "Palghar"
replace district = "Palakkad" if district == "Palghat"
replace district = "Pali" if district == "Pali Marwar"
replace district = "Panch Mahals" if district == "Panchmahal"
replace district = "Barddhaman" if district == "Paschim Bardhaman"
replace district = "West Midnapore" if district == "Paschim Medinipur"
replace district = "Pattanamtitta" if district == "Pathanamthitta"
replace district = "Gurdaspur" if district == "Pathankot"
replace district = "Patiala" if district == "Patiala District"
replace district = "Pauri Garhwal" if district == "Pauri"
replace district = "Kozhikode" if district == "Payyoli"
replace district = "Puducherry" if district == "Pondicherry"
replace district = "Allahabad" if district == "Prayagraj"
replace district = "Pudukkottai" if district == "Pudukottai"
replace district = "Pudukkottai" if district == "Pudukottai District"
replace district = "Pune" if district == "Pune (Gramin)"
replace district = "Pune" if district == "Pune District"
replace district = "Barddhaman" if district == "Purba Bardhaman district"
replace district = "Rae Bareli" if district == "Raebareli"
replace district = "Raigarh" if district == "Raigad"
replace district = "Raigarh" if district == "Raigad District"
replace district = "Bangalore Rural" if district == "Ramanagara"
replace district = "Hazaribag" if district == "Ramgarh"
replace district = "Rangareddi" if district == "Ranga Reddy"
replace district = "Rangareddi" if district == "Ranga Reddy District"
replace district = "Ri-Bhoi" if district == "Ri Bhoi District"
replace district = "Rupnagar" if district == "Ropar"
replace district = "Samastipur" if district == "SAMASTIPUR"
replace district = "Nellore" if district == "SPSR Nellore District"
replace district = "Sabar Kantha" if district == "Sabarkantha"
replace district = "Medak" if district == "Sangareddy"
replace district = "Sawai Madhopur" if district == "Sawaimadhopur"
replace district = "Seoni" if district == "Seoni District"
replace district = "Saraikela Kharsawan" if district == "Seraikela Kharsawan"
replace district = "Delhi" if district == "Shahdara"
replace district = "Delhi" if district == "Shahdara District"
replace district = "Nawan Shehar" if district == "Shaheed Bhagat Singh Nagar"
replace district = "Sidhi" if district == "Sidhi District"
replace district = "Jabalpur" if district == "Sihora"
replace district = "Sidhi" if district == "Singrauli"
replace district = "Sidhi" if district == "Singrouli"
replace district = "Sivaganga" if district == "Sivagangai"
replace district = "Sivaganga" if district == "Sivagangai District"
replace district = "Andaman Islands" if district == "South Andaman"
replace district = "Delhi" if district == "South Delhi"
replace district = "Delhi" if district == "South East District"
replace district = "Delhi" if district == "South West Delhi"
replace district = "Delhi" if district == "South West District"
replace district = "Ganganagar" if district == "Sri Ganganagar"
replace district = "Ganganagar" if district == "Sriganganagar"
replace district = "Ganganagar" if district == "Srigangangar"
replace district = "Surat" if district == "Surat Rural"
replace district = "Angul" if district == "Talcher"
replace district = "Surat" if district == "Tapi"
replace district = "Nilgiris" if district == "The Nilgiris"
replace district = "Theni" if district == "Theni District"
replace district = "Thiruvallur" if district == "Thiruvallur District"
replace district = "Tiruvannamalai" if district == "Thiruvannamalai"
replace district = "Thoothukudi" if district == "Thoothukudi District"
replace district = "Thrissur" if district == "Thrissur District"
replace district = "Tiruchchirappalli" if district == "Tiruchirappalli"
replace district = "Tirunelveli Kattabo" if district == "Tirunelveli"
replace district = "Tirunelveli Kattabo" if district == "Tirunelveli District"
replace district = "Thiruvallur" if district == "Tiruvallur"
replace district = "Thiruvallur" if district == "Tiruvallur District"
replace district = "Tiruvannamalai" if district == "Tiruvannamalai District"
replace district = "Thiruvarur" if district == "Tiruvarur"
replace district = "Tiruchchirappalli" if district == "Tiruverumbur"
replace district = "Tiruchchirappalli" if district == "Trichinopoly"
replace district = "Tiruchchirappalli" if district == "Trichirappalli"
replace district = "Thrissur" if district == "Trichur"
replace district = "Tiruchchirappalli" if district == "Trichy"
replace district = "Thoothukudi" if district == "Tuticorin"
replace district = "Udaipur" if district == "Udaipur District"
replace district = "Umaria" if district == "Umariya"
replace district = "Uttar Kannand" if district == "Uttara Kannada"
replace district = "Vellore" if district == "Vellore District"
replace district = "Villupuram" if district == "Villupuram District"
replace district = "Villupuram" if district == "Viluppuram"
replace district = "Vishakhapatnam" if district == "Visakhapatnam"
replace district = "Warangal" if district == "Warangal Rural"
replace district = "Pashchim Champaran" if district == "West Champaran"
replace district = "Delhi" if district == "West Delhi"
replace district = "Pashchim Singhbhum" if district == "West Singhbhum"
replace district = "Cuddapah" if district == "Y.S.R. Kadapa District"
replace district = "Cuddapah" if district == "YSR District"
replace district = "Gulbarga" if district == "Yadgir"

foreach i in state district {
	replace `i' = "" if `i'=="NA"
	replace `i' = strlower(`i')
}

foreach i of varlist case_date-court_3 act_1-title pcb_action-social_impact_water {
	replace `i' = "" if `i'=="NA"
}
destring case_yr case_mon, force replace
destring in_air_corpus-green_verdict_human green_verdict impact_coded_water social_impact_water, force replace

capture drop human_case chatgpt_case common_case
gen human_case = 0
replace human_case = 1 if !mi(green_verdict_human)
gen chatgpt_case = 0
replace chatgpt_case = 1 if !mi(green_verdict_gpt)
gen common_case = 0
replace common_case = 1 if !mi(green_verdict_gpt) & !mi(green_verdict_human)

gen no_of_judges = .
replace no_of_judges = 3 if !mi(judge_1) & !mi(judge_2) & !mi(judge_3)
replace no_of_judges = 2 if !mi(judge_1) & !mi(judge_2) & mi(judge_3)
replace no_of_judges = 1 if !mi(judge_1) & mi(judge_2) & mi(judge_3)

capture drop human_case chatgpt_case common_case
gen human_case = 0
replace human_case = 1 if !mi(green_verdict_human)
gen chatgpt_case = 0
replace chatgpt_case = 1 if !mi(green_verdict_gpt)
gen common_case = 0
replace common_case = 1 if !mi(green_verdict_gpt) & !mi(green_verdict_human)
gen mismatch = .
replace mismatch = 0 if common_case == 1 & (green_verdict_gpt == green_verdict_human)
replace mismatch = 1 if common_case == 1 & (green_verdict_gpt != green_verdict_human)

gen erelevant =.
replace erelevant = 1 if env_relevance > 50
replace erelevant = 0 if env_relevance <= 50

label variable pcb_action "Did the judge recommend action from the pollution control board"
label variable follow "Did the judge follow the law or did they tweak interpretation?"
label variable regulator_action "Did the judge compel action from regulators/ploiticians?"
label variable erelevant "Is the case relevant to environment y/n"

save case_data.dta,replace

/**************************************************************************************
****************** creating a template file for pollution data ************************
***************************************************************************************/

use case_data,clear
collapse (count) kanoon_id, by(state district)
drop kanoon_id
save case_list.dta,replace

use pollution,clear
collapse (count) case_yr, by(state district)
drop case_yr
joinby state district using case_list, unmatched(both) update
rename _merge _merge_district
lab var _merge_district "master = pollution list ; using = cases list"
save full_list.dta,replace

use pollution,clear
collapse (count) bc, by(case_yr case_mon)
drop bc
save time_list.dta,replace

use full_list,clear
cross using time_list
sort state district case_yr case_mon
joinby state district case_yr case_mon using pollution, unmatched(both)
rename _merge _merge_template
lab var _merge_template "master = full list; using = pollution list"
save template.dta,replace

/*****************************************************************
****************** Merging Case Data ************************
*****************************************************************/
use template.dta, clear

joinby state district case_yr case_mon using case_data, unmatched(both)
rename _merge _merge_case
lab var _merge_case "master = pollution template; using = case_data"
ta _merge_case

/*****************************************************************
****************** Identifying junk cases ************************
*****************************************************************/

gen junk_1 = .
replace junk_1 = 0 if !mi(word_count_bin)
replace junk_1 = 1 if word_count_bin == "0 to 300"

capture drop junk_hat1
reghdfe junk_1 green_verdict length_of_case num_titles_cited, a(state district case_yr) cluster(district)
predict junk_hat1, xb

gen predicted_junk1 = 0
replace predicted_junk1 = 1 if junk_hat1 > 0.5

capture drop junk_hat2
reghdfe junk_1 green_verdict in_air_corpus-env_relevance length_of_case num_titles_cited, a(state district case_yr) cluster(district)
predict junk_hat2, xb

gen predicted_junk2 = 0
replace predicted_junk2 = 1 if junk_hat2 > 0.5

lab var junk_1 "identified by word count <= 300"
lab var predicted_junk1 "predicted using junk_1 variable"
lab var predicted_junk2 "predicted using junk_1 variable includes chatgpt outcomes as predictors"
save master_dataset_v1.dta,replace

/*******************************************************************************
****************** Extracting dataset for ChatGPT paper ************************
*******************************************************************************/

keep if _merge_case != 1
save truncated_data_for_paper1.dta,replace


/*****************************************************************
****************** Air Pollution Analysis ************************
*****************************************************************/
use master_dataset_v1,clear
global gpt_outcomes "pcb_action-env_relevance"

eststo clear
foreach yvar in so2 pm18 {
	eststo: reghdfe `yvar' green_verdict, a(state district case_yr) cluster(district)
	eststo: reghdfe `yvar' green_verdict if predicted_junk2 == 0, a(state district case_yr) cluster(district)
	eststo: reghdfe `yvar' green_verdict $gpt_outcomes , a(state district case_yr) cluster(district)
	eststo: reghdfe `yvar' green_verdict $gpt_outcomes if predicted_junk2 == 0, a(state district case_yr) cluster(district)
	eststo: reghdfe `yvar' green_verdict $gpt_outcomes if junk_1 == 0, a(state district case_yr) cluster(district)

}

esttab using "pollution_regressions_first_pass.csv", ar2 se nogaps nobaselevel noconstant replace


eststo clear
estpost su
esttab using "summary.csv", ar2 se nogaps nobaselevel noconstant replace cells("count min max mean sd")


/***********************************************************************
****************** Summary findings for Paper 1 ************************
***********************************************************************/

use truncated_data_for_paper1, clear

count if human_case == 1 
count if human_case == 1 & green_verdict_human == 1
total no_of_judges if human_case == 1
mean no_of_judges if human_case == 1
mean length_of_case if human_case == 1
trimmean length_of_case if human_case == 1,percent(0(5)50)
su length_of_case if human_case == 1
su num_titles_cited if human_case == 1
total junk_1 if human_case == 1
total predicted_junk2 if human_case == 1
count if env_relevance > 50 & human_case == 1
count if env_relevance > 50 & human_case == 1 & green_verdict_human == 1


count if human_case == 1 & water_cases == 1
count if human_case == 1 & water_cases == 1 & green_verdict_human == 1
total no_of_judges if human_case == 1 & water_cases == 1
mean no_of_judges if human_case == 1 & water_cases == 1
mean length_of_case if human_case == 1 & water_cases == 1
trimmean length_of_case if human_case == 1 & water_cases == 1,percent(0(5)50)
su length_of_case if human_case == 1 & water_cases == 1
su num_titles_cited if human_case == 1 & water_cases == 1
total junk_1 if human_case == 1 & water_cases == 1
total predicted_junk2 if human_case == 1 & water_cases == 1
count if env_relevance > 50 & human_case == 1 & water_cases == 1
count if env_relevance > 50 & human_case == 1 & water_cases == 1 & green_verdict_human == 1

count if human_case == 1 & water_cases == 0
count if human_case == 1 & water_cases == 0 & green_verdict_human == 1
total no_of_judges if human_case == 1 & water_cases == 0
mean no_of_judges if human_case == 1 & water_cases == 0
mean length_of_case if human_case == 1 & water_cases == 0
trimmean length_of_case if human_case == 1 & water_cases == 0,percent(0(5)50)
su length_of_case if human_case == 1 & water_cases == 0
su num_titles_cited if human_case == 1 & water_cases == 0
total junk_1 if human_case == 1 & water_cases == 0
total predicted_junk2 if human_case == 1 & water_cases == 0
count if env_relevance > 50 & human_case == 1 & water_cases == 0
count if env_relevance > 50 & human_case == 1 & water_cases == 0 & green_verdict_human == 1


eststo clear
estpost ta state if human_case == 1,sort
esttab using "tabsort_human1.csv", replace nogaps cells("b pct")

eststo clear
estpost ta state if human_case == 1 & green_verdict_human == 1,sort
esttab using "tabsort_human2.csv", replace nogaps cells("b pct")


count if chatgpt_case == 1 //1910
count if chatgpt_case == 1 & green_verdict_gpt == 1 //481
total no_of_judges if chatgpt_case == 1
mean no_of_judges if chatgpt_case == 1
mean length_of_case if chatgpt_case == 1
trimmean length_of_case if chatgpt_case == 1,percent(0(5)50)
su length_of_case if chatgpt_case == 1
su num_titles_cited if chatgpt_case == 1
total junk_1 if chatgpt_case == 1
total predicted_junk2 if chatgpt_case == 1
count if env_relevance > 50 & chatgpt_case == 1
count if env_relevance > 50 & chatgpt_case == 1 & green_verdict_gpt == 1


count if chatgpt_case == 1 & water_cases == 1
count if chatgpt_case == 1 & water_cases == 1 & green_verdict_gpt == 1
total no_of_judges if chatgpt_case == 1 & water_cases == 1
mean no_of_judges if chatgpt_case == 1 & water_cases == 1
mean length_of_case if chatgpt_case == 1 & water_cases == 1
trimmean length_of_case if chatgpt_case == 1 & water_cases == 1,percent(0(5)50)
su length_of_case if chatgpt_case == 1 & water_cases == 1
su num_titles_cited if chatgpt_case == 1 & water_cases == 1
total junk_1 if chatgpt_case == 1 & water_cases == 1
total predicted_junk2 if chatgpt_case == 1 & water_cases == 1
count if env_relevance > 50 & chatgpt_case == 1 & water_cases == 1
count if env_relevance > 50 & chatgpt_case == 1 & water_cases == 1 & green_verdict_gpt == 1

count if chatgpt_case == 1 & water_cases == 0
count if chatgpt_case == 1 & water_cases == 0 & green_verdict_gpt == 1
total no_of_judges if chatgpt_case == 1 & water_cases == 0
mean no_of_judges if chatgpt_case == 1 & water_cases == 0
mean length_of_case if chatgpt_case == 1 & water_cases == 0
trimmean length_of_case if chatgpt_case == 1 & water_cases == 0,percent(0(5)50)
su length_of_case if chatgpt_case == 1 & water_cases == 0
su num_titles_cited if chatgpt_case == 1 & water_cases == 0
total junk_1 if chatgpt_case == 1 & water_cases == 0
total predicted_junk2 if chatgpt_case == 1 & water_cases == 0
count if env_relevance > 50 & chatgpt_case == 1 & water_cases == 0
count if env_relevance > 50 & chatgpt_case == 1 & water_cases == 0 & green_verdict_gpt == 1

eststo clear
estpost ta state if chatgpt_case == 1,sort
esttab using "tabsort_gpt1.csv", replace nogaps cells("b pct")

eststo clear
estpost ta state if chatgpt_case == 1 & green_verdict_gpt == 1,sort
esttab using "tabsort_gpt2.csv", replace nogaps cells("b pct")


count if common_case == 1 
count if common_case == 1 & green_verdict_gpt == 1 
count if common_case == 1 & green_verdict_human == 1 
total no_of_judges if common_case == 1
mean no_of_judges if common_case == 1
mean length_of_case if common_case == 1
trimmean length_of_case if common_case == 1,percent(0(5)50)
su length_of_case if common_case == 1
su num_titles_cited if common_case == 1
total junk_1 if common_case == 1
total predicted_junk2 if common_case == 1
count if env_relevance > 50 & common_case == 1
count if env_relevance > 50 & common_case == 1 & green_verdict_gpt == 1
count if env_relevance > 50 & common_case == 1 & green_verdict_human == 1

count if common_case == 1 & water_cases == 1
count if common_case == 1 & water_cases == 1 & green_verdict_gpt == 1
count if common_case == 1 & water_cases == 1 & green_verdict_human == 1
total no_of_judges if common_case == 1 & water_cases == 1
mean no_of_judges if common_case == 1 & water_cases == 1
mean length_of_case if common_case == 1 & water_cases == 1
trimmean length_of_case if common_case == 1 & water_cases == 1,percent(0(5)50)
su length_of_case if common_case == 1 & water_cases == 1
su num_titles_cited if common_case == 1 & water_cases == 1
total junk_1 if common_case == 1 & water_cases == 1
total predicted_junk2 if common_case == 1 & water_cases == 1
count if env_relevance > 50 & common_case == 1 & water_cases == 1
count if env_relevance > 50 & common_case == 1 & water_cases == 1 & green_verdict_gpt == 1
count if env_relevance > 50 & common_case == 1 & water_cases == 1 & green_verdict_human == 1



count if common_case == 1 & water_cases == 0
count if common_case == 1 & water_cases == 0 & green_verdict_gpt == 1
count if common_case == 1 & water_cases == 0 & green_verdict_human == 1
total no_of_judges if common_case == 1 & water_cases == 0
mean no_of_judges if common_case == 1 & water_cases == 0
mean length_of_case if common_case == 1 & water_cases == 0
trimmean length_of_case if common_case == 1 & water_cases == 0,percent(0(5)50)
su length_of_case if common_case == 1 & water_cases == 0
su num_titles_cited if common_case == 1 & water_cases == 0
total junk_1 if common_case == 1 & water_cases == 0
total predicted_junk2 if common_case == 1 & water_cases == 0
count if env_relevance > 50 & common_case == 1 & water_cases == 0
count if env_relevance > 50 & common_case == 1 & water_cases == 0 & green_verdict_gpt == 1
count if env_relevance > 50 & common_case == 1 & water_cases == 0 & green_verdict_human == 1
count if (env_relevance > 50 | junk_1 == 1) & common_case == 1 & water_cases == 0

eststo clear
estpost ta state if common_case == 1,sort
esttab using "tabsort_common1.csv", replace nogaps cells("b pct")

eststo clear
estpost ta state if common_case == 1 & green_verdict_human == 1,sort
esttab using "tabsort_common2.csv", replace nogaps cells("b pct")

eststo clear
estpost ta state if common_case == 1 & green_verdict_gpt == 1,sort
esttab using "tabsort_common3.csv", replace nogaps cells("b pct")

/***********************************************************************
****************** Summary findings t-tests ************************
***********************************************************************/

ttest no_of_judges, by(human_case)
ttest no_of_judges, by(chatgpt_case)

ttest num_titles_cited, by(human_case)
ttest num_titles_cited, by(chatgpt_case)

ttest length_of_case, by(human_case)
ttest length_of_case, by(chatgpt_case)


/***********************************************************************
****************** Regressions ************************
***********************************************************************/
use truncated_data_for_paper1, clear


eststo clear
eststo: reghdfe green_verdict_human length_of_case num_titles_cited no_of_judges water_cases, a(state district case_yr) cluster(district)
estadd local sample "full"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict_human length_of_case num_titles_cited no_of_judges water_cases if junk_1!=1, a(state district case_yr) cluster(district)
estadd local sample "drop under 300"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict_human length_of_case num_titles_cited no_of_judges water_cases if erelevant==1, a(state district case_yr) cluster(district)
estadd local sample "e-relevance"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict_human length_of_case num_titles_cited no_of_judges water_cases if junk_1!=1 | erelevant == 1, a(state district case_yr) cluster(district)
estadd local sample "both"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"


esttab using "regression1_human_cases.csv",ar2 se nogaps nobaselevels noconstant replace s(sample state dist year obs r2a, label("Sample" "State FE" "District FE" "Case Year FE" " N" "Adj. R-squared"))

eststo clear
eststo: reghdfe green_verdict_gpt length_of_case num_titles_cited no_of_judges water_cases, a(state district case_yr) cluster(district)
estadd local sample "full"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict_gpt length_of_case num_titles_cited no_of_judges water_cases if junk_1!=1, a(state district case_yr) cluster(district)
estadd local sample "drop under 300"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict_gpt length_of_case num_titles_cited no_of_judges water_cases if erelevant==1, a(state district case_yr) cluster(district)
estadd local sample "e-relevance"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict_gpt length_of_case num_titles_cited no_of_judges water_cases if junk_1!=1 | erelevant == 1, a(state district case_yr) cluster(district)
estadd local sample "both"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

esttab using "regression1_chatgpt_cases.csv",ar2 se nogaps nobaselevels noconstant replace s(sample state dist year obs r2a, label("Sample" "State FE" "District FE" "Case Year FE" " N" "Adj. R-squared"))

eststo clear
eststo: reghdfe green_verdict length_of_case num_titles_cited no_of_judges water_cases if common_case ==1, a(state district case_yr) cluster(district)
estadd local sample "full"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict length_of_case num_titles_cited no_of_judges water_cases if common_case ==1 & junk_1 !=1, a(state district case_yr) cluster(district)
estadd local sample "drop under 300"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict length_of_case num_titles_cited no_of_judges water_cases if common_case ==1 & erelevant==1, a(state district case_yr) cluster(district)
estadd local sample "e-relevance"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

eststo: reghdfe green_verdict length_of_case num_titles_cited no_of_judges water_cases if common_case ==1 & (junk_1!=1 | erelevant == 1), a(state district case_yr) cluster(district)
estadd local sample "both"
estadd scalar obs =  e(N)
estadd scalar r2a = e(r2_a)
estadd local state "yes"
estadd local dist "yes"
estadd local year "yes"

esttab using "regression1_common_cases.csv",ar2 se nogaps nobaselevels noconstant replace s(sample state dist year obs r2a, label("Sample" "State FE" "District FE" "Case Year FE" " N" "Adj. R-squared"))

************************************************************************************************
/******************************* Mismatch between human and chatgpt green orders ***************
************************************************************************************************/
egen actid_1 = group(act_1)


eststo clear
eststo: reghdfe mismatch length_of_case num_titles_cited no_of_judges water_cases pcb_action env_relevance regulator_action follow, a(state district case_yr) cluster(district)
eststo: reghdfe mismatch length_of_case num_titles_cited no_of_judges water_cases pcb_action env_relevance regulator_action follow i.actid_1, a(state district case_yr) cluster(district)
eststo: reghdfe mismatch length_of_case num_titles_cited no_of_judges water_cases pcb_action env_relevance regulator_action follow green_verdict_gpt, a(state district case_yr) cluster(district)
eststo: reghdfe mismatch length_of_case num_titles_cited no_of_judges water_cases pcb_action env_relevance regulator_action follow green_verdict_gpt i.actid_1, a(state district case_yr) cluster(district)

esttab using "regression2_mismatch.csv",ar2 se nogaps nobaselevels noconstant replace

reghdfe overlap_mismatch num_titles_cited length_of_case i.pcb_action i.follow i.regulator_action env_relevance no_of_judges i.actid_1 green_verdict_gpt, a(state district i.case_yr) cluster(district)
predict yhat_mismatch, xb
# Below is the URL endpoint for getting all data for Eng & Wales, 
# all ages, all ethnicities and no religion specified.
# https://www.nomisweb.co.uk/api/v01/dataset/
# NM_657_1.data.json
# ?date=latest
# &c_relpuk11=0
# &c_age=1...21
# &c_sex=1,2
# &geography=K04000001

# Data set - NM_***_*.data.json
# NM_657_1 - DC2107EW - Religion by sex by age

# Age - c_age
# c_age=1...21 - All ages

# Religion codes - c_relpuk11
# Christians - 1
# Muslims - 5
# Buddhists - 2
# Hindus - 3
# Jewish - 4
# Sikh - 6
# Other - 7
# No religion - 8
# Not stated - 9

# Ethnicity codes - c_ethpuk11
# White - 1
# Mixed - 6
# Asian - 11
# Black - 17

# Geography codes (regions) - geography
# United Kingdom - 2092957697 - K02000001
# Great Britain - 2092957698 - K03000001
# England - 2092957699 - E92000001
# Wales - 2092957700 - W92000004
# Scotland - 2092957701 - S92000003
# Northern Ireland - 2092957702 - N92000002
# England and Wales - 2092957703 - K04000001

# Geography codes (districts) - geography
# See json/geography/districts.json
# To surface this in a module, try require('json/geography/districts.json')


# Geography codes (regions)
# North East - 2013265921
# North West - 2013265922
# Yorkshire and The Humber - 2013265923
# East Midlands - 2013265924
# West Midlands - 2013265925
# East - 2013265926
# London - 2013265927
# South East - 2013265928
# South West - 2013265929
# Wales - 2013265930

# List of all available countries (type 499) for dataset 657:
# http://www.nomisweb.co.uk/api/v01/dataset/NM_657_1/geography/TYPE499.def.sdmx.json

# List of all available regions (type 480) for dataset 657:
# http://www.nomisweb.co.uk/api/v01/dataset/NM_657_1/geography/TYPE480.def.sdmx.json

# List of all available districts (type 464) for dataset 657:
# http://www.nomisweb.co.uk/api/v01/dataset/NM_657_1/geography/TYPE464.def.sdmx.json

# In the response, each entry in the code array has a “description.value" 
# which gives the name and a “value" which gives the Nomis ID for it:

# {
# "annotations" :{
# "annotation" :[
# {
# "annotationtext" :"regions",
# "annotationtitle" :"TypeName"},
# {
# "annotationtext" :480,
# "annotationtitle" :"TypeCode"},
# {
# "annotationtext" :"E12000007",
# "annotationtitle" :"GeogCode"}]},
# "parentcode" :2092957699,
# "description" :{
# "value" :"London",
# "lang" :"en"},
# "value" :2013265927},
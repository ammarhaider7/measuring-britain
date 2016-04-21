# Below is the URL endpoint for getting all ethnic group data for Eng & Wales, 
# https://www.nomisweb.co.uk/api/v01/dataset/
# NM_608_1.data.json
# ?date=latest
# &geography=K04000001
# &rural_urban=0 (Total)
# &measures=20100 (Value)

# Data set - NM_***_*.data.json
# NM_608_1 - KS201EW - Ethnic group

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

# Geograpghy codes (countries)
# England and Wales - K04000001
# England - E92000001
# Wales - W92000004

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
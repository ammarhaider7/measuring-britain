# Below is the URL endpoint for getting all data for Eng & Wales, 
# all ages, all ethnicities and no religion specified.
# https://www.nomisweb.co.uk/api/v01/dataset/
# NM_659_1.data.json
# ?date=latest
# &c_relpuk11=0
# &geography=K04000001
# &c_ethpuk11=1,6,11,17,21,22,23

# Data set - NM_***_*.data.json
# NM_657_1 - DC2107EW - Religion by sex by age

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
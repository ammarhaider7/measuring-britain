nomisEndPoint = "https://www.nomisweb.co.uk/api/v01/dataset/"
dataSet = "NM_679_1.data.json" #  DC6203EW - Economic activity by country of birth by sex by age

# https://www.nomisweb.co.uk/api/v01/dataset/NM_679_1.data.json?date=latest&geography=2092957703&c_sex=0&c_age=0&c_ecopuk11=3,6,11,14...18&c_cob=2,11,14,15,20,26,29,30&measures=20100

defaultOptions = {
	isDefault: yes
	category: 
		label: 'default'
		value: 'default'
	value: 
		label: 'default'
		value: 'default'
}

makeEconCountryRequest = (options) ->

	defaultNomisOptions = {
		dataSet: dataSet
		queryStringOps: {
			date: "date=latest"
			geography: "geography=2092957703"
			c_ecopuk11: "c_ecopuk11=3,6,11,14...18"
			c_cob: "c_cob=2,11,14,15,20,26,29,30"
			c_age: "c_age=0"
			measures: "measures=20100"
			c_sex: "c_sex=0"
		}
	}

	queryStringArr = []

	generateDataObject = (o) ->

		catCode = o.category.value
		catLabel = o.category.label
		valLabel =  o.value.label
		valCode = o.value.value

		return {
			queryStringOps: {
				# default values
				date: "date=latest"
				c_ecopuk11: "c_ecopuk11=3,6,11,14...18"
				c_cob: "c_cob=2,11,14,15,20,26,29,30"
				c_age: "c_age=0"
				measures: "measures=20100"
				geography: "geography=#{ valCode }"
			}
		}

	getOptions = ->

		if options?

			return generateDataObject options

		else

			return defaultNomisOptions
	
	generateQueryString = (getOptions, queryStringArr) ->

		for own key, value of getOptions().queryStringOps
			unless value is ""
				queryStringArr.push value
		return '?' + queryStringArr.join '\&'

	# make call using jQuery and return the promise object
	$.getJSON nomisEndPoint + dataSet + generateQueryString getOptions, queryStringArr
	
module.exports = makeEconCountryRequest
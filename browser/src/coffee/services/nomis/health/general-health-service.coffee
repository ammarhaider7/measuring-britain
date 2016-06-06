nomisEndPoint = "//www.nomisweb.co.uk/api/v01/dataset/"
dataSet = "NM_739_1.data.json" # DC3204EWr - General health by ethnic group by sex by age (regional) 

# ?date=latest&geography=2092957703&c_sex=0&c_age=1...6&c_health=1...3&c_ethpuk11=2...5,7...10,12...16,18...20,22,23&measures=20100

defaultOptions = {
	isDefault: yes
	category: 
		label: 'default'
		value: 'default'
	value: 
		label: 'default'
		value: 'default'
}

makeGenHealthRequest = (options) ->

	defaultNomisOptions = {
		dataSet: dataSet
		queryStringOps: {
			date: "date=latest"
			geography: "geography=K04000001"
			c_ethpuk11: "c_ethpuk11=2...5,7...10,12...16,18...20,22,23"
			c_health: "c_health=1...3"
			c_age: "c_age=1...6"
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
		sexLabel = o.sex.label
		sexCode = o.sex.value

		return {
			queryStringOps: {
				# default values
				date: "date=latest"
				c_ethpuk11: "c_ethpuk11=2...5,7...10,12...16,18...20,22,23"
				c_health: "c_health=1...3"
				c_age: "c_age=1...6"
				measures: "measures=20100"
				c_sex: do ->
					if sexLabel is 'Female'
						return "c_sex=2"
					else if sexLabel is 'Male'
						return "c_sex=1"
					else
						return "c_sex=0"
				geography: do ->
					if catLabel.indexOf('Geography') isnt -1 
						return "geography=#{ valCode }"
					else
						return "geography=K04000001"
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
	
module.exports = makeGenHealthRequest
$ = require 'jQuery'
nomisEndPoint = "https://www.nomisweb.co.uk/api/v01/dataset/"
relDataSet = "NM_657_1.data.json" # DC2107EW - Religion by sex by age
ethDataSet = "NM_651_1.data.json" # DC2101EW - Ethnic group by sex by age

defaultOptions = {
    outlineRequested: no
	bars: 
		isDefault: yes
		category: 
			label: 'default'
			value: 'default'
		
		value: 
			label: 'default'
			value: 'default'
	outline: 
		isDefault: yes
		category:
			label: 'default'
			value: 'default'
		value:
			label: 'default'
			value: 'default'
}

makePyramidRequest = (options) ->

	defaultNomisOptions = {
		dataSet: relDataSet
		queryStringOps: {
			date: "date=latest"
			geography: "geography=K04000001"
			age: "c_age=1...21"
			sex: "c_sex=1,2"
			religion: "c_relpuk11=0"
		}
	}

	queryStringArr = []

	generateDataObject = (o) ->
		# bar values
		catCode = o.category.value
		catLabel = o.category.label
		valLabel =  o.value.label
		valCode = o.value.value

		return {
			dataSet: do ->
				if catCode is 'ethnicities' then ethDataSet else relDataSet 
			queryStringOps: {
				# default values
				date: "date=latest"
				age: "c_age=1...21"
				sex: "c_sex=1,2"
				# custom values
				geography: do ->
					if catLabel.indexOf('Geography') isnt -1 
						"geography=#{ valCode }"
					else
						"geography=K04000001"
				ethnicity: do ->
					if catCode is 'ethnicities' then "c_ethpuk11=#{ valCode }" else ""
				religion: do ->
					if catCode is 'religions' 
						"c_relpuk11=#{ valCode }" 
					else if catCode is 'ethnicities'
						""
					else
						"c_relpuk11=0"
			}
		}

	getOptions = ->

		# if options.isDefault is yes
		if options?

			# console.log 'options'
			# console.log options
			generateDataObject options

		else

			# console.log 'options.isDefault is on'
			return defaultNomisOptions
	
	generateQueryString = (getOptions, queryStringArr) ->

		for own key, value of getOptions().queryStringOps
			unless value is ""
				queryStringArr.push value
		'?' + queryStringArr.join '&'

	# make call using jQuery and return the promise object
	$.getJSON nomisEndPoint + getOptions().dataSet + generateQueryString getOptions, queryStringArr
	
module.exports = makePyramidRequest
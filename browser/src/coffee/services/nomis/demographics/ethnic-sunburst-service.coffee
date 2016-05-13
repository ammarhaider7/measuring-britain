$ = require 'jQuery'
nomisEndPoint = "https://www.nomisweb.co.uk/api/v01/dataset/"
dataSet = "NM_659_1.data.json" # DC2201EW - Ethnic Group by Religion

defaultOptions = {
	isDefault: yes
	category: 
		label: 'default'
		value: 'default'
	
	value: 
		label: 'default'
		value: 'default'
}

makeSunburstRequest = (options) ->

	defaultNomisOptions = {
		dataSet: dataSet
		queryStringOps: {
			geography: "geography=K04000001"
			# rural_urban: 0
			# measures: 20100 
			c_relpuk11: "c_relpuk11=0"
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
			queryStringOps: {
				# default values
				# rural_urban: "rural_urban=0"
				# measures: "measures=20100"
				# custom values
				geography: do ->
					if catLabel.indexOf('Geography') isnt -1 
						"geography=#{ valCode }"
					else
						"geography=K04000001"
				religion: do ->
					if catCode is 'religions' 
						"c_relpuk11=#{ valCode }" 
					else
						"c_relpuk11=0"
			}
		}

	getOptions = ->

		# if options.isDefault is yes
		if options?

			# console.log 'options'
			# console.log options
			return generateDataObject options

		else

			# console.log 'options.isDefault is on'
			return defaultNomisOptions
	
	generateQueryString = (getOptions, queryStringArr) ->

		for own key, value of getOptions().queryStringOps
			unless value is ""
				queryStringArr.push value
		return '?' + queryStringArr.join '\&'

	# make call using jQuery and return the promise object
	$.getJSON nomisEndPoint + dataSet + generateQueryString getOptions, queryStringArr
	
module.exports = makeSunburstRequest
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

makeRelBarsRequest = (options) ->

	defaultNomisOptions = {
		dataSet: dataSet
		queryStringOps: {
			geography: "geography=K04000001"
			c_ethpuk11: "c_ethpuk11=0"
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
				geography: do ->
					if catLabel.indexOf('Geography') isnt -1 
						"geography=#{ valCode }"
					else
						"geography=K04000001"
				ethnicity: do ->
					if catCode is 'ethnicities' 
						"c_ethpuk11=#{ valCode }" 
					else
						"c_ethpuk11=0"
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
	
module.exports = makeRelBarsRequest
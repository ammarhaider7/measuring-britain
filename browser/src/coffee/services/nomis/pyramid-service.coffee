$ = require 'jQuery'
nomisEndPoint = "https://www.nomisweb.co.uk/api/v01/dataset/"
dataSet = "NM_657_1.data.json" # DC2107EW - Religion by sex by age
defaultOptions = {
	date: "date=latest"
	geography: "geography=K04000001"
	age: "c_age=1...21"
	sex: "c_sex=1,2"
	religion: "c_relpuk11=0"
}

makePyramidRequest = (options = defaultOptions) ->
	# convert options object into query string
	queryStringArr = []
	queryString = do ->
		for key, value of options
			queryStringArr.push value
		'?' + queryStringArr.join '&'

	# make call using jQuery and return the promise object
	$.getJSON nomisEndPoint + dataSet + queryString

module.exports = makePyramidRequest
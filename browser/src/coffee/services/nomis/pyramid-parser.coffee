window._ = require 'underscore'

parse = (dataArray) ->

	window.dataArray = dataArray

	ages = [
	  '0 to 4'
	  '5 to 7'
	  '8 to 9'
	  '10 to 14'
	  '15'
	  '16 to 17'
	  '18 to 19'
	  '20 to 24'
	  '25 to 29'
	  '30 to 34'
	  '35 to 39'
	  '40 to 44'
	  '45 to 49'
	  '50 to 54'
	  '55 to 59'
	  '60 to 64'
	  '65 to 69'
	  '70 to 74'
	  '75 to 79'
	  '80 to 84'
	  '85 +'
	]

	# Utility methods
	utils = 
		sum: (data) ->
			total = 0
			data.forEach (el) ->
				total += el
				return
			total	
		getValues: (array) ->
			array.map (ob) ->
				ob.obs_value.value
		percArray: (array, sum) ->
			array.map (num) ->
				num / sum * 100
		percArrayFormat: (array, sum) ->
			array.map (num) ->
				num / sum	

	maleObs = _(dataArray).first(21)
	femaleObs = _(dataArray).last(21)

	totalArr = utils.getValues dataArray

	males = utils.getValues maleObs

	females = utils.getValues femaleObs

	males.splice 1, 2, males[1] + males[2]
	males.splice 3, 3, males[3] + males[4] + males[5]

	females.splice 1, 2, females[1] + females[2]
	females.splice 3, 3, females[3] + females[4] + females[5]

	ages.splice 1, 2, '5 to 9'
	ages.splice 3, 3, '15 to 19'

	males.reverse()
	females.reverse()

	# Additional values for d3
	sum = utils.sum totalArr
	malesPerc = utils.percArray males, sum
	femalesPerc = utils.percArray females, sum
	malesPercFormat = utils.percArrayFormat males, sum
	femalesPercFormat = utils.percArrayFormat females, sum

	d3ReadyData = {
		males
		females
		ages
		sum		
		malesPerc
		femalesPerc
		malesPercFormat
		femalesPercFormat
	}

	return d3ReadyData

module.exports = parse
d3 = require 'd3'

parse = (dataArray) ->

	# Need to remove totals from children
	window.relBarsData = dataArray

	# All ethnic item
	total_item = dataArray.shift()

	# RegEx to match first word
	re = /^\w+/;
	# RegEx to match last word
	reLast = /\w+$/;
	# Fn to match words after ':' 
	last = (str) ->
		return str.substr str.indexOf(':') + 2, str.length
	
	# Utility methods
	utils = 
		getValues: (array) ->
			array.map (ob) ->
				return ob.obs_value.value
		percArray: (array, sum) ->
			array.map (num) ->
				return num / sum * 100

	sum = total_item.obs_value.value
	d3_array = dataArray.map (ob) ->

		return {
			name: ob.c_relpuk11.description
			value: ob.obs_value.value
		}

	d3ReadyData = {
		d3_array
		sum
	}

	return d3ReadyData

module.exports = parse
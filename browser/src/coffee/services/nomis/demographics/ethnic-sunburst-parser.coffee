d3 = require 'd3'

parse = (dataArray) ->

	# All ethnic item
	total_item = dataArray.shift()

	# Need to remove totals from children
	window.sunBurstData = dataArray
	
	# RegEx to match first word
	re = /^\w+/;
	# RegEx to match last word
	reLast = /\w+$/;
	# Fn to match words after ':' 
	last = (str) ->
		return str.substr str.indexOf(':') + 2, str.length

	# Group by top level ethnicity, then sub-level ethnicity and return their values
	nested_data = d3.nest()
		.key (d) ->
			return d.c_ethpuk11.description.match(re)[0]
		.key (d) ->
			ethnicity = d.c_ethpuk11.description
			return if ethnicity.indexOf('English') isnt -1 then ethnicity.match reLast else last ethnicity
		.rollup (values) ->
			d3.sum values, (d) ->
				d.obs_value.value
		.entries dataArray

	# Utility methods
	utils = 
		getValues: (array) ->
			array.map (ob) ->
				ob.obs_value.value
		percArray: (array, sum) ->
			array.map (num) ->
				num / sum * 100

	d3_nested_data = {
		key: "ethnic_diversity"
		values: nested_data
	}

	d3ReadyData = {
		d3_nested_data
		total_item
	}

	return d3ReadyData

module.exports = parse
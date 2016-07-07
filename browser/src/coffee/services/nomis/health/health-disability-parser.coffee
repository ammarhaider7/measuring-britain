d3 = require 'd3'

parse = (dataArray) ->

	# c_disability potential values
	# "Day-to-day activities limited a lot" has a value of 1
	# "Day-to-day activities limited a little" has a value of 2
	# "Day-to-day activities not limited" has a value of 3

	sumDisability = (arr, val) ->
		d3.sum arr, (d) ->
			if d.c_disability.value is val
				return d.obs_value.value

	# nesting data
	nested_data = d3.nest().key (d) ->

	  return d.c_ethpuk11.description

	.key (d) ->

	  return d.c_age.description

	.rollup (values) ->

		return  {
		    sum: d3.sum values, (d) ->

		      return d.obs_value.value

		    limited_a_lot: sumDisability values, 1
		    limited_a_little: sumDisability values, 2
		    not_limited: sumDisability values, 3

		}
	.entries dataArray

	# nested_data = d3.nest().key (d) ->

	#   return d.c_ethpuk11.description

	# .rollup (values) ->

	# 	return  {
	# 	    sum: d3.sum values, (d) ->

	# 	      return d.obs_value.value

	# 	    limited_a_lot: sumDisability values, 1
	# 	    limited_a_little: sumDisability values, 2
	# 	    not_limited: sumDisability values, 3

	# 	}
	# .entries dataArray

	# Map to %'s
	percentages = nested_data.map (ethnicity) ->

		return {

			key: ethnicity.key
			values: ethnicity.values.map (age) ->

				return {

					key: age.key
					ethnicity: ethnicity.key
					values:
						limited_a_lot: age.values.limited_a_lot / age.values.sum
						limited_a_little: age.values.limited_a_little / age.values.sum
						not_limited: age.values.not_limited / age.values.sum

				}

		}

	getMaxValueFromArr = (arr, value) ->
		return d3.max arr, (d) ->
			return d.values[value]

	sort_arr = []
	for ethnicity in percentages
		sort_arr.push {
			ethnicity: ethnicity.key
			max_value: getMaxValueFromArr ethnicity.values, 'limited_a_lot'
		}
	sort_arr = sort_arr.sort (a, b) ->
   		return b.max_value - a.max_value
   	sorted_ethnicities = sort_arr.map (ob) ->
   		return ob.ethnicity

   	sorted_percentages = sorted_ethnicities.map (ob) ->
   		for ethnicity in percentages
   			return ethnicity if ob is ethnicity.key

	# percentages = nested_data.map (ethnicity) ->

	# 	return {
	# 		key: ethnicity.key
	# 		values: [
	# 			{
	# 				key: 'limited_a_lot'
	# 				value: ethnicity.values.limited_a_lot / ethnicity.values.sum
	# 			}
	# 			{
	# 				key: 'limited_a_little'
	# 				value: ethnicity.values.limited_a_little / ethnicity.values.sum
	# 			}
	# 			{
	# 				key: 'not_limited'
	# 				value: ethnicity.values.not_limited / ethnicity.values.sum
	# 			}
	# 		]
	# 	}

	# Create array of ethnicities
	ethnicities = nested_data.map (ethnicity) ->

		return ethnicity.key

	# Create ages array
	ages = nested_data[0].values.map (age) ->

		return age.key

	return {
		ethnicities
		sorted_ethnicities
		percentages
		nested_data
		ages
		sort_arr
		sorted_percentages
	}

module.exports = parse
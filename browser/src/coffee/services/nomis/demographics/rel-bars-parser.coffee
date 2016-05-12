d3 = require 'd3'

parse = (dataArray) ->

	# Need to remove totals from children
	relBarsData = dataArray

	# All ethnic item
	total_item = dataArray.shift()

	getName = (ob) ->
		
		if ob.c_relpuk11.description is 'Religion not stated'
			return 'Not stated'
		else if ob.c_relpuk11.description is 'Other religion'
			return 'Other'
		else
			return ob.c_relpuk11.description

	sum = total_item.obs_value.value
	d3_array = dataArray.map (ob) ->

		return {
			name: getName(ob)
			value: ob.obs_value.value
		}

	d3_array.sort (a, b) ->

		return b.value - a.value

	d3ReadyData = {
		d3_array
		sum
	}

	return d3ReadyData

module.exports = parse
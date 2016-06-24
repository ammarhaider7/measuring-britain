parse = (dataArray) ->

	# Need to remove totals from children
	sunBurstData = dataArray

	# All ethnic item
	total_item = dataArray.shift()

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
				return d.obs_value.value
		.entries dataArray

	# Remove totals ob from values arrays
	nested_data.forEach (ob) ->
		ob.values.shift()

	# Change key to name and values to children
	nested_data = nested_data.map (ob) ->
		return {
			name: ob.key
			size: total_item.obs_value.value
			children: ob.values.map (ob) ->
				return {
					name: ob.key
					size: ob.values
				}
		}
	
	# Utility methods
	utils = 
		getValues: (array) ->
			array.map (ob) ->
				ob.obs_value.value
		percArray: (array, sum) ->
			array.map (num) ->
				num / sum * 100

	d3_nested_data = {
		name: "ethnic_diversity"
		children: nested_data
	}

	d3ReadyData = {
		d3_nested_data
		total_item
	}

	# window.flareJson = flareJson
	return d3ReadyData
	# return flareJson

module.exports = parse
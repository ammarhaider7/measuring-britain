parse = (dataArray) ->

	# Nest function to get general health figures by age by ethnicity
	nested_data = d3.nest().key (d) ->

	  return d.c_ethpuk11.description

	.key (d) ->

	  return d.c_age.description

	.rollup (values) ->

		return  {
		    sum: d3.sum values, (d) ->

		      return d.obs_value.value

		    good: d3.sum values, (d) ->

		      if d.c_health.value is 1
		        return d.obs_value.value

		    fair: d3.sum values, (d) ->

		      if d.c_health.value is 2
		        return d.obs_value.value

		    bad: d3.sum values, (d) ->

		      if d.c_health.value is 3
		        return d.obs_value.value

		}
	.entries dataArray

	# Map to %'s
	percentages = nested_data.map (ethnicity) ->

		return {

			key: ethnicity.key
			values: ethnicity.values.map (age) ->

				return {

					key: age.key
					values:
						good: age.values.good / age.values.sum
						fair: age.values.fair / age.values.sum
						bad: age.values.bad / age.values.sum

				}

		}

	window.flatMaxPercsArray = percentages.map (ethnicity) ->

		return {

			max_bad_perc: d3.max ethnicity.values, (d) ->

				return d.values.bad

		}

	max_perc = d3.max flatMaxPercsArray, (d) ->

		return d.max_bad_perc

	max_value = d3.max dataArray, (d) ->

		return d.obs_value.value

	ethnicities = nested_data.map (eth) ->

		return eth.key

	ages = nested_data[0].values.map (age) ->

		return age.key

	return {
		ethnicities
		nested_data
		percentages
		max_perc
		max_value
		ages
	}

module.exports = parse
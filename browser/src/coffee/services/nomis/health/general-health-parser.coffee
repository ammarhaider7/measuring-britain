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

	# Total populations for each ethnicity
	# Total bad health populations for each age group in each ethnicity
	ethnicity_age_detail = d3.nest().key (d) ->

		return d.c_ethpuk11.description

	.key (d) ->

	  return d.c_age.description

	.rollup (values) ->

		return {

			total_population: d3.sum values, (d) ->
				return d.obs_value.value
			bad_health: d3.sum values, (d) ->
				if d.c_health.value is 3
					return d.obs_value.value

		}
	.entries dataArray

	# Total population
	total_population = d3.sum dataArray, (d) ->
		return d.obs_value.value

	# Total in bad health
	number_bad_health = d3.sum dataArray, (d) ->
		if d.c_health.value is 3
			return d.obs_value.value

	# Total populations and no. bad health for each age group
	total_age_detail = d3.nest().key (d) ->

		return d.c_age.description

	.rollup (values) ->

		return {

			total_population: d3.sum values, (d) ->
				return d.obs_value.value
			bad_health: d3.sum values, (d) ->
				if d.c_health.value is 3
					return d.obs_value.value
		}
	.entries dataArray

	# Collate in total_item
	total_item = {

		population: total_population
		number_bad_health: number_bad_health
		percent_bad_health: number_bad_health / total_population
		total_age_detail: total_age_detail

	}

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

	flatMaxPercsArray = percentages.map (ethnicity) ->

		return {

			max_bad_perc: d3.max ethnicity.values, (d) ->

				return d.values.bad

		}

	max_perc = d3.max flatMaxPercsArray, (d) ->

		return d.max_bad_perc

	max_value = d3.max dataArray, (d) ->

		return d.obs_value.value

	# Create array of ethnicities
	ethnicities = nested_data.map (ethnicity) ->

		return ethnicity.key

	breakArrayIntoGroups = (data, maxPerGroup) ->

		numInGroupProcessed = 0
		groups = [[]]
		i = 0

		while i < data.length

			groups[groups.length - 1].push data[i]
			++numInGroupProcessed

			if numInGroupProcessed >= maxPerGroup and i != data.length - 1
				groups.push []
				numInGroupProcessed = 0

			i++

		return groups

	# Ethnicities grouped object

	ethnicities_titles = do ->

		arr = ethnicities
		arr.splice 0, 0, { title: 'White' }
		arr.splice 5, 0, { title: 'Mixed' }
		arr.splice 10, 0, { title: 'Asian' }
		arr.splice 16, 0, { title: 'Black' }
		arr.splice 20, 0, { title: 'Other' }

		return arr

	ethnicities_grouped = breakArrayIntoGroups ethnicities_titles, 8 

	# Create ages array
	ages = nested_data[0].values.map (age) ->

		return age.key

	return {
		ethnicities
		ethnicities_grouped
		nested_data
		percentages
		ethnicity_age_detail
		total_item
		max_perc
		max_value
		ages
	}

module.exports = parse
parse = (dataArray) ->

	# Economic activity categories
	# Economically active: In employment: Employee: Total: 3
	# Economically active: In employment: Self-employed: Total: 6
	# Economically active: Unemployed: Unemployed (excluding full-time students): 11
	# Economically inactive: Retired: 14
	# Economically inactive: Student (including full-time students): 15
	# Economically inactive: Looking after home or family: 16
	# Economically inactive: Long-term sick or disabled: 17
	# Economically inactive: Other: 18

	sumEconCat = (arr, val) ->
		d3.sum arr, (d) ->
			if d.c_ecopuk11.value is val
				return d.obs_value.value

	# total sum
	total_sum = d3.sum dataArray, (d) ->

		return d.obs_value.value

	# total item
	total_item_values = d3.nest().key (d) ->

		return d.c_ecopuk11.description

	.rollup (values) ->

		return {
			sum: d3.sum values, (d) ->
				return d.obs_value.value
		}
	.entries dataArray

	total_item_percs = total_item_values.map (ob) ->

		return {
			economic_activity: ob.key
			perc: ob.values.sum / total_sum
			value: ob.values.sum
		}

	# nesting data
	nested_data = d3.nest().key (d) ->

	  return d.c_cob.description

	.rollup (values) ->

		return  {
		    sum: d3.sum values, (d) ->

		      return d.obs_value.value
		    # In work
		    in_work: {
		    	employee: sumEconCat values, 3
		    	self_employed: sumEconCat values, 6
		    }
		    # Out of work
		    out_of_work: {
		    	unemployed: sumEconCat values, 11
		    	retired: sumEconCat values, 14
		    	student: sumEconCat values, 15
		    	looking_after_home_family: sumEconCat values, 16
		    	long_term_sick_disabled: sumEconCat values, 17
		    	other: sumEconCat values, 18
		    }

		}
	.entries dataArray

	# Map to %'s
	percentages = nested_data.map (country) ->

		in_work = country.values.in_work
		out_of_work = country.values.out_of_work
		sum = country.values.sum

		in_work_employee = in_work.employee
		in_work_self_employed = in_work.self_employed

		out_of_work_unemployed = out_of_work.unemployed
		out_of_work_retired = out_of_work.retired
		out_of_work_student = out_of_work.student
		out_of_work_looking_after_home_family = out_of_work.looking_after_home_family
		out_of_work_longterm_sick_disabled = out_of_work.long_term_sick_disabled
		out_of_work_other = out_of_work.other

		sum_in_work = in_work_employee + in_work_self_employed
		sum_out_of_work = out_of_work_unemployed + out_of_work_retired + out_of_work_student + out_of_work_looking_after_home_family + out_of_work_longterm_sick_disabled + out_of_work_other

		return {

			country: country.key
			# In work
			in_work: {
				employee: in_work_employee / sum
				self_employed: in_work_self_employed / sum
				sum_perc: sum_in_work / sum
				sum: sum_in_work
			}
			# Out of work
			out_of_work: {
				unemployed: out_of_work_unemployed / sum
				retired: out_of_work_retired / sum
				student: out_of_work_student / sum
				looking_after_home_family: out_of_work_looking_after_home_family / sum
				long_term_sick_disabled: out_of_work_longterm_sick_disabled / sum
				other: out_of_work_other / sum
				sum_perc: sum_out_of_work / sum
				sum: sum_out_of_work
			}

		}

	# Employment statuses
	in_employment_cats = [
		'employee'
		'self_employed'
	]

	out_employment_cats = [
		'unemployed'
		'retired'
		'student'
		'other'
		'looking_after_home_family'
		'long_term_sick_disabled'
	]

	employment_cats_concat = in_employment_cats.concat out_employment_cats

	# Employment statuses
	employment_cats_pretty = [
		'Employee'
		'Self employed'
		'Unemployed'
		'Retired'
		'Student'
		'Other'
		'Looking after home/family'
		'Long-term sick/disabled'
	]

	# add stacking values for in work
	percentages.forEach (d) ->

		y0 = 0
		d.in_work_categories = in_employment_cats.map (category) ->

			return {
				country: d.country
				sum_perc: d.in_work.sum_perc
				name: category
				sum: d.in_work.sum
				value: d.in_work[category]
				y0: y0
				y1: y0 += d.in_work[category]
			}

	# add stacking values for out of work
	percentages.forEach (d) ->

		y0 = 0

		d.out_of_work_categories = out_employment_cats.map (category) ->

			return {
				country: d.country
				sum_perc: d.out_of_work.sum_perc
				sum: d.out_of_work.sum
				name: category
				value: d.out_of_work[category]
				y0: y0
				y1: y0 += d.out_of_work[category]
			}

	# Sort percentages by highest employment rate
	percentages = percentages.sort (a, b) ->
		a_in_work = a.in_work.employee + a.in_work.self_employed
		b_in_work = b.in_work.employee + b.in_work.self_employed
		return b_in_work - a_in_work

	# Create array of countries
	countries = percentages.map (country) ->

		return country.country

	return {
		nested_data
		countries
		percentages
		employment_cats_pretty
		employment_cats_concat
		total_item_values
		total_item_percs
	}

module.exports = parse
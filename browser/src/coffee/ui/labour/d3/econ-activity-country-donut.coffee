drawEconByCountryChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	# Actual chart code
	my = {}

	width = $(container).width() ? 800
	height = $(container).height() ? 550

	# Set margins
	margin = 
		top: 20
		right: 20
		bottom: 20
		left: 20

	chart_width = width - margin.left - margin.right
	chart_height = height - margin.top - margin.bottom

	format = d3.format '.2s'
	percFormat = d3.format ',.0%'
	pointPercFormat = d3.format ',.2%'
	d3_array = data.percentages
	countries = data.countries
	employment_cats = data.employment_cats_pretty
	employment_cats_concat = data.employment_cats_concat
	key = (d) ->
		return d.country
	# In work colours
	in_work_colours_domain = ["Employee", "Self employed"]
	in_work_colours_range = ['#74c476', '#98df8a']
	in_work_colours = d3.scale.ordinal()
		.domain in_work_colours_domain
		.range in_work_colours_range
	# Out of work colours
	out_of_work_colours_domains = ["Unemployed", "Retired", "Student", "Other", "Looking after home/family", "Long-term sick/disabled"]
	out_of_work_range = ['#C54E58', '#D6616B', '#B33742', '#E47982', '#F38F97', '#FDABB1']
	out_of_work_colours = d3.scale.ordinal()
		.domain out_of_work_colours_domains
		.range out_of_work_range

	trimCountryString = (str) ->

		if str.indexOf('Antarctica') > -1
			return 'Oceanian countries'
		else if str.indexOf('EU countries') > -1
			return 'EU countries'
		else if str.indexOf('Africa') > -1
			return 'African countries'
		else if str.indexOf('Rest of Europe') > -1
			return 'Non-EU European countries'
		else if str.indexOf('United Kingdom') > -1
			return 'United Kingdom'
		else if str.indexOf('Americas') > -1
			return 'Americas & Carribean'
		else if str.indexOf('Middle') > -1
			return 'Asia & Middle East'

	# Scales, axes and layouts

	# Set inner and outer radii of arcs
	arc = d3.svg.arc()
		.outerRadius r * 0.3
		.innerRadius r * 0.6

	# Set outer arc for labels
	outerArc = d3.svg.arc()
		.outerRadius r * 0.7
		.innerRadius r * 0.8

	# y scale for out of work 
	y0 = d3.scale.linear()
		.domain [0, 1]
		.range [0, (0.5 * chart_height)]

	# Set layout of pie
	pie = d3.layout.pie()
		.sort null
		.value (d) ->
			return d.count

	# arcTween function
	arcTween = (a) ->
		i = d3.interpolate @._current, a
		@._current = i 0
		return (t) ->
			return arc i t
		
	my.init = ->

		# Create svg and g vars
		svg = d3.select '.econ-country-donut-svg'
		main_group = svg.select '.main-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ chart_width * 0.5 }, #{ chart_height * 0.5 }), rotate(90)"

	
	my.update = ->

		# update the chart here
		svg = d3.select '.econ-country-svg'
		main_top_group = svg.select '.main-group-top'
		main_bottom_group = svg.select '.main-group-bottom'

	my.width = (value) ->
		unless arguments.length then return width
		width = value
		return my

	my.height = (value) ->
		unless arguments.length then return height
		height = value
		return my

	return my

module.exports = drawEconByCountryChart
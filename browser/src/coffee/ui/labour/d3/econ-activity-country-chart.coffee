drawEconByCountryChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	# Actual chart code
	my = {}

	width = $(container).width() ? 800
	height = $(container).height() ? 550

	# Set margins
	margin = 
		top: 35
		right: 20
		bottom: 45
		left: 40
		p: 25
		label: 60

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
	in_work_colours_domain = ["employee", "self_employed"]
	in_work_colours_range = ['#74c476', '#98df8a']
	in_work_colours = d3.scale.ordinal()
		.domain in_work_colours_domain
		.range in_work_colours_range
	# Out of work colours
	out_of_work_colours_domains = ["unemployed", "retired", "student", "other", "looking_after_home_family", "long_term_sick_disabled"]
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
	x = d3.scale.ordinal()
		.domain countries
		.rangeRoundBands [0, chart_width], 0.35

	# y scale for in work 
	y = d3.scale.linear()
		.domain [0, 1]
		.range [(0.5 * chart_height), 0]

	# y scale for out of work 
	y0 = d3.scale.linear()
		.domain [0, 1]
		.range [0, (0.5 * chart_height)]

	xAxis = d3.svg.axis()
		.scale x
		.orient 'bottom'

	yAxisTop = d3.svg.axis()
		.scale y
		.ticks 5
		.tickSize -chart_width
		.tickFormat percFormat
		.orient 'left'

	yAxisBottom = d3.svg.axis()
		.scale y0
		.ticks 5
		.tickSize -chart_width
		.tickFormat percFormat
		.orient 'left'

	my.init = ->

		# Create svg and g vars
		svg = d3.select '.econ-country-svg'
		main_top_group = svg.select '.main-group-top'
		main_bottom_group = svg.select '.main-group-bottom'
		x_axis_group = svg.select '.x.axis'
		y_axis_top_group = svg.select '.y.y-top.axis'
		y_axis_bottom_group = svg.select '.y.y-bottom.axis'
		title_group = svg.select '.title-group'
		legend_group = svg.select '.legend-group'
		x_axis_divider_group = svg.select '.x-axis-divider'
		top_rect_group = svg.select '.top-group-rect'
		bottom_rect_group = svg.select '.bottom-group-rect'

		# Transforms
		main_top_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		main_bottom_group.attr 'transform', "translate(#{ margin.left }, #{ (chart_height / 2) + margin.top })"
		x_axis_group.attr 'transform', "translate(#{ margin.left }, #{ (chart_height / 2) + margin.top })"
		x_axis_divider_group.attr 'transform', "translate(#{ margin.left }, #{ (chart_height / 2) + margin.top })"
		top_rect_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		y_axis_top_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		y_axis_bottom_group.attr 'transform', "translate(#{ margin.left }, #{ (chart_height / 2) + margin.top })"
		bottom_rect_group.attr 'transform', "translate(#{ margin.left }, #{ (chart_height / 2) + margin.top })"
		title_group.attr 'transform', "translate(#{ chart_width / 2 + margin.left }, 0)"
		legend_group.attr 'transform', "translate(#{ chart_width - margin.p }, #{ margin.top })"

		# Create rect background
		top_rect_group.append 'rect'
			.attr {
				width: chart_width
				x: 0
				height: 0.5 * chart_height
				fill: 'rgba(152, 223, 138, 0.47)'
				opacity: 0
			}
			.transition()
			.duration 1500
			.attr 'opacity', 0.3

		# Create top text label
		main_top_group.append 'text'
			.attr {
				x: chart_width * 0.5
				y: margin.label
				class: 'in-work-label'
				opacity: 0
			}
			.text 'In work'
			.transition()
			.duration 1500
			.attr 'opacity', 0.5

		# Create rect background
		bottom_rect_group.append 'rect'
			.attr {
				width: chart_width
				x: 0
				height: 0.5 * chart_height
				fill: '#FFCFCF'
				opacity: 0
			}
			.transition()
			.duration 1500
			.attr 'opacity', 0.3

		# Create bottom text label
		main_bottom_group.append 'text'
			.attr {
				x: chart_width * 0.5
				y: chart_height * 0.5 - margin.label
				class: 'out-of-work-label'
				opacity: 0
			}
			.text 'Not in work'
			.transition()
			.duration 1500
			.attr 'opacity', 0.5

		# Create axes
		x_axis_group.transition()
			.duration 1500
			.call xAxis

		y_axis_top_group.transition()
			.duration 1500
			.call yAxisTop

		y_axis_top_group.append "text"
		      .attr "transform", "rotate(-90)"
		      .attr "y", 6
		      .attr "dy", ".71em"
		      .style "text-anchor", "end"
		      .text "% of Population"

		y_axis_bottom_group.transition()
			.duration 1500
			.call yAxisBottom

		# Bind percentages data to top country groups 
		top_countries = main_top_group.selectAll '.country-g'
			.data d3_array, key
			.enter().append 'g'
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"
			.attr 'class', 'country-g'

		# Bind percentages data to bottom country groups 
		bottom_countries = main_bottom_group.selectAll '.country-g'
			.data d3_array, key
			.enter().append 'g'
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"
			.attr 'class', 'country-g'

		# Add country labels
		top_countries.append 'text'
			.text (d) ->
				return trimCountryString d.country
			.attr {
				x: -(chart_height*0.5) + 3
				y: -3
				transform: "rotate(-90)"
				'font-size': '80%'
				class: 'country-label'
				opacity: 0
			}
			.transition()
			.duration 1500
			.attr 'opacity', 1

		# Add stacked bars
		top_countries.selectAll 'rect'
			.data (d) ->
				return d.in_work_categories
			.enter().append 'rect'
			.attr {
				width: x.rangeBand()
				y: chart_height * 0.5
				height: 0
				fill: (d) ->
					return in_work_colours d.name
				class: 'rect'
			}
			.transition()
			.duration 1500
			.attr {
				y: (d) ->
					# d.y1 is the actual % value of the data point
					return y d.y1
				height: (d) ->
					# d.y0 is the % value of the previous data point or 0 for the first one
					return (y d.y0) - (y d.y1)
			}

		# Add stacked bars
		bottom_countries.selectAll 'rect'
			.data (d) ->
				return d.out_of_work_categories
			.enter().append 'rect'
			.attr {
				width: x.rangeBand()
				y: 0
				height: 0
				fill: (d) ->
					return out_of_work_colours d.name
				class: 'rect'
			}
			.transition()
			.duration 1500
			.attr {
				y: (d) ->
					# d.y0 is the % value of the previous data point or 0 for the first one
					return y0 d.y0
				height: (d) ->
					# d.y1 is the actual % value of the data point
					return (y0 d.y1) - (y0 d.y0) 
			}

		# Draw line to divide both sets of bars
		x_axis_divider_group.append 'line'
			.attr {
				stroke: 'black'
				'stroke-width': 1
				x1: 0
				x2: chart_width
				y1: 0
				y2: 0
				opacity: 0
			}
			.transition()
			.duration 1500
			.attr 'opacity', 1

		# Add mouse over handler
		attachHoverHandlers()

	my.update = ->

		# update the chart here
		svg = d3.select '.econ-country-svg'
		main_top_group = svg.select '.main-group-top'
		main_bottom_group = svg.select '.main-group-bottom'

		# Binding new data
		top_countries = main_top_group.selectAll '.country-g'
			.data d3_array, key

		# Performing transform to move country to new position
		top_countries
			.transition()
			.duration 1000
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"

		# Binding new data
		bottom_countries = main_bottom_group.selectAll '.country-g'
			.data d3_array, key

		# Performing transform to move country to new position
		bottom_countries
			.transition()
			.duration 1000
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"

		# Transitioning top rects to new values
		top_countries.selectAll 'rect'
			.data (d) ->
				return d.in_work_categories
			.transition()
			.duration 1000
			.attr {
				y: (d) ->
					return y d.y1
				height: (d) ->
					return (y d.y0) - (y d.y1)
			}		

		# Transitioning top rects to new values
		bottom_countries.selectAll 'rect'
			.data (d) ->
				return d.out_of_work_categories
			.transition()
			.duration 1000
			.attr {
				y: (d) ->
					return y0 d.y0
				height: (d) ->
					return (y0 d.y1) - (y0 d.y0) 
			}

		# Add mouse over handler
		attachHoverHandlers() 

	attachHoverHandlers = ->

		hover_colour = '#03A9F4'

		# update the chart here
		svg = d3.select '.econ-country-svg'
		countries = svg.selectAll '.country-g'
		main_top_group = svg.select '.main-group-top'
		main_bottom_group = svg.select '.main-group-bottom'
		top_rects = main_top_group.selectAll '.rect'
		bottom_rects = main_bottom_group.selectAll '.rect'

		top_rects.on 'mouseover', (d) ->
			console.log d
			$this = d3.select this
			$this.attr 'fill', hover_colour
		.on 'mouseout', (d) ->
			$this = d3.select this
			$this.attr 'fill', (d) ->
				return in_work_colours d.name

		bottom_rects.on 'mouseover', (d) ->
			console.log d
			$this = d3.select this
			$this.attr 'fill', hover_colour
		.on 'mouseout', (d) ->
			$this = d3.select this
			$this.attr 'fill', (d) ->
				return out_of_work_colours d.name

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
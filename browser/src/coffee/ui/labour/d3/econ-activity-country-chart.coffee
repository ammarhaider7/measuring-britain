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

	chart_width = width - margin.left - margin.right
	chart_height = height - margin.top - margin.bottom

	format = d3.format '.2s'
	percFormat = d3.format ',.0%'
	pointPercFormat = d3.format ',.2%'
	d3_array = data.percentages
	countries = data.countries
	employment_cats = data.employment_cats_pretty
	employment_cats_concat = data.employment_cats_concat
	colour = d3.scale.category10()
		.domain employment_cats_concat

	# Scales, axes and layouts
	x = d3.scale.ordinal()
		.domain countries
		.rangeRoundBands [0, chart_width], 0.25

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

		# Create rect backgrounds
		top_rect_group.append 'rect'
			.attr {
				width: chart_width
				x: 0
				height: 0.5 * chart_height
				fill: '#36AB38'
				opacity: 0.3
			}

		bottom_rect_group.append 'rect'
			.attr {
				width: chart_width
				x: 0
				height: 0.5 * chart_height
				fill: 'red'
				opacity: 0.3
			}


		# Create axes
		x_axis_group.call xAxis
		y_axis_top_group.call yAxisTop
		    .append "text"
		      .attr "transform", "rotate(-90)"
		      .attr "y", 6
		      .attr "dy", ".71em"
		      .style "text-anchor", "end"
		      .text "% of Population"

		y_axis_bottom_group.call yAxisBottom

		top_countries = main_top_group.selectAll '.country'
			.data d3_array
			.enter().append 'g'
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"
			.attr 'class', 'country-g'

		bottom_countries = main_bottom_group.selectAll '.country'
			.data d3_array
			.enter().append 'g'
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"
			.attr 'class', 'country-g'

		top_countries.selectAll 'rect'
			.data (d) ->
				return d.in_work_categories
			.enter().append 'rect'
			.attr {
				width: x.rangeBand()
				y: (d) ->
					# d.y1 is the actual % value of the data point
					return y d.y1
				height: (d) ->
					# d.y0 is the % value of the previous data point or 0 for the first one
					return (y d.y0) - (y d.y1)
				fill: (d) ->
					return colour d.name
			}

		bottom_countries.selectAll 'rect'
			.data (d) ->
				return d.out_of_work_categories
			.enter().append 'rect'
			.attr {
				width: x.rangeBand()
				y: (d) ->
					# d.y0 is the % value of the previous data point or 0 for the first one
					return y0 d.y0
				height: (d) ->
					# d.y1 is the actual % value of the data point
					return (y0 d.y1) - (y0 d.y0) 
				fill: (d) ->
					return colour d.name
			}

		# Draw line to divide both sets of bars
		x_axis_divider_group.append 'line'
			.attr {
				stroke: '#333'
				'stroke-dasharray': '5,5'
				'stroke-width': 1
				x1: 0
				x2: chart_width
				y1: 0
				y2: 0
			}

		# Add mouse over handler
		attachHoverHandlers()

	my.update = ->

		# update the chart here
		svg = d3.select '.econ-country-svg'
		x_axis_group = svg.select '.x.axis'
		y_axis_group = svg.select '.y.axis'

		# Add mouse over handler
		attachHoverHandlers() 

	attachHoverHandlers = ->

		# update the chart here
		svg = d3.select '.econ-country-svg'
		countries = svg.selectAll '.country-g'

		countries.on 'mouseover', (d) ->
			console.log d

		# .on 'mouseout', (d) ->

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
d3 = require 'd3'
$ = require 'jquery'

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
		bottom: 10
		left: 40
		p: 25
		label: 60
		tooltip_height: 42

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

	trimEmploymentStatus = (str) ->

		switch str
			when 'employee' then return 'Employee'
			when 'self_employed' then return 'Self employed'
			when 'unemployed' then return 'Unemployed'
			when 'retired' then return 'Retired'
			when 'student' then return 'Student'
			when 'employee' then return 'Employee'
			when 'other' then return 'Other'
			when 'looking_after_home_family' then return 'Looking after home/family'
			when 'long_term_sick_disabled' then return 'Long-term sick/disabled'

	trimCountryString = (str) ->

		if str.indexOf('Antarctica') > -1
			return 'Oceanian'
		else if str.indexOf('EU countries') > -1
			return 'EU'
		else if str.indexOf('Africa') > -1
			return 'African'
		else if str.indexOf('Rest of Europe') > -1
			return 'Non-EU'
		else if str.indexOf('United Kingdom') > -1
			return 'UK'
		else if str.indexOf('Americas') > -1
			return 'Americas'
		else if str.indexOf('Middle') > -1
			return 'Asian'

	# Scales, axes and layouts
	x = d3.scale.ordinal()
		.domain countries
		.rangeRoundBands [0, chart_width], 0.3

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

		# Add country labels
		top_countries.append 'text'
			.text (d) ->
				return trimCountryString d.country
			.attr {
				transform: (d) ->
					return "translate(#{ 0.5 * x.rangeBand() }, #{ y(d.in_work.sum_perc) - 5 })"
				'font-size': '100%'
				'font-weight': 'bold'
				'text-anchor': 'middle'
				class: 'country-label'
				opacity: 0
			}
			.transition()
			.duration 1500
			.attr 'opacity', 1
		
 		# create tooltip groups
		tooltip_group_top = main_top_group.append 'g'
 			.attr 'class', 'tooltip-group top'
 			.attr 'opacity', 0

		tooltip_group_bottom = main_bottom_group.append 'g'
 			.attr 'class', 'tooltip-group bottom'
 			.attr 'transform', "translate(0, #{ chart_width*0.5 })"
 			.attr 'opacity', 0

 		# Add single tooltip for each half of chart, this will be moved to its correct position
 		# when user mouses over on a rect

 		# top rect
		tooltip_group_top.append 'rect'
			.attr {
				class: 'tooltip-bg top'
				width: x.rangeBand() + margin.p
				height: margin.tooltip_height
				fill: '#333'
				x: -10
				y: 0
				opacity: 0.7
				rx: 6
			}

		# top text label
		tooltip_group_top.append 'text'
			.attr {
				class: 'mb-tooltip top'
				x: x.rangeBand()*0.5
				dy: '.35em'
				y: margin.p + 5
				fill: '#FF8C00'
				opacity: 1
				'font-size': '85%'
				'font-weight': 'bold'
				'text-anchor': 'middle'
			}
			.text ''

		tooltip_group_top.append 'text'
			.attr {
				class: 'mb-tooltip-country top'
				x: x.rangeBand()*0.5
				dy: '.35em'
				y: 10
				fill: '#fff'
				opacity: 1
				'font-size': '85%'
				'font-weight': 'bold'
				'text-anchor': 'middle'
			}
			.text ''

		# bottom rect
		tooltip_group_bottom.append 'rect'
			.attr {
				class: 'tooltip-bg bottom'
				width: x.rangeBand() + margin.p*3
				height: margin.tooltip_height
				fill: '#333'
				x: -margin.p*1.5
				y: 0
				opacity: 0.7
				rx: 6
			}

		# bottom text labels
		tooltip_group_bottom.append 'text'
			.attr {
				class: 'mb-tooltip bottom'
				x: x.rangeBand()*0.5
				dy: '.35em'
				y: margin.p + 5
				fill: '#FF8C00'
				opacity: 1
				'font-size': '85%'
				'font-weight': 'bold'
				'text-anchor': 'middle'
			}
			.text ''

		tooltip_group_bottom.append 'text'
			.attr {
				class: 'mb-tooltip-country top'
				x: x.rangeBand()*0.5
				dy: '.35em'
				y: 10
				fill: '#fff'
				opacity: 1
				'font-size': '85%'
				'font-weight': 'bold'
				'text-anchor': 'middle'
			}
			.text ''

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

		# country labels
		top_countries.selectAll '.country-label'
			.data d3_array, key
			.transition()
			.duration 1000
			.attr 'transform', (d) ->
				return "translate(#{ 0.5 * x.rangeBand() }, #{ y(d.in_work.sum_perc) - 5 })"

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
		top_countries.selectAll '.rect'
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
		bottom_countries.selectAll '.rect'
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

	my.resize = ->

		# update the chart here
		svg = d3.select '.econ-country-svg'
		main_top_group = svg.select '.main-group-top'
		main_bottom_group = svg.select '.main-group-bottom'
		top_rect_group = svg.select '.top-group-rect'
		bottom_rect_group = svg.select '.bottom-group-rect'
		top_countries = main_top_group.selectAll '.country-g'
		bottom_countries = main_bottom_group.selectAll '.country-g'
		y_axis_top_group = svg.select '.y.y-top.axis'
		y_axis_bottom_group = svg.select '.y.y-bottom.axis'
		x_axis_divider_group = svg.select '.x-axis-divider'

		# rect background
		top_rect_group.select 'rect'
			.attr {
				width: chart_width
			}

		# top text label
		main_top_group.select 'text'
			.attr {
				x: chart_width * 0.5
			}

		# rect background
		bottom_rect_group.select 'rect'
			.attr {
				width: chart_width
			}

		# bottom text label
		main_bottom_group.select 'text'
			.attr {
				x: chart_width * 0.5
				y: chart_height * 0.5 - margin.label
			}

		# Add stacked bars
		top_countries.selectAll 'rect'
			.attr {
				width: x.rangeBand()
			}

		# country labels
		top_countries.selectAll '.country-label'
			.attr 'transform', (d) ->
				return "translate(#{ 0.5 * x.rangeBand() }, #{ y(d.in_work.sum_perc) - 5 })"

		# move country to new position
		top_countries
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"
		
		# move country to new position
		bottom_countries
			.attr 'transform', (d) ->
				return "translate(#{ x d.country }, 0)"

		# Add stacked bars
		bottom_countries.selectAll 'rect'
			.attr {
				width: x.rangeBand()
			}

		y_axis_top_group.call yAxisTop
		y_axis_bottom_group.call yAxisBottom

		# Draw line to divide both sets of bars
		x_axis_divider_group.select 'line'
			.attr {
				x2: chart_width

			}

		# Add mouse over handler
		attachHoverHandlers()

	attachHoverHandlers = ->

		hover_colour = '#ddd'
		rect_opacity = 0.7

		# update the chart here
		svg = d3.select '.econ-country-svg'
		countries = svg.selectAll '.country-g'
		main_top_group = svg.select '.main-group-top'
		main_bottom_group = svg.select '.main-group-bottom'
		top_rects = main_top_group.selectAll '.rect'
		bottom_rects = main_bottom_group.selectAll '.rect'

		# Top rects mouseover
		top_rects.on 'mouseover', (d) ->
			# console.log d
			_d = d
			$this = d3.select this
			$this.attr 'fill', hover_colour
			# update tooltip
			tooltip_group = main_top_group.select '.tooltip-group'
				.attr 'transform', "translate(#{ x(_d.country) },#{ y(_d.sum_perc) - (margin.tooltip_height + margin.p) })"

			tooltip_group.attr 'opacity', 1

			tooltip_group.select '.mb-tooltip'
				.text "#{ percFormat _d.value } - #{ format(_d.value * _d.sum) }"

			tooltip_group.select '.mb-tooltip-country'	
				.text trimEmploymentStatus _d.name

		.on 'mouseout', (d) ->
			$this = d3.select this
			$this.attr 'fill', (d) ->
				return in_work_colours d.name
			# update tooltip
			tooltip_group = main_top_group.select '.tooltip-group'
			tooltip_group.attr 'opacity', 0

		# Bottom rects mouseover
		bottom_rects.on 'mouseover', (d) ->
			# console.log d
			_d = d
			$this = d3.select this
			$this.attr 'fill', hover_colour
			# update tooltip
			tooltip_group = main_bottom_group.select '.tooltip-group'
				.attr 'transform', "translate(#{ x(d.country) - 3 },#{ y0(_d.sum_perc) + margin.p*0.5 })"
				.attr 'opacity', 1

			tooltip_group.select '.mb-tooltip'
				.text "#{ percFormat _d.value } - #{ format(_d.value * _d.sum) }"

			tooltip_group.select '.mb-tooltip-country'	
				.text trimEmploymentStatus _d.name

		.on 'mouseout', (d) ->
			$this = d3.select this
			$this.attr 'fill', (d) ->
				return out_of_work_colours d.name
			# update tooltip
			tooltip_group = main_bottom_group.select '.tooltip-group'
			tooltip_group.attr 'opacity', 0

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
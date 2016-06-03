# d3 = require 'd3'

drawGenHealthChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	my = {}

	width = $(container).width() ? 750
	height = $(container).height() ? 500

	# Set margins
	margin = 
		top: 20
		right: 80
		bottom: 20
		left: 45
		p: 25

	chart_width = width - margin.left - margin.right
	chart_height = height - margin.top - margin.bottom

	format = d3.format '.2s'
	percFormat = d3.format ',.0%'
	d3_array = data.percentages
	ethnic_groups = data.ethnicities
	ages = data.ages
	max_value = data.max_value
	max_perc = data.max_perc
	colour = d3.scale.category20()
		.domain ethnic_groups

	# Scales, axes and layouts
	x = d3.scale.ordinal()
		.domain ages
		.rangePoints [0, chart_width]

	y = d3.scale.linear()
		.domain [0, max_perc]
		.range [chart_height, 0]

	yAxis = d3.svg.axis()
		.scale y
		.tickFormat percFormat
		.ticks 6
		# .tickSize -chart_width
		.orient 'left'

	xAxis = d3.svg.axis()
		.scale x
		# .tickSize -chart_height
		.orient 'bottom'

	line = d3.svg.line()
		.interpolate 'cardinal'
		.x (d) ->
			return x d.key
		.y (d) ->
			return y d.values.bad

	my.init = ->

		# initialise the chart here

		# Create svg and g vars
		svg = d3.select '.gen-health-svg'
		main_group = svg.select '.main-group'
		x_axis_group = svg.select '.x.axis'
		y_axis_group = svg.select '.y.axis'
		title_group = svg.select '.title-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		x_axis_group.attr 'transform', "translate(#{ margin.left }, #{ chart_height + margin.top })"
		y_axis_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		title_group.attr 'transform', "translate(#{ chart_width / 2 - margin.left }, 0)"

		x_axis_group.call xAxis
		y_axis_group.call yAxis
		    .append "text"
		      .attr "transform", "rotate(-90)"
		      .attr "y", 6
		      .attr "dy", ".71em"
		      .style "text-anchor", "end"
		      .text "% of Population"

		ethnicity = main_group.selectAll '.ethnicity'
			.data d3_array
		  .enter().append 'g'
		  	.attr 'class', 'ethnicity'

		ethnicity.append 'path'
			.attr {
				class: 'line'
				d: (d) ->
					return line d.values
			}
			.style 'stroke', (d) ->
				return colour d.key

		ethnicity.append 'text'
			.attr {
				class: 'label'
				transform: (d) ->
					return "translate(#{ x d.values[d.values.length - 1].key }, #{ y d.values[d.values.length - 1].values.bad })"
				x: 3
				dy: '.35em'
				opacity: 0
			}
			.text (d) ->
				if d.key.indexOf('Gypsy') isnt -1
					trimmedStr = 'Gypsy'
				else if d.key.indexOf('English') isnt -1
					trimmedStr = 'British'
				else	
					str = d.key
					trimmedStr = str.substr(str.indexOf(':') + 2, str.length)
				return trimmedStr
			.transition()
			.duration 1750
			.attr 'opacity', 0.1

		# transition lines by using a white rect and shrinking to the right, then removing
		main_group.append 'rect'
			.attr {
				x: 0
				y: 0
				width: chart_width
				height: chart_height
				class: 'init-transition-rect'
				fill: '#FFF'
			}
			.transition()
			.duration 1500
			.attr {
				width: 0
				x: chart_width
			}
			.remove()

		title_group.append 'text'
			.attr {
				x: 0
				y: margin.p
				opacity: 0
				'font-size': '12px'
			}
			.text 'Self-proclaimed bad or very bad health'
			.transition()
			.duration 1500
			.attr 'opacity', 1

		# Add mouse over handler
		attachHoverHandlers()

	my.update = ->

		# update the chart here
		svg = d3.select '.gen-health-svg'
		main_group_lines = svg.selectAll '.main-group path'
		labels = svg.selectAll '.label'
		x_axis_group = svg.select '.x.axis'
		y_axis_group = svg.select '.y.axis'
		# detail_text_value = svg.select '.detail-text-value'

		main_group_lines.data d3_array
			.transition()
			.duration 1000
			.delay 500
			.attr 'd', (d) ->
				return line d.values

		labels.data d3_array
			.transition()
			.duration 1000
			.delay 500
			.attr {
				transform: (d) ->
					return "translate(#{ x d.values[d.values.length - 1].key }, #{ y d.values[d.values.length - 1].values.bad })"
			}

		x_axis_group.transition()
			.duration 1000
			.delay 500
			.call xAxis

		y_axis_group.transition()
			.duration 1000
			.delay 500
			.call yAxis

		# Add mouse over handler
		attachHoverHandlers()

	attachHoverHandlers = ->

		# update the chart here
		svg = d3.select '.gen-health-svg'
		main_group_lines = svg.selectAll '.main-group path'
		labels = svg.selectAll '.label'

		main_group_lines.on 'mouseover', (d) ->

			# set opacity of arcs
			_d = d
			# onMouseOver d

			main_group_lines.attr 'opacity', (d) ->

				unless _d is d
					return 0.1
				else
					return 1

			labels.attr 'opacity', (d) ->

				unless _d is d
					return 0.05
				else
					return 1

		.on 'mouseout', (d) ->

			main_group_lines.attr 'opacity', 1
			labels.attr 'opacity', 0.1

			# onMouseOver {
			# 	key: 'All'
			# 	values: []
			# }

	my.width = (value) ->
		unless arguments.length then return width
		width = value
		return my

	my.height = (value) ->
		unless arguments.length then return height
		height = value
		return my

	return my

module.exports = drawGenHealthChart
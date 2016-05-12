d3 = require 'd3'

drawBarChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	my = {}

	width = container.offsetWidth ? 750
	height = container.offsetHeight ? 500

	# Set margins
	margin = 
		top: 40
		right: 40
		bottom: 10
		left: 70

	chart_width = width - margin.left - margin.right
	chart_height = height - margin.top - margin.bottom

	format = d3.format '.2s'
	d3_array = data.d3_array

	# Scales and axes
	y = d3.scale.ordinal()
		.domain d3_array.map (d) ->
			return d.name
		.rangeRoundBands [0, chart_height], 0.1

	x = d3.scale.linear()
		.domain [0, d3.max d3_array, (d) ->
			return d.value
		]
		.range [0, chart_width]

	xAxis = d3.svg.axis()
		.scale x
		.tickSize(-chart_height - margin.bottom)
		.tickFormat format
		.ticks 10
		.orient 'top'

	key = (d) ->
		return d.name

	my.init = ->

		# initialise the chart here

		# Create svg and g vars
		svg = d3.select '.bars-svg'
		main_group = svg.select '.main-group'
		labels_group = svg.select '.labels-group'
		x_axis_group = svg.select '.x.axis'

		# Transforms
		main_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		labels_group.attr 'transform', "translate(#{ margin.left - 10 }, #{ margin.top + 22 })"
		x_axis_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"

		bar = main_group.selectAll 'rect'
			.data d3_array, key

		barsEnter = bar.enter()
			.append 'rect'
			.attr {

				width: (d) ->
					return x d.value
				height: ->
					return y.rangeBand()
				y: (d, i) ->
					return y d.name
				x: 0
				class: 'bar'
				rx: 4

			}

		labels_group.selectAll 'text'
			.data d3_array, key
		  .enter().append 'text'
		  	.text (d) ->
		  		return d.name
			.style 'text-anchor', 'end'
		  	.attr 'y', (d, i) ->
		  		return y d.name
		  	.attr 'class', 'rel-label'

		x_axis_group.call xAxis

	my.update = ->

		# update the chart here
		svg = d3.select '.bars-svg'
		main_group_bars = svg.selectAll '.main-group .bar'
		labels_group_labels = svg.selectAll '.labels-group text'
		x_axis_group = svg.select '.x.axis'

		main_group_bars.data d3_array, key
			.transition()
			.duration 1000
			.attr 'width', (d) ->
				return x d.value
			.attr 'y', (d, i) ->
				return y d.name

		labels_group_labels.data d3_array, key
			.transition()
			.duration 1000
			.attr 'y', (d, i) ->
				return y d.name

		x_axis_group.transition()
			.duration 1000
			.call xAxis

	my.width = (value) ->
		unless arguments.length then return width
		width = value
		return my

	my.height = (value) ->
		unless arguments.length then return height
		height = value
		return my

	return my

module.exports = drawBarChart
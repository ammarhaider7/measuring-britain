d3 = require 'd3'

drawBarChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	my = {}

	width = container.offsetWidth ? 750
	height = container.offsetHeight ? 500

	# Set margins
	margin = 
		top: 10
		right: 0
		bottom: 10
		left: 30

	chart_width = width - margin.left - margin.right
	chart_height = height - margin.top - margin.bottom

	# Scales and axes
	y = d3.scale.ordinal()
		.domain d3.range(data.d3_array.length)
		.rangeRoundBands [0, chart_height], 0.1

	x = d3.scale.linear()
		.domain [0, data.sum]
		.range [0, chart_width]

	xAxis = d3.svg.axis()
		.scale x
		.orient 'top'

	my.init = ->

		# initialise the chart here

		# Create svg and g vars
		svg = d3.select '.bars-svg'
		main_group = svg.select '.main-group'
		labels_group = svg.select '.labels-group'
		x_axis_group = svg.select '.x-axis-group'
		y_axis_group = svg.select '.y-axis-group'
		key_group = svg.select '.key-group'
		key_text_group = svg.select '.key-text-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"

		key = (d) ->

			return d.name

		bar = main_group.selectAll 'rect'
			.data data.d3_array, key

		barsEnter = bar.enter()
			.append 'rect'
			.attr {

				width: (d) ->
					return x d.value
				height: ->
					return y.rangeBand()
				y: (d, i) ->
					return y i
				x: 0

			}

	my.update = ->

		# update the chart here

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
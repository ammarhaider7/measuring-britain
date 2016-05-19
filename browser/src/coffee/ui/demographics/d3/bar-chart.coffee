# d3 = require 'd3'

drawBarChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	my = {}

	width = $(container).width() ? 1140
	height = $(container).height() ? 500

	# Set margins
	margin = 
		top: 40
		right: 40
		bottom: 10
		left: 70
		p: 25

	chart_width = width - margin.left - margin.right
	chart_height = height - margin.top - margin.bottom

	format = d3.format '.2s'
	percFormat = d3.format ',.1%'
	d3_array = data.d3_array

	# Scales and axes
	y = d3.scale.ordinal()
		.domain d3_array.map (d) ->
			return d.name
		.rangeRoundBands [0, chart_height], 0.05

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

	# key fn enables object constancy
	key = (d) ->
		return d.name

	my.init = ->

		# initialise the chart here

		# Create svg and g vars
		svg = d3.select '.bars-svg'
		main_group = svg.select '.main-group'
		labels_group = svg.select '.labels-group'
		x_axis_group = svg.select '.x.axis'
		detail_group = svg.select '.detail-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		labels_group.attr 'transform', "translate(#{ margin.left - 10 }, #{ margin.top + 22 })"
		x_axis_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		detail_group.attr 'transform', "translate(#{ (chart_width / 3) * 2 }, #{ (chart_height / 2) + margin.top })"

		bar = main_group.selectAll 'rect'
			.data d3_array, key

		barsEnter = bar.enter()
			.append 'rect'
			.attr {

				width: 0
				height: ->
					return y.rangeBand()
				y: (d, i) ->
					return y d.name
				x: 0
				class: 'bar'
				rx: 4

			}
			.transition()
			.duration 1500
			.attr 'width', (d) ->
				return x d.value

		labels_group.selectAll 'text'
			.data d3_array, key
		  .enter().append 'text'
		  	.attr 'opacity', 0
		  	.text (d) ->
		  		return d.name
			.style 'text-anchor', 'end'
		  	.attr 'y', (d, i) ->
		  		return y d.name
		  	.attr 'class', 'rel-label'
		  	.transition()
		  	.duration 1500
		  	.attr 'opacity', 1

		x_axis_group.transition()
			.duration 1500
			.call xAxis

		detail_width = chart_width - ((chart_width / 3) * 2)
		detail_height = (chart_height / 2) - margin.top

		detail_group.append 'rect'
			.attr {

				width: detail_width
				height: detail_height
				y: 0
				x: 0
				rx: 4
				fill: '#F3F3F3'
				stroke: '#E6E6E6'

			}

		detail_group.append 'text'
			.attr {

				x: (detail_width / 2)
				y: (detail_height / 2) - margin.p
				class: 'detail-text-religion'

			}
			.text 'Total'

		detail_group.append 'text'
			.attr {

				x: (detail_width / 2)
				y: (detail_height / 2) + margin.p
				class: 'detail-text-value'

			}
			.text format data.sum

		detail_group.append 'text'
			.attr {

				x: (detail_width / 2)
				y: (detail_height / 2) + margin.p * 2
				class: 'detail-text-percent'

			}
			.text '100%'

		# Add mouse over handler
		attachHoverHandlers()

	my.update = ->

		# update the chart here
		svg = d3.select '.bars-svg'
		main_group_bars = svg.selectAll '.main-group .bar'
		labels_group_labels = svg.selectAll '.labels-group text'
		x_axis_group = svg.select '.x.axis'
		detail_text_value = svg.select '.detail-text-value'

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

		# reset detail content
		detail_text_value.text format data.sum

		# Add mouse over handler
		attachHoverHandlers()

	attachHoverHandlers = ->

		# update the chart here
		svg = d3.select '.bars-svg'
		main_group_bars = svg.selectAll '.main-group .bar'
		detail_text_religion = svg.select '.detail-text-religion'
		detail_text_value = svg.select '.detail-text-value'
		detail_text_percent = svg.select '.detail-text-percent'

		main_group_bars.on 'mouseover', (d) ->

	 		# set opacity of arcs
	 		_d = d

	 		main_group_bars.attr 'opacity', (d) ->

 				unless _d is d
 					return 0.3

 			detail_text_religion.text d.name
 			detail_text_value.text format d.value
 			detail_text_percent.text percFormat d.value / data.sum

 		.on 'mouseout', (d) ->

 			main_group_bars.attr 'opacity', 1

 			# reset detail content
 			detail_text_religion.text 'Total'
 			detail_text_value.text format data.sum
 			detail_text_percent.text '100%'

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
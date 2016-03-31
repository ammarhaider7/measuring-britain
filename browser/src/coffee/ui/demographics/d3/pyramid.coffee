window.d3 = require 'd3'

drawPyramid = (options) ->
	
	{ container, 
	  ages, 
	  bar_males,
	  bar_males_perc,
	  bar_females,
	  bar_females_perc,
	  outline_males,
	  outline_females 
	 } = options

	width = container.offsetWidth ? 750
	height = container.offsetHeight ? 500

	my = ->

		# generate chart here, using the options
		margin = 
			top: 25
			right: 50
			bottom: 75
			left: 50
			middle: 25

		format = d3.format ','
		percFormat = d3.format '.0f'

		#SCALES AND AXES
		x = (data) ->
		  d3.scale.linear()
		  .domain [0, d3.max data, (d) ->
		      return d 
		  ]
		  .range [0, (width / 2) - margin.middle]

		xLeft = (data) ->
		  d3.scale.linear().domain([
		    d3.max(data, (d) ->
		      return d
		    ), 0])
		  .range [0, (width / 2) - margin.middle]

		y = (data) ->
		  d3.scale.ordinal()
		  .domain d3.range(data.length)
		  .rangeRoundBands [0, height - margin.bottom]

		xAxis = (data) ->
		  d3.svg.axis()
		  .scale(x(data))
		  .orient('bottom')
		  .ticks(5)
		  .tickFormat d3.format(',.1%')

		xAxisLeft = (data) ->
		  d3.svg.axis()
		  .scale(xLeft(data))
		  .orient('bottom')
		  .ticks(5)
		  .tickFormat d3.format(',.1%')

		# Create svg and g elements
		svg = d3.select '.pyramid-svg'
		g = d3.select '.main-group'
		rightGroup = d3.select '.right-group'
		leftGroup = d3.select '.left-group'
		overlayGroup = d3.select '.overlay-group'
		ticksGroup = d3.select '.ticks-group'

		# Perform transforms on g elements
		g.attr "transform", "translate(0, #{ margin.top })"
		overlayGroup.attr "transform", "translate(#{ margin.left }, #{ margin.top })"
		leftGroup.attr "transform", "translate(0, #{ margin.top })"
		rightGroup.attr "transform", "translate(#{ (width / 2) + margin.middle }, #{ margin.top })"
		ticksGroup.attr "transform", "translate(#{ (width / 2) }, #{ margin.top / 2.5 })"

		# Build right-side bars
		rightGroup.selectAll 'rect'
			.data bar_males_perc
			.enter()
			.append 'rect'
			.attr {
				width: (d) ->
					return x(bar_males_perc)(d)
				height: () ->
					return y(bar_males_perc).rangeBand()
				fill: 'rgb(31, 119, 180)'
				stroke: 'rgb(17, 107, 169)'
				x: 0
				y: (d, i) ->
					return y(bar_males_perc)(i)
				rx: 1
				ry: (d, i) ->
					return y(bar_males_perc)(i) + 1
				class: 'pyramid-bar'
			}

		# Build left-side bars
		leftGroup.selectAll 'rect'
			.data bar_females_perc
			.enter()
			.append 'rect'
			.attr {
				width: (d) ->
					return x(bar_females_perc)(d)
				height: () ->
					return y(bar_females_perc).rangeBand()
				fill: 'rgb(255, 152, 150)'
				stroke: 'rgb(250, 133, 131)'
				x: (d) ->
					return xLeft(bar_females_perc)(d)
				y: (d, i) ->
					return y(bar_females_perc)(i)
				rx: 1
				ry: (d, i) ->
					return y(bar_females_perc)(i) + 1
				class: 'pyramid-bar'
			}


	my.width = (value) ->
		unless arguments.length then return width
		width = value
		my

	my.height = (value) ->
		unless arguments.length then return height
		height = value
		my

	return my

module.exports = drawPyramid
d3 = require 'd3'
$ = require 'jquery'

drawPyramid = (options) ->

	{ container
	  ages
	  bar_males
	  bar_males_perc
	  bar_males_perc_format
	  bar_males_sum
	  bar_females
	  bar_females_perc
	  bar_females_perc_format
	  bar_females_sum
	  outline_males
	  outline_females
	  outline_males_perc
	  outline_males_perc_format
	  outline_males_sum
	  outline_females_perc
	  outline_females_perc_format
	  outline_females_sum
	  overlay_data
	  onMouseOver
	  onFirstLineDrawn
	  isDefault
	  outlineFilter
	  updatePyramid
	  updateOutline
	  activeLineValue
	  activeLineCategory
	  isFirstLine
	  resize
	 } = options

	width = $(container).width() ? 750
	height = $(container).height() ? 570

	# Check if we need to draw an outline
	isOutline = outlineFilter

	# Set margins
	margin = 
		top: 25
		right: 50
		bottom: 75
		left: 50
		middle: 25

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
	  .rangeBands [0, height - margin.bottom]

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

	# Create svg and g vars
	svg = d3.select '.pyramid-svg'
	g = svg.select '.main-group'
	rightGroup = svg.select '.right-group'
	leftGroup = svg.select '.left-group'
	overlayGroup = svg.select '.overlay-group'
	ticksGroup = svg.select '.ticks-group'
	xAxisGroupLeft = svg.select '.x.axis.left'
	xAxisGroupRight = svg.select '.x.axis.right'
	titleGroup = svg.select '.title-group'
	keyGroup = svg.select '.key-group'
	maleKeyGroup = keyGroup.select '.male-key-group'
	femaleKeyGroup = keyGroup.select '.female-key-group'

	my = ->

		# Catch and handle resize immediately
		if resize is yes
			
			return resizePyramid()

		# generate chart here
		if isDefault is yes

			init()

			if isOutline is yes and updateOutline is yes then drawOutline()

			return

		else if isDefault is no

			update()

			outlineDataReceived = outline_males_perc?

			# if isOutline is yes and updateOutline is yes then drawOutline()
			if isOutline is yes and updateOutline is yes and outlineDataReceived is yes then drawOutline()

			return

	init = ->

		format = d3.format ','
		percFormat = d3.format '.0f'
		maxFemalePerc = d3.max bar_females_perc

		# Perform transforms on g elements
		g.attr "transform", "translate(0, #{ margin.top })"
		overlayGroup.attr "transform", "translate(0, #{ margin.top })"
		leftGroup.attr "transform", "translate(0, #{ margin.top })"
		rightGroup.attr "transform", "translate(#{ (width / 2) + margin.middle }, #{ margin.top })"
		ticksGroup.attr "transform", "translate(#{ (width / 2) }, #{ margin.bottom - 5 })"
		xAxisGroupLeft.attr "transform", "translate(#{ -(width / 2) }, #{ height - (margin.bottom + 15) })"
		xAxisGroupRight.attr "transform", "translate(#{ margin.middle }, #{ height - (margin.bottom + 15) })"
		titleGroup.attr "transform", "translate(#{ 0.25 * width }, #{ margin.top - 10 })"
		keyGroup.attr "transform", "translate(#{ width - margin.right * 3 }, #{  margin.top })"
		maleKeyGroup.attr "transform", "translate(70, 0)"

		# Create title for pyramid
		titleGroup.append('text')
			.text 'Males \& Females, by 5 year age bands, as % of the population'
			.attr 'class', 'mb-oxygen'
			.style 'font-size', '12px'

		# Create keys
		maleKeyGroup.append 'rect'
			.attr {
				width: 15
				height: 15
				fill: 'rgb(31, 119, 180)'
				x: 0
				y: 0
			}

		maleKeyGroup.append 'text'
			.text 'Males'
			.style 'text-anchor', 'middle'
			.style 'font-size', 12
			.attr {
				x: 35
				y: 12
				class: 'mb-oxygen'
			}

		femaleKeyGroup.append 'rect'
			.attr {
				width: 15
				height: 15
				fill: 'rgb(255, 152, 150)'
				x: 0
				y: 0
			}

		femaleKeyGroup.append 'text'
			.text 'Females'
			.style 'text-anchor', 'middle'
			.style 'font-size', 12
			.attr {
				x: 40
				y: 12
				class: 'mb-oxygen'
			}

		# Build right-side bars
		rightGroup.selectAll 'rect'
			.data bar_males_perc
		  .enter().append 'rect'
			.attr {
				opacity: 0
				width: 0
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
				class: 'pyramid-bar right'
			}
			.transition()
			.duration 1500
			.attr {
				opacity: 1
				width: (d) ->
					return x(bar_males_perc)(d)
			}

		# Build left-side bars
		leftGroup.selectAll 'rect'
			.data bar_females_perc
		  .enter().append 'rect'
			.attr {
				opacity: 0
				width: 0
				height: () ->
					return y(bar_females_perc).rangeBand()
				fill: 'rgb(255, 152, 150)'
				stroke: 'rgb(250, 133, 131)'
				x: x(bar_females_perc)(maxFemalePerc)
				y: (d, i) ->
					return y(bar_females_perc)(i)
				rx: 1
				ry: (d, i) ->
					return y(bar_females_perc)(i) + 1
				class: 'pyramid-bar left'
			}
			.transition()
			.duration 1500
			.attr {
				opacity: 1
				width: (d) ->
					return x(bar_females_perc)(d)
				x: (d) ->
					return xLeft(bar_females_perc)(d)
			}

		# Create ages ticks
		ticksGroup.selectAll 'text'
			.data ages
		  .enter().append 'text'
		  	.attr 'opacity', 0
			.attr 'y', (d, i) ->
				return y(bar_males_perc)(i)
			.style 'text-anchor', 'middle'
			.style 'font-size', '12px'
		  	.transition()
		  	.duration 1500
			.text (d) ->
				return d
			.attr 'opacity', 1

		agesTitle = d3.select('.ages')[0][0]

		unless agesTitle?
			ticksGroup
				.append 'text'
				.style 'text-anchor', 'middle'
				.style 'font-size', '12px'
				.style 'font-weight', 'bold'
				.attr {
					y: -margin.top
					class: 'ages'
					opacity: 0
				}
			  	.transition()
			  	.duration 1500
				.text 'Ages'
				.attr 'opacity', 1

		# Add x axes
		xAxisGroupLeft.call xAxisLeft(bar_females_perc_format)
		xAxisGroupRight.call xAxis(bar_males_perc_format)

		# Create overlay rects for interactivity
		overlayGroup.selectAll 'rect'
			.data overlay_data
			.enter()
			.append 'rect'
			.attr {
				width: width
				height: (d) ->
					y(bar_males).rangeBand()
				fill: 'rgba(0,0,0,0)'
				y: (d, i) ->
					y(bar_males)(i) + margin.top
				class: 'overlay-rect'
			}

		# Dispatch mouseover action and pass along data
		d3.selectAll '.overlay-rect'
			.on 'mouseover', (d) ->
				onMouseOver d

		# Dispatch the initial values for the bars
		onMouseOver {
			age: 'All Ages'
			females: bar_females_sum
			males: bar_males_sum
			initial: yes
		}

	update = ->

		# Check if outline is needed
		outlineDataReceived = outline_males_perc?

		# Calculate max value for scales if there is outline data
		if outlineDataReceived is yes
			max_female_outline_perc = d3.max outline_females_perc
			max_female_bars_perc = d3.max bar_females_perc
			max_male_outline_perc = d3.max outline_males_perc
			max_male_bars_perc = d3.max bar_males_perc
			left_scale_bars_data = if max_female_outline_perc > max_female_bars_perc then outline_females_perc else bar_females_perc
			right_scale_bars_data = if max_male_outline_perc > max_male_bars_perc then outline_males_perc else bar_males_perc
			left_scale_axis_data = if max_female_outline_perc > max_female_bars_perc then outline_females_perc_format else bar_females_perc_format
			right_scale_axis_data = if max_male_outline_perc > max_male_bars_perc then outline_males_perc_format else bar_males_perc_format
		else
			left_scale_axis_data = bar_females_perc_format
			right_scale_axis_data = bar_males_perc_format
			left_scale_bars_data = bar_females_perc
			right_scale_bars_data = bar_males_perc

		svg = d3.select '.pyramid-svg'
		leftBars = svg.selectAll '.pyramid-bar.left'
		rightBars = svg.selectAll '.pyramid-bar.right'
		overlayBars = svg.selectAll '.overlay-rect'
		xAxisGroupLeft = svg.select '.x.axis.left'
		xAxisGroupRight = svg.select '.x.axis.right'

		# Update bars
		leftBars.data bar_females_perc
			.transition()
			.duration 1000
			.delay 500
		  	.attr {
				width: (d) ->
					return x(left_scale_bars_data)(d)
				x: (d) ->
					return xLeft(left_scale_bars_data)(d)
		  	}

		rightBars.data bar_males_perc
			.transition()
			.duration 1000
			.delay 500
			.attr {
				width: (d) ->
					return x(right_scale_bars_data)(d)
			}

		# Update data associated with overlay rects
		overlayBars.data overlay_data

		# Update the axes
		xAxisGroupLeft.transition()
			.duration 1000
			.delay 500
			.call xAxisLeft left_scale_axis_data

		xAxisGroupRight.transition()
			.duration 1000
			.delay 500
			.call xAxis right_scale_axis_data	

		# Dispatch the initial values for the bars
		onMouseOver {
			age: 'All Ages'
			females: bar_females_sum
			males: bar_males_sum
			initial: null
		}

	drawOutline = ->

		# Calculate max value for scales
		max_female_outline_perc = d3.max outline_females_perc
		max_female_bars_perc = d3.max bar_females_perc
		max_male_outline_perc = d3.max outline_males_perc
		max_male_bars_perc = d3.max bar_males_perc
		left_scale_bars_data = if max_female_outline_perc > max_female_bars_perc then outline_females_perc else bar_females_perc
		right_scale_bars_data = if max_male_outline_perc > max_male_bars_perc then outline_males_perc else bar_males_perc

		malesLine = d3.svg.line()
			.interpolate 'step-before'
			.x (d) ->
				return x(right_scale_bars_data)(d)
			.y (d, i) ->
				if i is right_scale_bars_data.length
					return y(right_scale_bars_data).rangeExtent()[1]
				else
					return y(right_scale_bars_data)(i)

		femalesLine = d3.svg.line()
			.interpolate 'step-before'
			.x (d) ->
				return xLeft(left_scale_bars_data)(d)
			.y (d, i) ->
				if i is left_scale_bars_data.length
					return y(left_scale_bars_data).rangeExtent()[1]
				else
					return y(left_scale_bars_data)(i)

		if isFirstLine is no

			svg = d3.select '.pyramid-svg'
			malesChartLine = svg.select '.males-outline'
			femalesChartLine = svg.select '.females-outline'

			malesChartLine.transition()
				.duration 1000
				.delay 500
				.attr {
					d: malesLine outline_males_perc.concat [outline_males_perc[outline_males_perc.length - 1]]
				}

			femalesChartLine.transition()
				.duration 1000
				.delay 500
				.attr {
					d: femalesLine outline_females_perc.concat [outline_females_perc[outline_females_perc.length - 1]]
				}

		else

			malesChartLine = rightGroup.append 'path'
				.attr 'opacity', 0
				.transition()
				.duration 500
				.delay 500
				.attr {
					class: 'males-outline'
					d: malesLine outline_males_perc.concat [outline_males_perc[outline_males_perc.length - 1]]
					opacity: 1
				}

			femalesChartLine = leftGroup.append 'path'
				.attr 'opacity', 0
				.transition()
				.duration 500
				.delay 500
				.attr {
					class: 'females-outline'
					d: femalesLine outline_females_perc.concat [outline_females_perc[outline_females_perc.length - 1]]
					opacity: 1
				}

			# Dispatch action to let state know first line has been drawn..
			onFirstLineDrawn()

		return		

	resizePyramid = ->

		svg = d3.select '.pyramid-svg'
		leftBars = svg.selectAll '.pyramid-bar.left'
		rightBars = svg.selectAll '.pyramid-bar.right'
		overlayBars = svg.selectAll '.overlay-rect'
		xAxisGroupLeft = svg.select '.x.axis.left'
		xAxisGroupRight = svg.select '.x.axis.right'

		# Perform transforms on g elements
		g.attr "transform", "translate(0, #{ margin.top })"
		overlayGroup.attr "transform", "translate(0, #{ margin.top })"
		leftGroup.attr "transform", "translate(0, #{ margin.top })"
		rightGroup.attr "transform", "translate(#{ (width / 2) + margin.middle }, #{ margin.top })"
		ticksGroup.attr "transform", "translate(#{ (width / 2) }, #{ margin.bottom - 5 })"
		xAxisGroupLeft.attr "transform", "translate(#{ -(width / 2) }, #{ height - (margin.bottom + 15) })"
		xAxisGroupRight.attr "transform", "translate(#{ margin.middle }, #{ height - (margin.bottom + 15) })"
		titleGroup.attr "transform", "translate(#{ 0.25 * width }, #{ margin.top - 10 })"
		keyGroup.attr "transform", "translate(#{ width - margin.right * 3 }, #{  margin.top })"
		maleKeyGroup.attr "transform", "translate(70, 0)"

		svg = d3.select '.pyramid-svg'
		leftBars = svg.selectAll '.pyramid-bar.left'
		rightBars = svg.selectAll '.pyramid-bar.right'
		overlayBars = svg.selectAll '.overlay-rect'
		xAxisGroupLeft = svg.select '.x.axis.left'
		xAxisGroupRight = svg.select '.x.axis.right'

		# Update bars
		leftBars.data bar_females_perc
		  	.attr {
				width: (d) ->
					return x(bar_females_perc)(d)
				x: (d) ->
					return xLeft(bar_females_perc)(d)
		  	}

		rightBars.data bar_males_perc
			.attr {
				width: (d) ->
					return x(bar_males_perc)(d)
			}

		# Update data associated with overlay rects
		overlayBars.data overlay_data

		# Update the axes
		xAxisGroupLeft.call xAxisLeft bar_females_perc_format

		xAxisGroupRight.call xAxis(bar_males_perc_format)

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
drawDisabilityChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	# Actual chart code
	my = {}

	width = $(container).width() ? 1140
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
	d3_array = data.sorted_percentages
	ethnicities = data.sorted_ethnicities
	ages = data.ages
	colour = d3.scale.ordinal()
    	.range ["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c"]
    	.domain ages

	# Scales, axes and layouts
	x0 = d3.scale.ordinal()
		.domain ethnicities
		.rangeRoundBands [0, chart_width], 0.05

	x1 = d3.scale.ordinal()
		.domain ages
		.rangeRoundBands [0, x0.rangeBand()]

	y = d3.scale.linear()
		.domain [0, 0.55]
		.range [chart_height, 0]

	xAxis = d3.svg.axis()
		.scale x0
		.orient 'bottom'

	yAxis = d3.svg.axis()
		.scale y
		.tickSize -chart_width
		.tickFormat percFormat
		.orient 'left'

	trimEthnicity = (ethnicity_string) ->

		if ethnicity_string.indexOf('Gypsy') isnt -1
			trimmedStr = 'Gypsy'
			return trimmedStr
		else if ethnicity_string.indexOf('White and Black Caribbean') isnt -1
			trimmedStr = 'White/Carribean'
			return trimmedStr
		else if ethnicity_string.indexOf('White and Black African') isnt -1
			trimmedStr = 'White/African'
			return trimmedStr
		else if ethnicity_string.indexOf('English') isnt -1
			trimmedStr = 'British'
			return trimmedStr
		else if ethnicity_string.indexOf('Any other') isnt -1
			trimmedStr = 'Any other'
			return trimmedStr
		else if ethnicity_string.indexOf('Arab') isnt -1
			trimmedStr = 'Arab'
			return trimmedStr
		else if ethnicity_string.indexOf('and') isnt -1
			str = ethnicity_string.replace ' and ', '/'
			trimmedStr = str.substr(str.indexOf(':') + 2, str.length)
			return trimmedStr
		else
			str = ethnicity_string
			trimmedStr = str.substr(str.indexOf(':') + 2, str.length)
			return trimmedStr

	xAxis.tickFormat trimEthnicity

	my.init = ->

		# Create svg and g vars
		svg = d3.select '.disability-svg'
		main_group = svg.select '.main-group'
		x_axis_group = svg.select '.x.axis'
		y_axis_group = svg.select '.y.axis'
		title_group = svg.select '.title-group'
		legend_group = svg.select '.legend-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		x_axis_group.attr 'transform', "translate(#{ margin.left }, #{ chart_height + margin.top })"
		y_axis_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		title_group.attr 'transform', "translate(#{ chart_width / 2 + margin.left }, 0)"
		legend_group.attr 'transform', "translate(#{ chart_width - margin.p }, #{ margin.top })"

		# Create axes
		x_axis_group.call xAxis
		y_axis_group.call yAxis
		    .append "text"
		      .attr "transform", "rotate(-90)"
		      .attr "y", 6
		      .attr "dy", ".71em"
		      .style "text-anchor", "end"
		      .text "% of Population"

		# Create ethnicity groups to house lines, points and labels
		ethnicity = main_group.selectAll '.ethnicity'
			.data d3_array
		  .enter().append 'g'
		  	.attr {
		  		class: 'ethnicity'
		  		transform: (d) ->
		  			return "translate(#{ x0 d.key }, 0)"
		  	}

		ethnicity.selectAll 'rect'
			.data (d) ->
				return d.values
			.enter().append 'rect'
		  	.attr {
		  		width: x1.rangeBand()
		  		x: (d) ->
		  			return x1 d.key
		  		y: chart_height
		  		height: 0
		  		rx: 3
		  		fill: (d) ->
		  			colour d.key
		  		class: 'rect'
 		  	}
 		  	.transition()
 		  	.duration 1500
 		  	.attr {
		  		y: (d) ->
		  			return y d.values.limited_a_lot
		  		height: (d) ->
 		  			return chart_height - y d.values.limited_a_lot
 		  	}

 		# create tooltip groups
		tooltip_groups = ethnicity.append 'g'
 			.attr 'class', 'tooltip-group'

 		# tooltip backgrounds
		tooltip_groups.append 'rect'
			.attr {
				class: 'tooltip-bg'
				width: x0.rangeBand() + margin.p + 5
				height: '42px'
				fill: '#333'
				x: -10
				y: y 0.3
				opacity: 0
				rx: 6
			}

		# toolip percentage labels
		tooltip = tooltip_groups.append 'text'
			.attr {
				class: 'mb-tooltip'
				transform: (d) ->
					return "translate(#{ x0.rangeBand() / 2 }, #{ y 0.3 })"
				x: 5
				dy: '.35em'
				y: margin.p + 5
				fill: '#FF8C00'
				opacity: 0
				'font-size': '75%'
				'font-weight': 'bold'
				'text-anchor': 'middle'
			}
			.text ''

		# tooltip age labels
		tooltip_age = tooltip_groups.append 'text'
			.attr {
				class: 'mb-tooltip-age'
				transform: (d) ->
					return "translate(#{ x0.rangeBand() / 2 }, #{ y 0.3 })"
				x: 5
				dy: '.35em'
				y: margin.p / 2
				fill: '#FFF'
				opacity: 0
				'font-size': '75%'
				'font-weight': 'bold'
				'text-anchor': 'middle'
			}
			.text ''

		# Chart legend
		legend = legend_group.selectAll '.legend'
			.data ages
		  .enter().append 'g'
			.attr {
				class: 'legend'
				transform: (d, i) ->
					return "translate(0, #{ i * 20 })"
			}

		legend.append 'rect'
			.attr {
				rx: 3
				x: 18
				width: 18
				height: 18
				fill: (d) ->
					return colour d
			}

		legend.append 'text'
			.attr {
				class: 'legend-text'
				x: 0
				y: 9
				dy: '0.35em'
				'text-anchor': 'end'
			}
			.text (d) ->
				return d

		# chart title
		title_group.append 'text'
			.attr {
				x: 0
				y: margin.p
				opacity: 0
				'font-size': '12px'
			}
			.style "text-anchor", "middle"
			.text 'Long-term illness / disability by ethinicity'
			.transition()
			.duration 1500
			.attr 'opacity', 1

		# Fix x ticks
		ticks = svg.selectAll '.x .tick text'
		ticks.each (d, i) ->
			if i % 2 is 0
				d3.select(this).attr 'y', '20'

		# Add mouse over handler
		attachHoverHandlers()

	my.update = ->

		# update the chart here
		svg = d3.select '.disability-svg'
		groups = svg.selectAll '.ethnicity'
		x_axis_group = svg.select '.x.axis'
		y_axis_group = svg.select '.y.axis'

		groups.data d3_array

		groups.selectAll 'rect'
			.data (d) ->
				return d.values
			.transition()
			.duration 1000
			.delay 500
		  	.attr {
		  		y: (d) ->
		  			return y d.values.limited_a_lot
		  		height: (d) ->
		  			return chart_height - y d.values.limited_a_lot
 		  	}

		# Add mouse over handler
		attachHoverHandlers() 

	attachHoverHandlers = ->

		# update the chart here
		svg = d3.select '.disability-svg'
		rects = svg.selectAll '.rect'

		rects.on 'mouseover', (d) ->

			_rect = d3.select @
			$raw_rect_el = $ _rect[0]
			raw_g_el = $raw_rect_el.parent()[0]
			_g = d3.select raw_g_el
			tooltip_group = _g.select '.tooltip-group'
			tooltip_bg = tooltip_group.select '.tooltip-bg'
			tooltip = _g.select '.mb-tooltip'
			tooltip_age= _g.select '.mb-tooltip-age'
			_rect.attr 'opacity', 0.7

			tooltip_bg.attr 'opacity', 0.8

			tooltip_age.attr 'opacity', 1
				.text d.key

			tooltip.attr 'opacity', 1
				.text percFormat d.values.limited_a_lot

		.on 'mouseout', (d) ->

			_rect = d3.select @
			$raw_rect_el = $ _rect[0]
			raw_g_el = $raw_rect_el.parent()[0]
			_g = d3.select raw_g_el
			tooltip_group = _g.select '.tooltip-group'
			tooltip_bg = tooltip_group.select '.tooltip-bg'
			tooltip_age= _g.select '.mb-tooltip-age'
			tooltip = _g.select '.mb-tooltip'

			_rect.attr 'opacity', 1

			tooltip_bg.attr 'opacity', 0

			tooltip_age.attr 'opacity', 0

			tooltip.attr 'opacity', 0

	my.width = (value) ->
		unless arguments.length then return width
		width = value
		return my

	my.height = (value) ->
		unless arguments.length then return height
		height = value
		return my

	return my

module.exports = drawDisabilityChart
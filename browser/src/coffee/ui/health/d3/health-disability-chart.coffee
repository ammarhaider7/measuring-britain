drawDisabilityChart = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	trimEthnicity = (ethnicity_string) ->

		if ethnicity_string.indexOf('Gypsy') isnt -1
			trimmedStr = 'Gypsy'
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

	# Actual chart code
	my = {}

	width = $(container).width() ? 1140
	height = $(container).height() ? 550

	# Set margins
	margin = 
		top: 20
		right: 20
		bottom: 30
		left: 40
		p: 25

	chart_width = width - margin.left - margin.right
	chart_height = height - margin.top - margin.bottom

	format = d3.format '.2s'
	percFormat = d3.format ',.0%'
	pointPercFormat = d3.format ',.2%'
	d3_array = data.percentages
	ethnicities = data.ethnicities
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
		.tickFormat trimEthnicity
		.scale x0
		.orient 'bottom'

	yAxis = d3.svg.axis()
		.scale y
		.tickFormat percFormat
		.orient 'left'

	my.init = ->

		# Create svg and g vars
		svg = d3.select '.disability-svg'
		main_group = svg.select '.main-group'
		x_axis_group = svg.select '.x.axis'
		y_axis_group = svg.select '.y.axis'
		title_group = svg.select '.title-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		x_axis_group.attr 'transform', "translate(#{ margin.left }, #{ chart_height + margin.top })"
		y_axis_group.attr 'transform', "translate(#{ margin.left }, #{ margin.top })"
		title_group.attr 'transform', "translate(#{ chart_width / 2 + margin.left }, 0)"

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
		  		y: (d) ->
		  			return y d.values.limited_a_lot
		  		height: (d) ->
		  			return chart_height - y d.values.limited_a_lot
		  		fill: (d) ->
		  			colour d.key
		  		class: 'rect'
 		  	}

		# labels = ethnicity.append 'text'
		# 	.attr {
		# 		class: 'label'
		# 		transform: (d) ->
		# 			return "translate(#{ (x d.values[d.values.length - 1].key) }, #{ y d.values[d.values.length - 1].values.bad })"
		# 		x: 5
		# 		dy: '.35em'
		# 		opacity: 0
		# 	}
		# 	.text (d) ->
		# 		if d.key.indexOf('Gypsy') isnt -1
		# 			trimmedStr = 'Gypsy'
		# 		else if d.key.indexOf('English') isnt -1
		# 			trimmedStr = 'British'
		# 		else if d.key.indexOf('Mean') isnt -1
		# 			trimmedStr = 'Mean'
		# 		else	
		# 			str = d.key
		# 			trimmedStr = str.substr(str.indexOf(':') + 2, str.length)
		# 		return trimmedStr
		# 	.transition()
		# 	.duration 1750
		# 	.attr 'opacity', 0.1

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

		labels.data d3_array
			.transition()
			.duration 1000
			.delay 500
			.attr {
				transform: (d) ->
					return "translate(#{ (x d.values[d.values.length - 1].key) }, #{ y d.values[d.values.length - 1].values.bad })"
			}

		# Add mouse over handler
		attachHoverHandlers() 

	attachHoverHandlers = ->

		# update the chart here
		svg = d3.select '.disability-svg'
		rects = svg.selectAll '.rect'

		rects.on 'mouseover', (d) ->

			_rect = d3.select @

			_rect.attr 'opacity', 0.7
			console.log d

		.on 'mouseout', (d) ->

			_rect = d3.select @

			_rect.attr 'opacity', 1

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
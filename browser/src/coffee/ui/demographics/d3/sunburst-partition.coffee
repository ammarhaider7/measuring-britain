d3 = require 'd3'

drawSunburst = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options
	window.nested_data = data.d3_nested_data
	total_item = data.total_item
	nested_data_init = {
		name: "ethnic_diversity"
		children: []
	}

	getColour = (name) ->

		switch name
			when 'White' then '#FFCFA2'
			when 'Black' then '#695D5D'
			when 'Asian' then '#C55039'
			when 'Mixed' then '#ff7f0e'
			when 'Other' then '#DADADA'

	getSubColour = (name) ->

		switch name
			when 'White' then '#FFDBB9'
			when 'Black' then '#887A7A'
			when 'Asian' then '#E2735D'
			when 'Mixed' then '#FFA352'
			when 'Other' then '#DADADA'

	width = container.offsetWidth ? 750
	height = container.offsetHeight ? 500

	# Set margins
	margin = 
		top: 25
		right: 0
		bottom: 25
		left: 0
		middle: 0
		text: 50

	radius = Math.min width, (height - margin.bottom - margin.top) / 2
	colour = d3.scale.category10()
	format = d3.format '.3s'

	#Partition and arc
	partition = d3.layout.partition()
		.sort null
		.size [2 * Math.PI, radius * radius]
		.value (d) ->
			return d.size

	arc = d3.svg.arc()
		.startAngle (d) ->
			return d.x
		.endAngle (d) ->
			return d.x + d.dx
		.innerRadius (d) ->
			return Math.sqrt d.y
		.outerRadius (d) ->
			return Math.sqrt d.y + d.dy

	# Interpolate the arcs in data space.
	arcTween = (d) ->

		i = d3.interpolate { x: @x0, dx: @dx0 }, d
		return (t) =>
			b = i t
			@x0 = b.x
			@dx0 = b.dx
			arc b

	# Interpolate the arcs for initial draw
	initTween = (d) ->

		i = d3.interpolate { x: 0, dx: 0 }, d
		return (t) =>
			b = i t
			arc b

	 # Stash the old values for transition.
	stash = (d) ->
		@x0 = d.x
		@dx0 = d.dx
		return

	my = {}
	# my = ->
	# 	# generate chart here
	# 	if isDefault is yes

	# 		init()

	# 	else if isDefault is no

	# 		update()

	my.init = ->

		# initiate the chart's first render

		# Create svg and g vars
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'
		center_group = svg.select '.center-text-group'
		center_total_value_group = svg.select '.total-value-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ width / 2 }, #{ height * 0.52 })"
		center_group.attr 'transform', "translate(#{ width / 2 }, #{ height / 2 })"
		center_total_value_group.attr 'transform', "translate(#{ width / 2 }, #{ (height / 2) + margin.text })"

		paths = main_group.selectAll 'path'
			.data partition.nodes nested_data
		  .enter().append 'path'
		  	.attr {
		  		display: (d) ->
		  			return if d.depth then null else 'none'
		  		# d: arc
		  		class: "sunburst-path"
		  	}
		  	.style 'stroke', '#fff'
		  	.style 'fill', (d) ->
		  		if d.depth is 1
		  			return getColour (if d.children then d else d.parent).name
		  		else
		  			return getSubColour (if d.children then d else d.parent).name
		  	.style 'fill-rule', 'evenodd'
		  	.transition()
		  	.duration 1500
		  	.attrTween 'd', initTween
		  	.each stash

		center_group.append 'text'
			.attr 'opacity', 0
			.text activeValue
			.attr 'text-anchor', 'middle'
			.attr 'class', 'active-value-text'
			.transition()
			.duration 1500
			.attr 'opacity', 1

		center_total_value_group.append 'text'
			.attr 'opacity', 0
			.text format total_item.obs_value.value
			.attr 'text-anchor', 'middle'
			.attr 'class', 'total-value-text'
			.transition()
			.duration 1500
			.attr 'opacity', 1

		# dispatch onMouseOver action here
		d3.selectAll '.sunburst-path'
		 	.on 'mouseover', (d) ->

		 		onMouseOver {
		 			label: d.name
		 			value: d.value
		 		}

		 		_d = d

		 		d3.selectAll '.sunburst-path'
		 			.attr 'opacity', (d) ->
		 				unless _d is d
		 					return 0.3
		 	.on 'mouseout', (d) ->
		 		d3.selectAll '.sunburst-path'
		 			.attr 'opacity', 1

		onInitDone()
 
	my.update = ->

		# update the chart here
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'
		center_value_text = svg.select '.active-value-text'
		total_value_text = svg.select '.total-value-text'

		center_value_text
			.transition()
			.duration 500
			.attr 'opacity', 0
			.transition()
			.duration 1000
			.text activeValue
			.attr 'opacity', 1

		total_value_text
			.transition()
			.duration 500
			.attr 'opacity', 0
			.transition()
			.duration 1000
			.text format total_item.obs_value.value
			.attr 'opacity', 1

		newSegments = main_group.selectAll 'path.sunburst-path'
			.data partition.nodes nested_data
			.transition()
		    .duration 1500
			.attrTween 'd', arcTween

		return

	my.width = (value) ->
		unless arguments.length then return width
		width = value
		return my

	my.height = (value) ->
		unless arguments.length then return height
		height = value
		return my

	return my

module.exports = drawSunburst
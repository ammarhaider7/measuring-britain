d3 = require 'd3'

drawSunburst = (options) ->

	{ container, data, isDefault, onMouseOver } = options
	nested_data = data.d3_nested_data
	total_item = data.total_item

	getColour = (name) ->

		switch name
			when 'White' then '#FF8380'
			when 'Black' then '#8c564b'
			when 'Asian' then '#31a354'
			when 'Mixed' then '#ff7f0e'
			when 'Other' then '#1f77b4'

	getSubColour = (name) ->

		switch name
			when 'White' then '#F3A3A1'
			when 'Black' then '#AF7B70'
			when 'Asian' then '#74c476'
			when 'Mixed' then '#FFA352'
			when 'Other' then '#65B1E6'

	width = container.offsetWidth ? 750
	height = container.offsetHeight ? 500

	# Set margins
	margin = 
		top: 25
		right: 0
		bottom: 25
		left: 0
		middle: 0

	radius = Math.min width, (height - margin.bottom - margin.top) / 2
	colour = d3.scale.category10()

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

	 # Stash the old values for transition.
	stash = (d) ->
		@x0 = d.x
		@dx0 = d.dx
		return

	my = ->
		# generate chart here
		if isDefault is yes

			init()

		else if isDefault is no

			update()

	init = ->

		# initiate the chart's first render

		# Create svg and g vars
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'
		center_group = svg.select '.center-text-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ width / 2 }, #{ height * 0.52 })"
		center_group.attr 'transform', "translate(#{ width / 2 }, #{ height / 2 })"

		paths = main_group.selectAll 'path'
			.data partition.nodes nested_data
		  .enter().append 'path'
		  	.attr {
		  		display: (d) ->
		  			return if d.depth then null else 'none'
		  		d: arc
		  		class: "sunburst-path"
		  	}
		  	.style 'stroke', '#fff'
		  	.style 'fill', (d) ->
		  		if d.depth is 1
		  			return getColour (if d.children then d else d.parent).name
		  		else
		  			return getSubColour (if d.children then d else d.parent).name

		  	.style 'fill-rule', 'evenodd'
		  	.each stash

		center_group.append 'text'
			.text 'center text'
			.attr 'text-anchor', 'middle'

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
 
	update = ->

		# update the chart here
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'

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
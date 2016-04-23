d3 = require 'd3'

drawSunburst = (options) ->

	{ container, data, isDefault } = options
	nested_data = data.d3_nested_data
	total_item = data.total_item

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
	colour = d3.scale.category20c()

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
	arcTween = (current_datum) ->
	  interpolate = d3.interpolate({
	    x: current_datum.x0
	    dx: current_datum.dx0
	  }, current_datum)
	  return (t) ->
	    b = interpolate(t)
	    current_datum.x0 = b.x
	    current_datum.dx0 = b.dx
	    return arc b

	 # Stash the old values for transition.
	stash = (d) ->
		d.x0 = d.x
		d.dx0 = d.dx

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

		# Transforms
		main_group.attr 'transform', "translate(#{ width / 2 }, #{ height * 0.52 })"

		paths = main_group.datum(nested_data).selectAll 'path'
			.data partition.nodes
		  .enter().append 'path'
		  	.attr {
		  		display: (d) ->
		  			return if d.depth then null else 'none'
		  		d: arc
		  		class: 'sunburst-path'
		  	}
		  	.style 'stroke', '#fff'
		  	.style 'fill', (d) ->
		  		return colour (if d.children then d else d.parent).name
		  	.style 'fill-rule', 'evenodd'
		  	.each stash

		# dispatch onMouseOver action here
		d3.selectAll '.sunburst-path'
		 	.on 'mouseover', (d) ->
		 		console.log 'mouseover d'
		 		console.log d

	update = ->
		# update the chart here
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'

		newSegments = main_group.datum(nested_data).selectAll 'path'
			.data partition.nodes

		# newSegments.exit().remove()

		# newSegments.enter().append 'paths'
		# 	.transition()
		# 	.duration 1500
		# 	.attr 'd', arc
		# 	.each stash

		newSegments.transition()
		    .duration 1500
		    .attrTween 'd', arcTween
		    .each stash

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
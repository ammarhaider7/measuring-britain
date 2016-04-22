d3 = require 'd3'

drawSunburst = (options) ->

	{ container, data } = options
	nested_data = data.d3_nested_data
	total_item = data.total_item

	width = container.offsetWidth ? 750
	height = container.offsetHeight ? 500
	radius = Math.min width, height / 2
	colour = d3.scale.category20c()

	# Set margins
	margin = 
		top: 0
		right: 0
		bottom: 0
		left: 0
		middle: 0

	#Partition and arc
	partition = d3.layout.partition()
		.sort null
		.size [2 * Math.PI, radius * radius]
		.value (d) ->
			return 1

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
	arcTween = (a) ->
	  i = d3.interpolate({
	    x: a.x0
	    dx: a.dx0
	  }, a)
	  return (t) ->
	    b = i(t)
	    a.x0 = b.x
	    a.dx0 = b.dx
	    return arc b

	 # Stash the old values for transition.
	stash = (d) ->
		d.x0 = d.x
		d.dx0 = d.dx

	my = ->
		# generate chart here
		init()

	init = ->
		# initiate the chart's first render

		# Create svg and g vars
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'

		# Transforms
		main_group.attr 'transform', "translate(#{ width / 2 }, #{ height * 0.52 })"

		path = main_group.datum(nested_data).selectAll 'path'
			.data partition.nodes
		  .enter().append 'path'
		  	.attr {
		  		display: (d) ->
		  			return if d.depth then null else 'none'
		  		d: arc
		  	}
		  	.style 'stroke', '#fff'
		  	.style 'fill', (d) ->
		  		console.log 'sunburst > d'
		  		console.log d
		  		return colour (if d.values then d else d.parent).key
		  	.style 'fill-rule', 'evenodd'
		  	.each stash

	update = ->
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

module.exports = drawSunburst
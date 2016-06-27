# d3 = require 'd3'

drawSunburst = (options) ->

	{ container, data, isDefault, onMouseOver, activeCategory, activeValue, onInitDone } = options

	nested_data = data.d3_nested_data

	total_item = data.total_item

	# total value
	total_item_value = total_item.obs_value.value
	
	nested_data_init = {
		name: "ethnic_diversity"
		children: []
	}

	ethnic_group_arr = [
		{
			name: 'White'
			colour: '#2C81BF'
		}
		{
			name: 'Black'
			colour: '#7569B3'
		}
		{
			name: 'Asian'
			colour: '#29A450'
		}
		{
			name: 'Mixed'
			colour: '#E85400'
		}
		{
			name: 'Other'
			colour: '#636363'
		}
	]

	getColour = (name) ->

		switch name
			when 'White' then '#2C81BF' # blue
			when 'Black' then '#7569B3' # purple
			when 'Asian' then '#29A450' # green
			when 'Mixed' then '#E85400' # orange
			when 'Other' then '#636363' # grey

	getSubColour = (name) ->

		switch name
			when 'White' then '#68ADD8'
			when 'Black' then '#9E99CA'
			when 'Asian' then '#71C573'
			when 'Mixed' then '#FF8D2E'
			when 'Other' then '#969696'

	width = $(container).width() ? 1140
	height = $(container).height() ? 500
	mobile_portrait_width = 740

	# Set margins
	margin = 
		top: 25
		right: 0
		bottom: 25
		left: 25
		middle: 15
		text: 50
		p: 5

	radius = Math.min width, (height - margin.bottom - margin.top) / 2
	format = d3.format '.3s'
	percFormat = d3.format ',.1%'

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
		# smooth edges for segments
		.cornerRadius 5

	# y scale for key rects
	y = d3.scale.ordinal()
		.domain d3.range ethnic_group_arr.length
		.rangeRoundBands [0, height/3], 0

	# Interpolate the arcs in data space.
	arcTween = (d) ->

		i = d3.interpolate { x: @x0, dx: @dx0 }, d
		return (t) =>
			b = i t
			@x0 = b.x
			@dx0 = b.dx
			arc b

	# Interpolate the arcs from 0 values for initial draw
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

	attachHoverHandlers = ->

		svg = d3.select '.sunburst-svg'
		center_total_value_group = svg.select '.total-value-group'
		center_ethnic_group = svg.select '.ethnic-group-text'
		center_percent_group = svg.select '.percentage-group'

		d3.selectAll '.sunburst-path'
		 	.on 'mouseover', (d) ->

		 		# dispatch onMouseOver action here
		 		onMouseOver {
		 			label: d.name
		 			value: d.value
		 		}

		 		# set opacity of arcs
		 		_d = d
		 		d3.selectAll '.sunburst-path'
		 			.attr 'opacity', (d) ->
		 				unless _d is d
		 					return 0.2

		 		# update inner circle text values
		 		center_ethnic_group.select 'text'
		 			.text d.name
		 		center_total_value_group.select 'text'
		 			.text format d.value
		 		center_percent_group.select 'text'
		 			.attr 'fill', if d.depth is 1 then getColour d.name else getColour d.parent.name
		 			.text percFormat d.value / total_item_value
		 	.on 'mouseout', (d) ->
		 		d3.selectAll '.sunburst-path'
		 			.attr 'opacity', 1
		 		center_ethnic_group.select 'text'
		 			.text 'All ethnic groups'
		 		center_total_value_group.select 'text'
		 			.text format total_item_value
		 		center_percent_group.select 'text'
		 			.text '100%'
		 			.attr 'fill', '#333'

	my.init = ->

		# initiate the chart's first render

		# Create svg and g vars
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'
		center_group = svg.select '.center-text-group'
		center_total_value_group = svg.select '.total-value-group'
		center_ethnic_group = svg.select '.ethnic-group-text'
		center_percent_group = svg.select '.percentage-group'
		key_group = svg.select '.key-group'
		key_text_group = svg.select '.key-text-group'

		# halved height for use below
		half_height = height * 0.52

		# Transforms
		main_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height })"
		center_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + margin.middle - margin.top * 2 })"
		center_ethnic_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + margin.text - margin.top * 2 })"
		center_percent_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + (margin.text * 2) - margin.top * 2 })"
		center_total_value_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + (margin.text * 2.7) - margin.top * 2 })"
		key_group.attr 'transform', "translate(#{ (width * 0.9) + 20  }, #{ margin.top })"
		key_text_group.attr 'transform', "translate(#{ width * 0.9 }, #{ margin.top + 17 })"

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

		center_ethnic_group.append 'text'
			.attr 'opacity', 0
			.text 'All ethnic groups'
			.attr 'text-anchor', 'middle'
			.attr 'class', 'ethnicity-text'
		  .transition()
			.duration 1500
			.attr 'opacity', 1

		center_percent_group.append 'text'
			.attr 'opacity', 0
			.text '100%'
			.attr 'text-anchor', 'middle'
			.attr 'class', 'percent-text'
		  .transition()
			.duration 1500
			.attr 'opacity', 1

		center_total_value_group.append 'text'
			.attr 'opacity', 0
			.text format total_item_value
			.attr 'text-anchor', 'middle'
			.attr 'class', 'total-value-text'
		  .transition()
			.duration 1500
			.attr 'opacity', 1

		# Create key rects
		key_group.selectAll 'rect'
			.data ethnic_group_arr
		  .enter().append 'rect'
		  	.attr {
		  		x: 0
		  		y: (d, i) ->
		  			return y i
		  		width: margin.p * 5
		  		height: margin.p * 5
		  		rx: 3
		  		fill: (d) ->
		  			return d.colour
		  	}

		key_text_group.selectAll 'text'
			.data ethnic_group_arr
		  .enter().append 'text'
			.text (d) ->
				return d.name
			.attr {
		  		y: (d, i) ->
		  			return y i
				x: 10
				'text-anchor': 'end'
		  	}

		attachHoverHandlers()

		# dispatch to update init_done var on state
		onInitDone()
 
	my.update = ->

		# update the chart here
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'
		center_value_text = svg.select '.active-value-text'
		total_value_text = svg.select '.total-value-text'
		percent_text = svg.select '.percent-text'
		ethnic_text = svg.select '.ethnicity-text'

		center_value_text
		  .transition()
			.duration 500
			.attr 'opacity', 0
			.transition()
			.duration 1000
			.delay 500
			.text activeValue
			.attr 'opacity', 1

		total_value_text
		  .transition()
			.duration 500
			.attr 'opacity', 0
			.transition()
			.duration 1000
			.delay 500
			.text format total_item_value
			.attr 'opacity', 1

		percent_text
		  .transition()
			.duration 500
			.attr 'opacity', 0
			.transition()
			.duration 1000
			.delay 500
			.attr 'fill', '#333'
			.text '100%'
			.attr 'opacity', 1

		ethnic_text
		  .transition()
			.duration 500
			.attr 'opacity', 0
			.transition()
			.duration 1000
			.delay 500
			.text 'All ethnic groups'
			.attr 'opacity', 1

		total_value_text
		  .transition()
			.duration 500
			.attr 'opacity', 0
			.transition()
			.duration 1000
			.delay 500
			.text format total_item.obs_value.value
			.attr 'opacity', 1

		newSegments = main_group.selectAll 'path.sunburst-path'
			.data partition.nodes nested_data
		  .transition()
		    .duration 1500
			.delay 500
			.attrTween 'd', arcTween

		attachHoverHandlers()

		return

	my.resize = ->

		# Create svg and g vars
		svg = d3.select '.sunburst-svg'
		main_group = svg.select '.main-group'
		center_group = svg.select '.center-text-group'
		center_total_value_group = svg.select '.total-value-group'
		center_ethnic_group = svg.select '.ethnic-group-text'
		center_percent_group = svg.select '.percentage-group'
		key_group = svg.select '.key-group'
		key_text_group = svg.select '.key-text-group'

		# halved height for use below
		half_height = height * 0.52

		# Transforms
		main_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height })"
		center_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + margin.middle - margin.top * 2 })"
		center_ethnic_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + margin.text - margin.top * 2 })"
		center_percent_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + (margin.text * 2) - margin.top * 2 })"
		center_total_value_group.attr 'transform', "translate(#{ width / 2 }, #{ half_height + (margin.text * 3) - margin.top * 2 })"
		key_group.attr 'transform', "translate(#{ (width * 0.9) + 20  }, #{ margin.top })"
		key_text_group.attr 'transform', "translate(#{ width * 0.9 }, #{ margin.top + 17 })"

		paths = main_group.selectAll 'path'
			.data partition.nodes nested_data
		  	.attr 'd', arc

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
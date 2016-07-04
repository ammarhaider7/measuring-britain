d3 = require 'd3'

# Wrap function
module.exports = (texts, width, x_margin = 0) ->
	texts.each ->
		text = d3.select(this)
		words = text.text().split(/\s+/).reverse()
		word = undefined
		line = []
		lineNumber = 0
		lineHeight = 1.1
		y = text.attr('y')
		dy = parseFloat(text.attr('dy'))
		tspan = text.text null
			.append 'tspan'
			.attr {
				x: x_margin
				y: y
				dy: dy + 'em'
			}
		### jshint ignore:start ###
		while word = words.pop()
			line.push word
			tspan.text line.join(' ')
			if tspan.node().getComputedTextLength() > width
				line.pop()
				tspan.text line.join(' ')
				line = [ word ]
				tspan = text.append 'tspan' 
					.attr {
						x: x_margin
						y: y
					}
					.attr 'dy', ++lineNumber * lineHeight + dy + 'em'
					.text word
		### jshint ignore:end ###
		return
	return
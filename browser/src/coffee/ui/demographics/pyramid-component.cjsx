React = require 'react'
Controls = require '../chart-controls.js'
Table = require './pyramid-table.js'

PyramidComponent = React.createClass
  render: ->
  	<div className="col-xs-12 col-sm-8 mt-medium">
	  	<Controls {...@props} />
	  	<div className="pyramid">
	  		<svg className="pyramid-svg">
	  			<g className="main"></g>
	  			<g className="overlay-group"></g>
	  			<g className="ticks-description"></g>
	  		</svg>
	  	</div>
	  	<Table {...@props} />
  	</div>

module.exports = PyramidComponent
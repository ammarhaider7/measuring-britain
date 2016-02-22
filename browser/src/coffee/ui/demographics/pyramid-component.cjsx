React = require 'react'
ReactDOM = require 'react-dom'
Controls = require('../chart-controls.js')()

pyramidFn = ->

	pyramidComponent = React.createClass
	  render: ->
	  	<div className="col-xs-12 col-sm-8 mt-medium">
		  	<Controls/>
		  	<div className="pyramid">
		  		<svg className="pyramid-svg">
		  			<g className="main"></g>
		  			<g className="overlay-group"></g>
		  			<g className="ticks-description"></g>
		  		</svg>
		  	</div>
	  	</div>

	ReactDOM.render React.createElement(pyramidComponent), document.getElementById('pyramid-container')

module.exports = pyramidFn
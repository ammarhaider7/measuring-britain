React = require 'react'
Controls = require '../chart-controls.js'
Table = require './pyramid-table.js'
data = require './data/pyramid-chart-controls.js'
value_options = {
	districts: data.districts
	ethnic_groups: data.ethnic_groups
	religions: data.religions
	regions: data.regions
}

PyramidComponent = React.createClass
  render: ->
  	<div className="col-xs-12 col-sm-8 mt-medium">
	  	<Controls {...@props} categories=data.category_options values=value_options />
	  	<div className="pyramid mt-medium">
	  		<svg className="pyramid-svg">
	  			<g className="main"></g>
	  			<g className="overlay-group"></g>
	  			<g className="ticks-description"></g>
	  		</svg>
	  		<p>{ if @props.showSpinner then 'fetching..' else 'done' }</p>
	  	</div>
  	</div>

module.exports = PyramidComponent
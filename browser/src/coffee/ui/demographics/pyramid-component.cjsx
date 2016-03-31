React = require 'react'
d3 = require 'd3'
Controls = require '../chart-controls.js'
Table = require './pyramid-table.js'
data = require './data/pyramid-chart-controls.js'
FancySelect = require 'react-select'
drawPyramid = require './d3/pyramid.js'

value_options = {
	districts: data.districts
	ethnicities: data.ethnic_groups
	religions: data.religions
	regions: data.regions
}

PyramidComponent = React.createClass
	componentWillMount: ->
		@props.fetchPyramidData null
	componentDidUpdate: ->
		pyramid = drawPyramid({
			container: @refs.pyramidSvg
			ages: @props.data.bars.ages
			bar_males: @props.data.bars.males
			bar_females: @props.data.bars.females
			bar_males_perc: @props.data.bars.malesPerc
			bar_females_perc: @props.data.bars.femalesPerc
			outline_males: @props.data.outline.males ? null
			outline_females: @props.data.outline.females ? null
		})
		pyramid() if @props.data.bars.ages?

	render: ->
		<div className="col-xs-12 col-sm-8 mt-medium">
	  		<Controls {...@props} categories=data.category_options values=value_options />
		  	<div className="pyramid mt-medium">
		  		<svg 
		  			className="pyramid-svg" 
		  			style={{ width: '100%', height: '550px' }}
		  			ref="pyramidSvg"
		  		>
		  			<g className="main-group">
			  			<g className="left-group"></g>
			  			<g className="right-group"></g>
		  			</g>
		  			<g className="overlay-group"></g>
		  			<g className="ticks-group">
		  				<g className="y axis"></g>
		  				<g className="x axis left"></g>
		  			</g>
		  		</svg>
		  		<p>{ if @props.isFetching then 'fetching..' else 'done' }</p>
		  		{### unless @props.data.bars.length is 0
		  			<ul className="mb-left">
			  			<h3>Bars data</h3>
		  				{ for item, i in @props.data.bars
		  					<li key={ i }>{ item.c_age.description + " : " + item.obs_value.value }</li>
		  				}
		  			</ul>
		  		}
		  		{ unless @props.data.outline.length is 0
		  			<ul>
		  				<h3>Outline data</h3>
		  				{ for item, i in @props.data.outline
		  					<li key={ i }>{ item.c_age.description + " : " + item.obs_value.value }</li>
		  				}
		  			</ul>
		  		###}
		  	</div>
		</div>

module.exports = PyramidComponent
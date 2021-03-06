PyramidControls = require './chart-controls-pyramid.js'
data = require './data/pyramid-chart-controls.js'
drawPyramid = require './d3/pyramid.js'
OnsAttr = require '../../partials/chart-ons-attribution.js'
React = require 'react'
$ = require 'jquery'

value_options = {
	districts: data.districts
	ethnicities: data.ethnic_groups
	religions: data.religions
	regions: data.regions
	countries: data.countries
}

PyramidComponent = React.createClass

	getAppropriateHeight: ->

		window_height = $(window).height()
		if window_height > 550
			return 570
		else
			return window_height * 1.3

	componentWillMount: ->

		@props.fetchPyramidData null

	componentDidMount: ->

		$(window).resize () =>
			@onResize()

	onResize: ->

		resizeChart = drawPyramid {
			resize: yes
			container: @refs.pyramidSvg
			ages: @props.data.bars.ages
			bar_males: @props.data.bars.males
			bar_females: @props.data.bars.females
			bar_males_perc: @props.data.bars.malesPerc
			bar_males_perc_format: @props.data.bars.malesPercFormat
			bar_males_sum: @props.data.bars.malesSum
			bar_females_perc: @props.data.bars.femalesPerc
			bar_females_perc_format: @props.data.bars.femalesPercFormat
			bar_females_sum: @props.data.bars.femalesSum
			outline_males: @props.data.outline.males ? null
			outline_females: @props.data.outline.females ? null
			outline_males_perc: @props.data.outline.malesPerc ? null
			outline_males_perc_format: @props.data.outline.malesPercFormat ? null
			outline_males_sum: @props.data.outline.malesSum ? null
			outline_females_perc: @props.data.outline.femalesPerc ? null
			outline_females_perc_format: @props.data.outline.femalesPercFormat ? null
			outline_females_sum: @props.data.outline.femalesSum ? null
			overlay_data: @props.data.bars.overlayData
			onMouseOver: @props.onMouseOver
			onFirstLineDrawn: @props.onFirstLineDrawn
			isDefault: @props.isDefault
			outlineFilter: @props.outlineFilter
			updatePyramid: @props.updatePyramid
			updateOutline: @props.updateOutline
			activeLineCategory: @props.activeLineCategory
			activeLineValue: @props.activeLineValue
			isFirstLine: @props.isFirstLine
		}

		resizeChart()

	componentDidUpdate: ->

		if @props.updatePyramid is yes or @props.updateOutline is yes
			pyramid = drawPyramid {
				resize: no
				container: @refs.pyramidSvg
				ages: @props.data.bars.ages
				bar_males: @props.data.bars.males
				bar_females: @props.data.bars.females
				bar_males_perc: @props.data.bars.malesPerc
				bar_males_perc_format: @props.data.bars.malesPercFormat
				bar_males_sum: @props.data.bars.malesSum
				bar_females_perc: @props.data.bars.femalesPerc
				bar_females_perc_format: @props.data.bars.femalesPercFormat
				bar_females_sum: @props.data.bars.femalesSum
				outline_males: @props.data.outline.males ? null
				outline_females: @props.data.outline.females ? null
				outline_males_perc: @props.data.outline.malesPerc ? null
				outline_males_perc_format: @props.data.outline.malesPercFormat ? null
				outline_males_sum: @props.data.outline.malesSum ? null
				outline_females_perc: @props.data.outline.femalesPerc ? null
				outline_females_perc_format: @props.data.outline.femalesPercFormat ? null
				outline_females_sum: @props.data.outline.femalesSum ? null
				overlay_data: @props.data.bars.overlayData
				onMouseOver: @props.onMouseOver
				onFirstLineDrawn: @props.onFirstLineDrawn
				isDefault: @props.isDefault
				outlineFilter: @props.outlineFilter
				updatePyramid: @props.updatePyramid
				updateOutline: @props.updateOutline
				activeLineCategory: @props.activeLineCategory
				activeLineValue: @props.activeLineValue
				isFirstLine: @props.isFirstLine
			}

			pyramid() 

	render: ->

		<div>
	  		<PyramidControls {...@props} categories=data.category_options values=value_options />
		  	<div className="pyramid mt-medium">
		  		<img src="/images/mb_ajax_loader.gif" 
		  			className={ 
		  				if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
		  			}
		  		/>
		  		<svg 
		  			className="pyramid-svg" 
		  			style={{ width: '100%', height: @getAppropriateHeight() }}
		  			ref="pyramidSvg"
		  		>
		  			<g className="title-group"></g>
		  			<g className="main-group">
			  			<g className="left-group"></g>
			  			<g className="right-group"></g>
			  			<g className="key-group">
			  				<g className="male-key-group"></g>
			  				<g className="female-key-group"></g>	
			  			</g>
		  			</g>
		  			<g className="overlay-group"></g>
		  			<g className="ticks-group mb-oxygen">
		  				<g className="y axis"></g>
		  				<g className="x axis left"></g>
		  				<g className="x axis right"></g>
		  			</g>
		  		</svg>
		  		<OnsAttr/>
		  	</div>
		</div>

module.exports = PyramidComponent
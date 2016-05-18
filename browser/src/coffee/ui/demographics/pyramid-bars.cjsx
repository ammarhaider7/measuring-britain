# React = require 'react'
drawPyrBars = require './d3/pyramidBars.js'

pyBarsComponent = React.createClass

	componentDidUpdate: ->


		if @props.updateBars is yes
			
			pyrBars = drawPyrBars {
				container: @refs.pyramidBarsSvg
				age: @props._mouseOverData.age
				females: @props._mouseOverData.females
				males: @props._mouseOverData.males
				initial: @props._mouseOverData.initial
				isDefault: @props.isDefault
				activeBarsValue: @props.activeBarsValue
			}

			pyrBars() 

	render: ->

		<div className={ unless @props.isFetching is yes and @props.isDefault is yes then 'mb-grey-box' }>
			{ if @props.isFetching is yes and @props.isDefault is yes
		  		<img src="./images/mb_ajax_loader.gif" className="mb-spinner"/>
			}
			<svg
				className="pyramid-bars-svg" 
				style={{ width: '100%', height: '275px' }}
				ref="pyramidBarsSvg"
			>
				<g className="x axis"></g>
				<g className="labels-group"></g>
				<g className="ages-group"></g>
				<g className="main-group"></g>
			</svg>
		</div>

module.exports = pyBarsComponent
React = require 'react'
ControlsNew = require '../chart-controls-new.js'
data = require './data/pyramid-chart-controls.js'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
}

category_options = data.category_options

SunburstComponent = React.createClass 
  render: ->
    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="sunburst mt-medium">
        <ControlsNew {...@props} categories=category_options values=value_options />
        <svg
          className="sunburst-svg" 
          style={{ width: '100%', height: '550px' }}
          ref="sunburstSvg"
        >
          <g className="main-group"></g>
        </svg>
      </div>
    </div>

module.exports = SunburstComponent
React = require 'react'
ControlsNew = require '../chart-controls-new.js'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'

SunburstComponent = React.createClass 
  render: ->
    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="sunburst mt-medium">
        <ControlsNew {...@props}/>
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
React = require 'react'

SunburstComponent = React.createClass 
  render: ->
    <div className="col-xs-12 col-sm-12 mt-medium">
      <div className="pyramid mt-medium">
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
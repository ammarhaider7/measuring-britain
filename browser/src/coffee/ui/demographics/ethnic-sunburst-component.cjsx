React = require 'react'
ControlsNew = require '../chart-controls-new.js'
data = require './data/pyramid-chart-controls.js'
drawSunburst = require './d3/sunburst-partition.js'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

SunburstComponent = React.createClass 

  componentWillMount: ->

    @props.fetchSunburstData null

  componentDidUpdate: ->

    if @props.updateSunburst is yes

      sunburst = drawSunburst {
        container: @refs.sunburstSvg
        data: @props.data
        isDefault: @props.isDefault
      }

      sunburst()

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="sunburst mt-medium">
        <ControlsNew {...@props} omitted_category="ethnicities" categories=category_options values=value_options />
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
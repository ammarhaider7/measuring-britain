React = require 'react'
$ = require 'jquery'
ControlsNew = require '../chart-controls-new.js'
data = require './data/pyramid-chart-controls.js'
drawSunburst = require './d3/sunburst-partition.js'
OnsAttr = require '../../partials/chart-ons-attribution.js'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

SunburstComponent = React.createClass 

  getAppropriateHeight: ->

    window_width = $(window).width()
    window_height = $(window).height()
    # if screen is not mobile default to 550
    if window_height > 550 and window_width > 740
      return 550
    # otherwise 350
    else
      return 400

  componentDidMount: ->

    if @props.isDefault is yes and @props.init_done is no
      
      @props.fetchSunburstData null

    $(window).resize () =>
      @reactDrawSunburst {
        resize: yes
      }

  reactDrawSunburst: (resize_flag) ->

    sunburst = drawSunburst {
      resize: resize_flag.resize
      container: @refs.sunburstSvg
      data: @props.data
      isDefault: @props.isDefault
      onMouseOver: @props.onMouseOver
      activeCategory: @props.activeCategory
      activeValue: @props.activeValue
      onInitDone: @props.onInitDone
    }

    if resize_flag.resize is yes

      return sunburst.resize()

    if @props.isDefault is yes and @props.updateSunburst is yes

      return sunburst.init()

    else

      return sunburst.update()

  componentDidUpdate: ->

    # if @props.updateSunburst is yes and @props.init_done is yes
    if @props.updateSunburst is yes

      @reactDrawSunburst {
        resize: no
      }

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="sunburst mt-medium">
        <ControlsNew {...@props} omitted_categories={[ "ethnicities" ]} categories=category_options values=value_options />
        <img src="/images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
          }
        />
        <svg
          className="sunburst-svg"  
          style={{ width: '100%', height: @getAppropriateHeight() }}
          ref="sunburstSvg"
        >
          <g className="main-group"></g>
          <g className="key-group"></g>
          <g className="key-text-group mb-oxygen"></g> 
          <g className="center-text-group"></g>  
          <g className="ethnic-group-text"></g>   
          <g className="total-value-group"></g>  
          <g className="percentage-group"></g>    
        </svg>
        <OnsAttr/>
      </div>
    </div>

module.exports = SunburstComponent
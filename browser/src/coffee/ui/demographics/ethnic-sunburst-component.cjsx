React = require 'react'
ControlsNew = require '../chart-controls-new.js'
data = require './data/pyramid-chart-controls.js'
drawSunburst = require './d3/sunburst-partition.js'
$ = require 'jQuery'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

SunburstComponent = React.createClass 

  componentDidMount: ->

    if @props.isDefault is yes and @props.init_done is no

      # Only load sunburst once user scrolls to it
      $(window).on 'scroll', () =>

        docScrollTop = $(document).scrollTop()
        sunburstOffsetTop = ($('.sunburst').offset().top + 750)
        docHeight = $(document).height()

        if (docHeight - docScrollTop) < sunburstOffsetTop

          # $(window).off 'scroll'
          if @props.init_done is no
            @props.fetchSunburstData null
          @props.onInitDone()

  reactDrawSunburst: ->

    sunburst = drawSunburst {

      container: @refs.sunburstSvg
      data: @props.data
      isDefault: @props.isDefault
      onMouseOver: @props.onMouseOver
      activeCategory: @props.activeCategory
      activeValue: @props.activeValue
      onInitDone: @props.onInitDone
    }

    # sunburst()

    if @props.isDefault is yes and @props.updateSunburst is yes

      sunburst.init()

    else

      sunburst.update()

  componentDidUpdate: ->

    # if @props.updateSunburst is yes and @props.init_done is yes
    if @props.updateSunburst is yes

      @reactDrawSunburst()

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="sunburst mt-medium">
        <ControlsNew {...@props} omitted_category="ethnicities" categories=category_options values=value_options />
        <img src="./images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
          }
        />
        <svg
          className="sunburst-svg"  
          style={{ width: '100%', height: '550px' }}
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
      </div>
    </div>

module.exports = SunburstComponent
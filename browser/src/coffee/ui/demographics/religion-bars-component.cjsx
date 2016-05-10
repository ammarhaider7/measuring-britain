React = require 'react'
ControlsNew = require '../chart-controls-new.js'
data = require './data/pyramid-chart-controls.js'
drawRelBars = require './d3/bar-chart.js'
$ = require 'jQuery'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

BarsComponent = React.createClass 

  componentDidMount: ->

    # if @props.isDefault is yes and @props.init_done is no
    #   # Only load sunburst once user scrolls to it
    #   $(window).on 'scroll', () =>

    #     docScrollTop = $(document).scrollTop()
    #     sunburstOffsetTop = ($('.rel-bars').offset().top - 75)
    #     docHeight = $(document).height()

    #     if (docHeight - docScrollTop) < sunburstOffsetTop
    #       console.log 'scroll reach'
    #       $(window).off 'scroll'
    #       @props.fetchBarsData null

  reactDrawBars: ->

    bars = drawRelBars {

      container: @refs.barsSvg
      data: @props.data
      isDefault: @props.isDefault
      onMouseOver: @props.onMouseOver
      activeCategory: @props.activeCategory
      activeValue: @props.activeValue
      onInitDone: @props.onInitDone
    }

    # sunburst()

    if @props.isDefault is yes and @props.updateSunburst is yes

      bars.init()

    else

      bars.update()

  componentDidUpdate: ->

    # if @props.updateSunburst is yes and @props.init_done is yes
    if @props.updateBars is yes

      @reactDrawBars()

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="rel-bars mt-medium">
        <ControlsNew {...@props} omitted_category="religions" categories=category_options values=value_options />
        <img src="./images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
          }
        />
        <svg
          className="bars-svg"  
          style={{ width: '100%', height: '550px' }}
          ref="barsSvg"
        >
          <g className="main-group"></g>
          <g className="labels-group"></g>
          <g className="x-axis-group"></g>
          <g className="y-axis-group"></g>
          <g className="key-group"></g>
          <g className="key-text-group"></g>  
        </svg>
      </div>
    </div>  

module.exports = BarsComponent
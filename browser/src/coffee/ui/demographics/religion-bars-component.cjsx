# React = require 'react'
ControlsNew = require '../chart-controls-new.js'
data = require './data/pyramid-chart-controls.js'
drawRelBars = require './d3/bar-chart.js'

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

    if @props.isDefault is yes and @props.init_done is no

      $(window).on 'scroll', () =>

        docScrollTop = $(document).scrollTop()
        relBarsOffsetTop = ($('.rel-bars').offset().top - 650)
        docHeight = $(document).height()

        if (docHeight - docScrollTop) < relBarsOffsetTop
          console.log 'scroll reach relbars'
          $(window).off 'scroll'
          @props.fetchReligionData null

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

    if @props.isDefault is yes and @props.updateRelBars is yes

      bars.init()

    else
      
      bars.update()

  componentDidUpdate: ->

    if @props.updateRelBars is yes

      @reactDrawBars()

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="rel-bars mt-medium">
        <ControlsNew {...@props} omitted_categories={["religions"]} categories=category_options values=value_options />
        <img src="./images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
          }
        />
        <svg
          className="bars-svg mb-oxygen"  
          style={{ width: '100%', height: '425px' }}
          ref="barsSvg"
        >
          <g className="main-group"></g>
          <g className="labels-group"></g>
          <g className="x axis"></g>
          <g className="detail-group mb-quicksand"></g>
        </svg>
      </div>
      <hr/>
    </div>  

module.exports = BarsComponent
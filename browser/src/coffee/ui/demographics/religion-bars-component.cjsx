# React = require 'react'
ControlsNew = require '../chart-controls-new.js'
data = require './data/pyramid-chart-controls.js'
drawRelBars = require './d3/bar-chart.js'
OnsAttr = require '../../partials/chart-ons-attribution.js'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

BarsComponent = React.createClass

  componentWillMount: ->

    if @props.isDefault is yes and @props.init_done is no

      @props.fetchReligionData null

  componentDidMount: ->

    $(window).resize () =>
      @reactDrawBars {
        resize: yes
      }

  reactDrawBars: (resize_flag) ->

    bars = drawRelBars {

      resize: resize_flag.resize
      container: @refs.barsSvg
      data: @props.data
      isDefault: @props.isDefault
      onMouseOver: @props.onMouseOver
      activeCategory: @props.activeCategory
      activeValue: @props.activeValue
      onInitDone: @props.onInitDone

    }

    if resize_flag.resize is yes

      return bars.resize()

    if @props.isDefault is yes and @props.updateRelBars is yes

      return bars.init()

    else
      
      return bars.update()

  componentDidUpdate: ->

    if @props.updateRelBars is yes

      @reactDrawBars {
        resize: no
      }

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="rel-bars mt-medium">
        <ControlsNew {...@props} omitted_categories={["religions"]} categories=category_options values=value_options />
        <img src="/images/mb_ajax_loader.gif" 
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
        <OnsAttr/>
      </div>
    </div>  

module.exports = BarsComponent
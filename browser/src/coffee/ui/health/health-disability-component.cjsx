ControlsNew = require '../chart-controls-new.js'
data = require '../demographics/data/pyramid-chart-controls.js'
disabilityChart = require './d3/health-disability-chart.js'
OnsAttr = require '../../partials/chart-ons-attribution.js'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

DisabilityChart = React.createClass 

  componentWillMount: ->

    # @props.fetchDisabilityData null
    if @props.isDefault is yes and @props.init_done is no

      @props.fetchDisabilityData null
      @props.onInitDone()

  componentDidMount: ->

    $(window).resize () =>
      @onResize()

  onResize: ->

    draw = disabilityChart {
      resize: yes
      container: @refs.disabilitySvg
      isDefault: @props.isDefault
      data: @props.data
      activeCategory: @props.activeCategory
      activeValue: @props.activeValue
      onMouseOver: @props.onMouseOver
    }

    draw.resize()

  componentDidUpdate: ->

    # Update chart
    if @props.updateDisability is yes

      draw = disabilityChart {
        resize: no
        container: @refs.disabilitySvg
        isDefault: @props.isDefault
        data: @props.data
        activeCategory: @props.activeCategory
        activeValue: @props.activeValue
        onMouseOver: @props.onMouseOver
      }

      return if @props.isDefault is yes then draw.init() else draw.update()

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="mt-medium">
        <ControlsNew {...@props} omitted_categories={["ethnicities", "districts", "religions"]} categories=category_options values=value_options />
        <img src="/images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
          }
        />
        <svg
          className="disability-svg mb-oxygen"
          style={{ width: '100%', height: '485px' }}
          ref="disabilitySvg"
        >
          <g className="title-group mb-oxygen"></g>
          <g className="y axis"></g>
          <g className="x axis"></g>
          <g className="main-group">
            <g className="legend-group"></g>  
          </g>        
        </svg>
        <OnsAttr/>
      </div>
    </div>  

module.exports = DisabilityChart
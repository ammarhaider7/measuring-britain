ControlsNew = require '../chart-controls-new.js'
data = require '../demographics/data/pyramid-chart-controls.js'
econByCountryChart = require './d3/econ-activity-country-chart.js'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

EconByCountry = React.createClass 

  componentWillMount: ->

    @props.fetchEconCountryData null

  componentDidUpdate: ->

    # Update chart
    if @props.updateMainChart is yes
      
      draw = econByCountryChart {
        container: @refs.econCountrySvg
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
        <ControlsNew {...@props} omitted_categories={["ethnicities", "religions"]} categories=category_options values=value_options />
        <img src="/images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
          }
        />
        <svg
          className="econ-country-svg mb-oxygen"
          style={{ width: '100%', height: '600px' }}
          ref="econCountrySvg"
        >
          <g className="title-group mb-oxygen"></g>
          <g className="top-group-rect"></g>
          <g className="bottom-group-rect"></g>
          <g className="y y-top axis"></g>
          <g className="y y-bottom axis"></g>
          <g className="x axis"></g>
          <g className="main-group-top"></g>
          <g className="main-group-bottom"></g>
          <g className="x-axis-divider"></g>
        </svg>
      </div>
    </div>  

module.exports = EconByCountry
ControlsNew = require '../chart-controls-new.js'
data = require '../demographics/data/pyramid-chart-controls.js'
genHealthChart = require './d3/gen-health-chart.js'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

GenHealthChart = React.createClass 

  componentWillMount: ->

    @props.fetchGenHealthData null

  componentDidUpdate: ->

    if @props.updateGenHealth is yes

      draw = genHealthChart {
        container: @refs.genHealthSvg
        isDefault: @props.isDefault
        data: @props.data
        activeCategory: @props.activeCategory
        activeValue: @props.activeValue
        onMouseOver: @props.onMouseOver
      }

      if @props.isDefault is yes then draw.init() else draw.update()

  render: ->

    <div className="col-xs-12 col-sm-12 mb-no-padding">
      <div className="rel-bars mt-medium">
        <ControlsNew {...@props} omitted_categories={["ethnicities", "districts", "religions"]} categories=category_options values=value_options />
        <img src="./images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
          }
        />
        <svg
          className="gen-health-svg mb-oxygen"
          style={{ width: '100%', height: '465px' }}
          ref="genHealthSvg"
        >
          <g className="title-group mb-oxygen"></g>
          <g className="main-group"></g>
          <g className="y axis"></g>
          <g className="x axis"></g>
        </svg>
      </div>
    </div>  

module.exports = GenHealthChart
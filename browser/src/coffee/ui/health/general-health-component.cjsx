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

    # Update chart
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

    # Update highlights only
    if @props.updateHighlights is yes

      highlights = @props._highlights

      svg = d3.select '.gen-health-svg'
      svg.selectAll '.line'
        .attr 'opacity', (d) ->
          unless highlights.indexOf(d.key) > -1
            return 0.1
          else
            return 1
      svg.selectAll '.label'
        .attr 'opacity', (d) ->
          unless highlights.indexOf(d.key) > -1
            return 0.05
          else
            return 1

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
          style={{ width: '100%', height: '485px' }}
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
ControlsNew = require '../chart-controls-new.js'
data = require '../demographics/data/pyramid-chart-controls.js'
genHealthChart = require './d3/gen-health-chart.js'
OnsAttr = require '../../partials/chart-ons-attribution.js'

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

  componentDidMount: ->

    $(window).resize () =>
      @onResize()

  onResize: ->

    draw = genHealthChart {
      resize: yes
      container: @refs.genHealthSvg
      isDefault: @props.isDefault
      data: @props.data
      activeCategory: @props.activeCategory
      activeValue: @props.activeValue
      onMouseOver: @props.onMouseOver
      highlights: @props._highlights
      updateHighlights: @props.updateHighlights
    }

    draw.resize()

  componentDidUpdate: ->

    # Update chart
    if @props.updateGenHealth is yes

      draw = genHealthChart {
        resize: no
        container: @refs.genHealthSvg
        isDefault: @props.isDefault
        data: @props.data
        activeCategory: @props.activeCategory
        activeValue: @props.activeValue
        onMouseOver: @props.onMouseOver
        highlights: @props._highlights
        updateHighlights: @props.updateHighlights
      }

      return if @props.isDefault is yes then draw.init() else draw.update()

    # Update highlights only
    if @props.updateHighlights is yes

      draw = genHealthChart {
        data: @props.data
        highlights: @props._highlights
        updateHighlights: @props.updateHighlights
      }

      return draw.highlightDetail()

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
          className="gen-health-svg mb-oxygen"
          style={{ width: '100%', height: '485px' }}
          ref="genHealthSvg"
        >
          <g className="title-group mb-oxygen"></g>
          <g className="y axis"></g>
          <g className="x axis"></g>
          <g className="main-group"></g>
        </svg>
        <OnsAttr/>
      </div>
    </div>  

module.exports = GenHealthChart
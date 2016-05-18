ControlsNew = require '../chart-controls-new.js'
data = require '../demographics/data/pyramid-chart-controls.js'

value_options = {
  districts: data.districts
  ethnicities: data.ethnic_groups
  religions: data.religions
  regions: data.regions
  countries: data.countries
}

category_options = data.category_options

StackedAreaChart = React.createClass 

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
    </div>  

module.exports = StackedAreaChart
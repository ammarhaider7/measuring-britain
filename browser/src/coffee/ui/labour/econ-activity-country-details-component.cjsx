# drawPyrBars = require './d3/pyramidBars.js'

EconByCountryDetailComponent = React.createClass

  getAppropriateHeight: ->

    window_height = $(window).height()
    if window_height > 700
      return 320
    else
      return $(window).height() - 320

  componentDidUpdate: ->

    # if @props.updateDonut is yes
      
      # pyrBars = drawPyrBars {
      #   container: @refs.econByCountrySvg
      #   age: @props._mouseOverData.age
      #   females: @props._mouseOverData.females
      #   males: @props._mouseOverData.males
      #   initial: @props._mouseOverData.initial
      #   isDefault: @props.isDefault
      #   activeBarsValue: @props.activeBarsValue
      # }

      # pyrBars() 

  render: ->

    <div className={ unless @props.isFetching is yes and @props.isDefault is yes then 'mb-grey-box' }>
      { if @props.isFetching is yes and @props.isDefault is yes
          <img src="/images/mb_ajax_loader.gif" className="mb-spinner"/>
      }
      <svg
        className="econ-country-donut-svg" 
        style={{ width: '100%', height: @getAppropriateHeight() }}
        ref="econByCountrySvg"
      >
        <g className="labels-group"></g>
        <g className="main-group"></g>
      </svg>
    </div>

module.exports = EconByCountryDetailComponent
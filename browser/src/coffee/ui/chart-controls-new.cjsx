# React = require 'react'
# d3 = require 'd3'

ControlsNew = React.createClass
  
  onCategoryChange: (e) ->

    el = e.target
    catVal = el.getAttribute 'data-value'
    catLabel = el.innerHTML
    @props.onCategoryChange {
      value: catVal
      label: catLabel
    }

  onValueChange: (e) ->

    e.preventDefault()
    el = e.target
    valVal = el.getAttribute 'data-value'
    valLabel = el.innerHTML
    @props.onValueChange {
      value: valVal
      label: valLabel
    }
    $ethnicDiv = d3.select '#mb_ethnic_diversity'
    $el = d3.select el
    $currVals = $ethnicDiv.selectAll '.mb-pill.active'
    $currVals.classed 'active', no
    $el.classed 'active', yes

  onControlsOpen: ->
  
    $controlsContainer = d3.select @refs.controlsContainer
    isOpen = $controlsContainer.classed 'open'
    isClosed = $controlsContainer.classed 'closed'
    if isOpen then @props.onControlsClosed()
    if isClosed then @props.onControlsOpen()
    $controlsContainer
      .classed 'open', not isOpen
      .classed 'closed', not isClosed

  doSearch: (e) ->

    query = e.target.value
    @props.onDistrictSearch query

  manualControlsLinkClick: ->

    # Manually trigger click on controls link
    targetId = @refs.controlsLink.getAttribute 'data-target'
    console.log 'targetId'
    console.log targetId
    $(targetId).collapse 'toggle'
    @onControlsOpen()

  fetchData: ->

    if @props.chartName is 'sunburst' 

      fetchChartData = 'fetchSunburstData' 

    else if @props.chartName is 'relBars'

      fetchChartData = 'fetchReligionData'

    else if @props.chartName is 'economicActivityByCountry'

      fetchChartData = 'fetchEconCountryData'

    else if @props.chartName is 'disabilityChart'

      fetchChartData = 'fetchDisabilityData'
      # Need to add extra 'sex' prop so return straight away
      return do =>
        @props[fetchChartData] {
          isDefault: no
          category: @props._category
          value: @props._value
          sex: {
            label: @props.sex
            value: +@props.sex_code
          }
        }
        @manualControlsLinkClick()

    else if @props.chartName is "genHealthChart"

      fetchChartData = 'fetchGenHealthData'
      # Need to add extra 'sex' prop so return straight away
      return do =>
        @props[fetchChartData] {
          isDefault: no
          category: @props._category
          value: @props._value
          sex: {
            label: @props.sex
            value: +@props.sex_code
          }
        }
        @manualControlsLinkClick()

    @props[fetchChartData] {
      isDefault: no
      category: @props._category
      value: @props._value
    }

    @manualControlsLinkClick()

  render: -> 

    <div className="controls-container clearfix closed mb-oxygen" ref="controlsContainer">
      <a 
        onClick={ @onControlsOpen }
        ref="controlsLink"
        className="controls-toggle-link"
        role="button" data-toggle="collapse" data-target={ "#collapse#{ @props.chartName }" } aria-expanded="false" aria-controls={ "collapse#{ @props.chartName }" }
      >
        <img src="/images/mb_ajax_loader.gif" 
          className={ 
            if @props.isFetching is yes and @props.isDefault is no then 'mb-spinner-controls' else 'hide'
          }
        />
        <div className={ if @props.isFetching is yes and @props.isDefault is no then 'hide' }>
          <span className="text-center mb-control-value col-sm-5">
            { if @props.chartName is "genHealthChart" then @props.activeValue else @props.activeCategory }
          </span>
          <span className="col-sm-5 text-center mb-control-value">
            { if @props.chartName is "genHealthChart" then "Gender: #{@props.sex}" else @props.activeValue }
          </span>
          <span 
            className={ if @props.isControlsOpen is yes then "glyphicon glyphicon-chevron-up mt-medium" else "glyphicon glyphicon-chevron-down mt-medium"}
          >
          </span>
        </div>
      </a>
      <div className="collapse col-sm-12 mb-collapse" id={ "collapse#{ @props.chartName }" }>
        <div className="container col-sm-12">
          <div className="form-group mt-medium row">
            <label className="pr-medium">Filter by</label>
            <div className="btn-group">
              {
                for category, i in @props.categories
                  # unless category.value is @props.omitted_category
                  unless $.inArray(category.value, @props.omitted_categories) isnt -1
                    <button 
                      key={i} 
                      type="button" 
                      className={ if @props._category.value is category.value then "btn btn-default active" else "btn btn-default" }
                      onClick={ @onCategoryChange }
                      data-value={ category.value }
                    >
                    { category.label }
                    </button>
              }
            </div>
          </div>
          <div className="form-group row"> {
            unless @props._category.value is 'districts'
              <ul className="nav nav-pills pt-small pb-small pl-small"> {

                    for value, i in @props.values[@props._category.value]
                      <li role="presentation" key={value.value}>
                        <a 
                          data-value={ value.value }
                          href="#" 
                          className={ if @props._value.label is value.label then "mb-pill active" else "mb-pill" }
                          onClick={ @onValueChange }
                        >
                        { value.label }
                        </a>
                      </li>

              }
              </ul>
            else
              <div>
                <div className="col-sm-6">
                  <div className="input-group">
                      <span className="input-group-addon glyphicon glyphicon-search mb-glyphicon-input-addon" aria-hidden="true"></span>
                      <input 
                        type="text" 
                        className="form-control" 
                        placeholder="Search Local Authority Districts..."
                        onChange={ @doSearch }
                      />
                  </div>
                </div>
                <div className="col-sm-6 mt-xsmall">
                  <a href="//local.direct.gov.uk/LDGRedirect/Start.do?mode=1" target="_blank">What's my Local Authority District?</a>
                </div>
              </div>
          }
          </div>
          { if @props._category.value is 'districts'
            <div className="form-group row">
              {
                query = @props.district_query
                if query isnt '' and query.length > 1 and query isnt 'default'
                  <ul className="nav nav-pills pl-small pt-small pb-small"> 
                    {
                      for district, i in @props.values.districts
                        if district.label.toLowerCase().indexOf(query) isnt -1
                          <li role="presentation" key={district.value}>
                            <a 
                              data-value={ district.value }
                              href="#" 
                              className={ if @props.activeValue is district.label then "mb-pill active" else "mb-pill" }
                              onClick={ @onValueChange }
                            >
                            { district.label }
                            </a>
                          </li>
                      }
                    </ul>
                }
            </div>
          }
          <div className="row mb-medium">
            <button
              className={ if @props.isFetching is yes then "btn btn-default mb-btn-primary mb-btn-fetching" else "btn btn-default mb-btn-primary" }
              onClick={ @fetchData }
            >
            { if @props.isFetching is yes then "Loading..." else "Customise" }
            </button>
          </div>
        </div>
      </div>
    </div>

module.exports = ControlsNew
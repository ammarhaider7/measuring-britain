React = require 'react'
d3 = require 'd3'

PyramidControls = React.createClass

  onCategoryChange: (e) ->

    el = e.target
    catVal = el.getAttribute 'data-value'
    catLabel = el.innerHTML
    filteringOption = @props.filteringOption.option

    if filteringOption is 'bars'

      @props.onCategoryChange {
        value: catVal
        label: catLabel
      }

    else if filteringOption is 'line'

      @props.onOutlineCategoryChange {
        value: catVal
        label: catLabel
      }

  onValueChange: (e) ->

    e.preventDefault()
    el = e.target
    valVal = el.getAttribute 'data-value'
    valLabel = el.innerHTML
    filteringOption = @props.filteringOption.option

    if filteringOption is 'bars'

      @props.onValueChange {
        value: valVal
        label: valLabel
      }

    else if filteringOption is 'line'

      @props.onOutlineValueChange {
        value: valVal
        label: valLabel
      }

    $pyramidDiv = d3.select '#pyramid-container'
    $el = d3.select el
    $currVals = $pyramidDiv.selectAll '.mb-pill.active'
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

  fetchData: ->

    @props.fetchPyramidData {
      outlineRequested: if @props.outlineFilter is on then yes else no
      isDefault: no
      bars: {
        isDefault: no
        category: @props._barsCategory
        value: @props._barsValue
      }
      outline: {
        isDefault: no
        category: @props._outlineCategory
        value: @props._outlineValue
      }
    } 

  onToggleFilteringOption: (e) ->

    e.preventDefault()
    el = e.target
    cat = el.getAttribute 'data-option-cat'
    val = el.getAttribute 'data-option-val'
    activeCat = el.getAttribute 'data-active-cat'
    activeVal = el.getAttribute 'data-active-val'
    option = el.getAttribute 'data-option'

    if option is 'line'

      @props.onAddOutline()

    @props.onFilterOptionToggle {
      option
      cat
      val
      activeCat
      activeVal
    }

  render: -> 
    console.log 'PyramidControls props'
    console.log @props 
    <div className="controls-container clearfix closed mb-oxygen" ref="controlsContainer"> 
      <a 
        onClick={ @onControlsOpen }
        className="controls-toggle-link"
        role="button" data-toggle="collapse" data-target="#collapsePyramid" aria-expanded="false" aria-controls="collapsePyramid"
      >
        <span className="col-sm-5 text-center mb-control-value">{ "Bars - #{ @props.activeBarsValue }" }</span>
        <span className="col-sm-2 text-center mb-control-value">compared to</span>
        <span className="col-sm-5 text-center mb-control-value">{ "Line - #{ @props.activeLineValue }" }</span>
        <span 
          className={ if @props.isControlsOpen is yes then "glyphicon glyphicon-chevron-up mt-medium" else "glyphicon glyphicon-chevron-down mt-medium"}
        >
        </span>
      </a>
      <div className="collapse col-sm-12 mb-collapse" id="collapsePyramid">
        <div className="container col-sm-12">
          <ul className="nav nav-tabs mt-medium mb-controls-tabs">
            <li 
              role="presentation" 
              className={ if @props.filteringOption.option is 'bars' then "active" else ''}
            >
              <a 
                href="#"
                onClick={ @onToggleFilteringOption }
                data-option="bars"
                data-option-cat="_barsCategory" 
                data-option-val="_barsValue" 
                data-active-cat="activeBarsCategory"
                data-active-val="activeBarsValue"
              >Bars</a>
            </li>
            <li 
              role="presentation"
              className={ if @props.filteringOption.option is 'line' then "active" else ''}
            >
              <a 
                href="#"
                onClick={ @onToggleFilteringOption }
                data-option="line"
                data-option-cat="_outlineCategory" 
                data-option-val="_outlineValue"
                data-active-cat="activeLineCategory"
                data-active-val="activeLineValue"
              >+ Line</a>
            </li>
          </ul>
          <div className="form-group mt-medium row">
            <label className="pr-medium">Filter by</label>
            <div className="btn-group">
              {
                for category, i in @props.categories
                  # unless category.value is @props.omitted_category
                  <button 
                    key={i} 
                    type="button" 
                    className={ if @props[@props.filteringOption.cat].value is category.value then "btn btn-default active" else "btn btn-default" }
                    onClick={ @onCategoryChange }
                    data-value={ category.value }
                  >
                  { category.label }
                  </button>
              }
            </div>
          </div>
          <div className="form-group row"> {
            unless @props[@props.filteringOption.cat].value is 'districts'
              <ul className="nav nav-pills pt-small pb-small pl-small"> {

                    for value, i in @props.values[@props[@props.filteringOption.cat].value]
                      <li role="presentation" key={value.value}>
                        <a
                          data-value={ value.value }
                          href="#" 
                          className={ if @props[@props.filteringOption.val].label is value.label then "mb-pill active" else "mb-pill" }
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
          { if @props[@props.filteringOption.cat].value is 'districts'
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
                              className={ if @props[@props.filteringOption.val].label is district.label then "mb-pill active" else "mb-pill" }
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

module.exports = PyramidControls
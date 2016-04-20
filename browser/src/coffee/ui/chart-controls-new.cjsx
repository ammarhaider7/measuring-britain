React = require 'react'
d3 = require 'd3'

ControlsNew = React.createClass
  
  onCategoryChange: (el) ->

    catVal = el.target.getAttribute 'data-value'
    catLabel = el.target.innerHTML
    @props.onCategoryChange {
      value: catVal
      label: catLabel
    }

  onControlsOpen: ->

    $controlsContainer = d3.select @refs.controlsContainer
    isOpen = $controlsContainer.classed 'open'
    isClosed = $controlsContainer.classed 'closed'
    if isOpen then @props.onControlsClosed()
    if isClosed then @props.onControlsOpen()
    $controlsContainer
      .classed 'open', not isOpen
      .classed 'closed', not isClosed

  render: -> 

    <div className="controls-container clearfix closed mb-oxygen" ref="controlsContainer"> 
      <a 
        onClick={ @onControlsOpen }
        role="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne"
      >
          <span className="text-center mb-control-value col-sm-5">{ @props.activeCategory }</span>
          <span className="col-sm-5 text-center mb-control-value">{ @props.activeValue }</span>
          <span 
            className={ if @props.isControlsOpen is yes then "glyphicon glyphicon-chevron-up mt-medium" else "glyphicon glyphicon-chevron-down mt-medium"}
          >
          </span>
      </a>
      <div className="collapse col-sm-12 mb-collapse" id="collapseOne">
        <div className="container col-sm-12">
          <div className="form-group mt-medium row">
            <label className="pr-medium">Filter by</label>
            <div className="btn-group">
              {
                for category, i in @props.categories
                  unless category.value is 'ethnicities'
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
          <div className="form-group row">
            <ul className="nav nav-pills">
              { 
                unless @props._category.value is 'default'
                  for value, i in @props.values[@props._category.value] 
                    <li role="presentation" key={i} data-value={ value.value }><a href="#">{ value.label }</a></li>
              }
            </ul>
          </div>
        </div>
      </div>
    </div>

module.exports = ControlsNew
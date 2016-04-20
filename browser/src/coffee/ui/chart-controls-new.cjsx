React = require 'react'
d3 = require 'd3'

ControlsNew = React.createClass
  onControlsOpen: ->

    $controlsContainer = d3.select @refs.controlsContainer
    isOpen = $controlsContainer.classed 'open'
    isClosed = $controlsContainer.classed 'closed'
    $controlsContainer
      .classed 'open', not isOpen
      .classed 'closed', not isClosed

  render: -> 
    <div className="controls-container clearfix closed" ref="controlsContainer"> 
      <a 
        onClick={ @onControlsOpen }
        role="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne"
      >
          <span className="text-center mb-control-value col-sm-5">{ @props.activeCategory }</span>
          <span className="col-sm-5 text-center mb-control-value">{ @props.activeValue }</span>
          <span className="glyphicon glyphicon-chevron-down mt-medium"></span>
      </a>
      <div className="collapse col-sm-12" id="collapseOne">
        <div>
          <div className="form-group mt-medium">
            <div className="btn-group">
              <button type="button" className="btn btn-default">Left</button>
              <button type="button" className="btn btn-default">Middle</button>
              <button type="button" className="btn btn-default">Middle</button>
              <button type="button" className="btn btn-default">Middle</button>
              <button type="button" className="btn btn-default">Right</button>
            </div>
          </div>
        </div>
      </div>
    </div>

module.exports = ControlsNew
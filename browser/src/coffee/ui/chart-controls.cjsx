React = require 'react'
ReactDOM = require 'react-dom'

Controls = React.createClass
  render: ->
    <form className="form-inline">
      <div className="form-group">
        <label className="control-label">Filter by</label>
        <select className="form-control pyramid-controls-category input-sm">
        </select>
      </div>
      <div className="form-group">
        <select className="form-control pyramid-controls-value col-sm-10 chosen-select input-sm">
        </select>
      </div>
      <div className="form-group">
        <button id="pyramid-build" type="button" className="btn btn-primary btn-sm">Go</button>
        <span className="glyphicon glyphicon-ok ajax-success invisible" aria-hidden="true"></span>
      </div>
    </form>

module.exports = Controls
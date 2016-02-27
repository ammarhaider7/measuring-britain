React = require 'react'

TableComponent = React.createClass 
  newOptions: {
      category: 'table click category'
      value: 'table click value'
    } 
  render: ->
    <table className="table table-condensed table-hover table-striped" onClick={() =>
      @props.onTableClick @newOptions}
      >
      <tbody>
        <tr>
          <th><strong>Category</strong></th>
          <th><strong>Value</strong></th>
        </tr>
      <tr>
        <td>Category</td> 
        <td>{@props.category}</td>
      </tr>
      <tr>
        <td>Value</td>
        <td>{@props.value}</td>
      </tr>
      </tbody>
    </table>

module.exports = TableComponent
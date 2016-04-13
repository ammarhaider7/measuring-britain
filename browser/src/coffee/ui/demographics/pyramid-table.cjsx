React = require 'react'
d3 = require 'd3'
format = d3.format '.3s'

TableComponent = React.createClass 
  render: ->
    <table className="table table-condensed table-hover table-striped mb-oxygen">
      <tbody>
        <tr>
          <td>{ if @props.activeBarsCategory is 'default' then 'Geography:' else @props.activeBarsCategory + ':'}</td>
          <td><strong>{ if @props.activeBarsValue is 'default' then 'England \& Wales' else @props.activeBarsValue }</strong></td>
        </tr>
        <tr>
          <td>Total population:</td> 
          <td><strong>{ if @props.data.bars.sum? then format @props.data.bars.sum else '' }</strong></td>
        </tr>
        <tr>
          <td>Total male:</td>
          <td><strong>{ if @props.data.bars.malesSum? then format @props.data.bars.malesSum else '' }</strong></td>
        </tr>
        <tr>   
          <td>Total female:</td>
          <td><strong>{ if @props.data.bars.femalesSum? then format @props.data.bars.femalesSum else '' }</strong></td>
        </tr>
      </tbody>
    </table>

module.exports = TableComponent
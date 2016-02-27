{ connect } = require 'react-redux'
{ toggleFilter } = require '../actions/actions.js'
PyramidComponent = require '../../ui/demographics/pyramid-component.js'
TableComponent = require '../../ui/demographics/pyramid-table.js'

mapStateToProps = (state) ->
	category: state.filterOptions.options.category
	value: state.filterOptions.options.value

mapDispatchToProps = (dispatch) ->
	onTableClick: (options) ->
		dispatch toggleFilter options

Pyramid = connect(
	mapStateToProps, 
	mapDispatchToProps
)(PyramidComponent)

Table = connect(
	mapStateToProps, 
	mapDispatchToProps
)(TableComponent)

module.exports = {
	Pyramid
	Table
}
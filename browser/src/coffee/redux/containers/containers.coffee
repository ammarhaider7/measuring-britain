{ connect } = require 'react-redux'
{ toggleCategory } = require '../actions/actions.js'
PyramidComponent = require '../../ui/demographics/pyramid-component.js'
TableComponent = require '../../ui/demographics/pyramid-table.js'

mapStateToProps = (state) ->
	category: state.pyramidChart.category
	value: state.pyramidChart.value
	data: state.pyramidChart.data
	showSpinner: state.pyramidChart.isFetching

mapDispatchToProps = (dispatch) ->
	onCategoryChange: (event) ->
		dispatch toggleCategory event.target.value

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
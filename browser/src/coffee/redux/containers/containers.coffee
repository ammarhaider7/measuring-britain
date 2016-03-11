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
		if typeof event isnt "string"
			dispatch toggleCategory event.target.value
		else
			dispatch toggleCategory event

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
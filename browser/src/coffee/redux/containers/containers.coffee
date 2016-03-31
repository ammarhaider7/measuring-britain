{ connect } = require 'react-redux'
{ toggleCategory, addFilter, toggleOutlineCategory, toggleValue, removeFilter, toggleOutlineValue, requestPyramidData, fetchPyramidData } = require '../actions/demographics-actions.js'
PyramidComponent = require '../../ui/demographics/pyramid-component.js'
TableComponent = require '../../ui/demographics/pyramid-table.js'

mapStateToProps = (state) ->
	chartName: state.pyramidChart.chartName
	_barsCategory: state.pyramidChart._barsCategory
	_barsValue: state.pyramidChart._barsValue	
	data: state.pyramidChart.data
	isFetching: state.pyramidChart.isFetching
	outlineFilter: state.pyramidChart.outlineFilter
	_outlineCategory: state.pyramidChart._outlineCategory	
	_outlineValue: state.pyramidChart._outlineValue
	error: state.pyramidChart.error

mapDispatchToProps = (dispatch) ->
	onCategoryChange: (category, selectedOption) ->
		dispatch toggleCategory category, selectedOption[0]
	onValueChange: (value, selectedOption) ->
		dispatch toggleValue value, selectedOption[0]
	onAddOutline: () ->
		dispatch addFilter()
	onRemoveFilter: () ->
		dispatch removeFilter()
	onOutlineCategoryChange: (value, selectedOption) ->
		dispatch toggleOutlineCategory value, selectedOption[0]
	onOutlineValueChange: (value, selectedOption) ->
		dispatch toggleOutlineValue value, selectedOption[0]
	fetchPyramidData: (filterOptions) ->
		dispatch fetchPyramidData filterOptions

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
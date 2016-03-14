{ connect } = require 'react-redux'
{ toggleCategory, addFilter, toggleOutlineCategory, toggleValue, removeFilter } = require '../actions/demographics-actions.js'
PyramidComponent = require '../../ui/demographics/pyramid-component.js'
TableComponent = require '../../ui/demographics/pyramid-table.js'

mapStateToProps = (state) ->
	chartName: state.pyramidChart.chartName
	category: state.pyramidChart.category
	value: state.pyramidChart.value
	data: state.pyramidChart.data
	showSpinner: state.pyramidChart.isFetching
	outlineFilter: state.pyramidChart.outlineFilter
	outlineCategory: state.pyramidChart.outlineCategory

mapDispatchToProps = (dispatch) ->
	onCategoryChange: (category) ->
		dispatch toggleCategory category
	onValueChange: (value) ->
		dispatch toggleValue value
	onAddOutline: () ->
		dispatch addFilter()
	onRemoveFilter: () ->
		dispatch removeFilter()
	onOutlineCategoryChange: (value) ->
		dispatch toggleOutlineCategory value

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
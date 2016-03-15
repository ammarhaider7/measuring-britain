{ connect } = require 'react-redux'
{ toggleCategory, addFilter, toggleOutlineCategory, toggleValue, removeFilter, toggleOutlineValue } = require '../actions/demographics-actions.js'
PyramidComponent = require '../../ui/demographics/pyramid-component.js'
TableComponent = require '../../ui/demographics/pyramid-table.js'

mapStateToProps = (state) ->
	chartName: state.pyramidChart.chartName
	barsCategory: state.pyramidChart.barsCategory
	_barsCategory: state.pyramidChart._barsCategory
	barsValue: state.pyramidChart.barsValue
	_barsValue: state.pyramidChart._barsValue	
	data: state.pyramidChart.data
	showSpinner: state.pyramidChart.isFetching
	outlineFilter: state.pyramidChart.outlineFilter
	outlineCategory: state.pyramidChart.outlineCategory
	_outlineCategory: state.pyramidChart._outlineCategory	
	outlineValue: state.pyramidChart.outlineValue
	_outlineValue: state.pyramidChart._outlineValue
	barsOptions: state.pyramidChart.barsOptions
	outlineOptions: state.pyramidChart.outlineOptions

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
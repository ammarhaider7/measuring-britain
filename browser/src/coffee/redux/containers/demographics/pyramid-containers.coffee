{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory 
  addFilter
  toggleOutlineCategory 
  toggleValue 
  removeFilter
  toggleOutlineValue
  requestPyramidData
  fetchPyramidData } = require '../../actions/demographics/pyramid-actions.js'
PyramidComponent = require '../../../ui/demographics/pyramid-component.js'
TableComponent = require '../../../ui/demographics/pyramid-table.js'
pyBarsComponent = require '../../../ui/demographics/pyramid-bars.js'

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
	updatePyramid: state.pyramidChart.updatePyramid
	isDefault: state.pyramidChart.isDefault
	updateOutline: state.pyramidChart.updateOutline

mapStateToPropsPyrTable = (state) ->

	data: state.pyramidChart.data
	activeBarsCategory: state.pyramidChart.activeBarsCategory
	activeBarsValue: state.pyramidChart.activeBarsValue	
	isFetching: state.pyramidChart.isFetching
	isDefault: state.pyramidChart.isDefault

mapStateToPropsPyrBars = (state) ->

	_mouseOverData: state.pyramidChart._mouseOverData
	updateBars: state.pyramidChart.updateBars
	isFetching: state.pyramidChart.isFetching
	isDefault: state.pyramidChart.isDefault
	activeBarsCategory: state.pyramidChart.activeBarsCategory
	activeBarsValue: state.pyramidChart.activeBarsValue

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
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData

Pyramid = connect(
	mapStateToProps, 
	mapDispatchToProps
)(PyramidComponent)

Table = connect(
	mapStateToPropsPyrTable
)(TableComponent)

Bars = connect(
	mapStateToPropsPyrBars
)(pyBarsComponent)

module.exports = {
	Pyramid
	Table
	Bars
}
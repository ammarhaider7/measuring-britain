{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory 
  addFilter
  toggleOutlineCategory 
  toggleValue 
  removeFilter
  toggleOutlineValue
  requestPyramidData
  fetchPyramidData
  districtSearch
  controlsOpened
  controlsClosed
  toggleFilteringOption } = require '../../actions/demographics/pyramid-actions.js'
PyramidComponent = require '../../../ui/demographics/pyramid-component.js'
TableComponent = require '../../../ui/demographics/pyramid-table.js'
pyBarsComponent = require '../../../ui/demographics/pyramid-bars.js'

mapStateToProps = (state) ->

	chartName: state.pyramidChart.chartName
	_barsCategory: state.pyramidChart._barsCategory
	_barsValue: state.pyramidChart._barsValue
	activeBarsCategory: state.pyramidChart.activeBarsCategory
	activeBarsValue: state.pyramidChart.activeBarsValue		
	activeLineCategory: state.pyramidChart.activeLineCategory
	activeLineValue: state.pyramidChart.activeLineValue		
	data: state.pyramidChart.data
	isFetching: state.pyramidChart.isFetching
	district_query: state.pyramidChart.district_query
	outlineFilter: state.pyramidChart.outlineFilter
	_outlineCategory: state.pyramidChart._outlineCategory	
	_outlineValue: state.pyramidChart._outlineValue
	error: state.pyramidChart.error
	updatePyramid: state.pyramidChart.updatePyramid
	isDefault: state.pyramidChart.isDefault
	updateOutline: state.pyramidChart.updateOutline
	filteringOption: state.pyramidChart.filteringOption
	isControlsOpen: state.pyramidChart.isControlsOpen

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

	onCategoryChange: (category) ->
		dispatch toggleCategory category
	onValueChange: (value) ->
		dispatch toggleValue value
	onAddOutline: () ->
		dispatch addFilter()
	onRemoveFilter: () ->
		dispatch removeFilter()
	onOutlineCategoryChange: (category) ->
		dispatch toggleOutlineCategory category
	onOutlineValueChange: (value) ->
		dispatch toggleOutlineValue value
	fetchPyramidData: (filterOptions) ->
		dispatch fetchPyramidData filterOptions
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData
	onControlsClosed: () ->
		dispatch controlsClosed()
	onControlsOpen: () ->
		dispatch controlsOpened()
	onDistrictSearch: (query) ->
		dispatch districtSearch query
	onFilterOptionToggle: (option) ->
		dispatch toggleFilteringOption option

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
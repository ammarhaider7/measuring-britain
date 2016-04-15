{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  requestSunburstData
  fetchSunburstData } = require '../../actions/demographics/ethnic-sunburst-actions.js'

SunburstComponent = require '../../../ui/demographics/ethnic-sunburst-component.js'
# TableComponent = require '../../../ui/demographics/pyramid-table.js'

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

# mapStateToPropsPyrTable = (state) ->

# 	data: state.pyramidChart.data
# 	activeBarsCategory: state.pyramidChart.activeBarsCategory
# 	activeBarsValue: state.pyramidChart.activeBarsValue	
# 	isFetching: state.pyramidChart.isFetching
# 	isDefault: state.pyramidChart.isDefault

mapDispatchToProps = (dispatch) ->

	onCategoryChange: (category, selectedOption) ->
		dispatch toggleCategory category, selectedOption[0]
	onValueChange: (value, selectedOption) ->
		dispatch toggleValue value, selectedOption[0]
	fetchSunburstData: (filterOptions) ->
		dispatch fetchSunburstData filterOptions
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData

Sunburst = connect(
	mapStateToProps, 
	mapDispatchToProps
)(SunburstComponent)

# SunburstTable = connect(
# 	mapStateToPropsPyrTable
# )(TableComponent)

module.exports = {
	Sunburst
}
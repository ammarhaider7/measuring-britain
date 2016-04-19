{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  requestSunburstData
  fetchSunburstData } = require '../../actions/demographics/ethnic-sunburst-actions.js'

SunburstComponent = require '../../../ui/demographics/ethnic-sunburst-component.js'
# TableComponent = require '../../../ui/demographics/pyramid-table.js'

mapStateToProps = (state) ->

	chartName: state.ethnicSunburst.chartName
	_category: state.ethnicSunburst._category
	_value: state.ethnicSunburst._value	
	data: state.ethnicSunburst.data
	isFetching: state.ethnicSunburst.isFetching
	activeCategory: state.ethnicSunburst.activeCategory
	activeValue: state.ethnicSunburst.activeValue	
	error: state.ethnicSunburst.error
	updateSunburst: state.ethnicSunburst.updateSunburst
	isDefault: state.ethnicSunburst.isDefault

# mapStateToPropsPyrTable = (state) ->

# 	data: state.ethnicSunburst.data
# 	activeBarsCategory: state.ethnicSunburst.activeBarsCategory
# 	activeBarsValue: state.ethnicSunburst.activeBarsValue	
# 	isFetching: state.ethnicSunburst.isFetching
# 	isDefault: state.ethnicSunburst.isDefault

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
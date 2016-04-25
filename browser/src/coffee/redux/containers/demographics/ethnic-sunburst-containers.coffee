{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  requestSunburstData
  fetchSunburstData
  controlsOpened
  controlsClosed
  districtSearch } = require '../../actions/demographics/ethnic-sunburst-actions.js'

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
	isControlsOpen: state.ethnicSunburst.isControlsOpen
	district_query: state.ethnicSunburst.district_query

# mapStateToPropsPyrTable = (state) ->

# 	data: state.ethnicSunburst.data
# 	activeBarsCategory: state.ethnicSunburst.activeBarsCategory
# 	activeBarsValue: state.ethnicSunburst.activeBarsValue	
# 	isFetching: state.ethnicSunburst.isFetching
# 	isDefault: state.ethnicSunburst.isDefault

mapDispatchToProps = (dispatch) ->

	onCategoryChange: (category) ->
		dispatch toggleCategory category
	onValueChange: (value) ->
		dispatch toggleValue value
	onControlsOpen: () ->
		dispatch controlsOpened()
	onControlsClosed: () ->
		dispatch controlsClosed()
	fetchSunburstData: (filterOptions) ->
		dispatch fetchSunburstData filterOptions
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData
	onDistrictSearch: (query) ->
		dispatch districtSearch query

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
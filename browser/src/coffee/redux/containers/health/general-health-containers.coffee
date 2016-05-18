{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  requestReligionData
  fetchReligionData
  controlsOpened
  controlsClosed
  districtSearch
  initBars
  initBarsOff
  initDone } = require '../../actions/health/general-health-actions.js'

StackedAreaComponent = require '../../../ui/health/general-health-component.js'

mapStateToProps = (state) ->

	chartName: state.stackedAreaChart.chartName
	_category: state.stackedAreaChart._category
	_value: state.stackedAreaChart._value	
	data: state.stackedAreaChart.data
	isFetching: state.stackedAreaChart.isFetching
	activeCategory: state.stackedAreaChart.activeCategory
	activeValue: state.stackedAreaChart.activeValue	
	error: state.stackedAreaChart.error
	updateRelBars: state.stackedAreaChart.updateRelBars
	isDefault: state.stackedAreaChart.isDefault
	isControlsOpen: state.stackedAreaChart.isControlsOpen
	district_query: state.stackedAreaChart.district_query
	init_bars: state.stackedAreaChart.init_bars
	init_done: state.stackedAreaChart.init_done

mapDispatchToProps = (dispatch) ->

	onCategoryChange: (category) ->
		dispatch toggleCategory category
	onValueChange: (value) ->
		dispatch toggleValue value
	onControlsOpen: () ->
		dispatch controlsOpened()
	onControlsClosed: () ->
		dispatch controlsClosed()
	fetchReligionData: (filterOptions) ->
		dispatch fetchReligionData filterOptions
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData
	onDistrictSearch: (query) ->
		dispatch districtSearch query
	onInitBars: () ->
		dispatch initBars()
	offInitBars: () ->
		dispatch initBarsOff()
	onInitDone: () ->
		dispatch initDone()

StackedAreaChart = connect(
	mapStateToProps,
	mapDispatchToProps
)(StackedAreaComponent)

module.exports = {
	StackedAreaChart
}
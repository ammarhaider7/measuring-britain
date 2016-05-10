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
  initDone } = require '../../actions/demographics/religion-bars-actions.js'

ReligionBarsComponent = require '../../../ui/demographics/religion-bars-component.js'

mapStateToProps = (state) ->

	chartName: state.relBarChart.chartName
	_category: state.relBarChart._category
	_value: state.relBarChart._value	
	data: state.relBarChart.data
	isFetching: state.relBarChart.isFetching
	activeCategory: state.relBarChart.activeCategory
	activeValue: state.relBarChart.activeValue	
	error: state.relBarChart.error
	updateBars: state.relBarChart.updateBars
	isDefault: state.relBarChart.isDefault
	isControlsOpen: state.relBarChart.isControlsOpen
	district_query: state.relBarChart.district_query
	init_bars: state.relBarChart.init_bars
	init_done: state.relBarChart.init_done

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

ReligionBars = connect(
	mapStateToProps,
	mapDispatchToProps
)(ReligionBarsComponent)

module.exports = {
	ReligionBars
}
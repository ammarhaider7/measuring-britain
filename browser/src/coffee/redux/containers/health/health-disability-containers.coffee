{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  toggleSex
  requestDisabilityData
  fetchDisabilityData
  controlsOpened
  controlsClosed
  districtSearch
  initDisability
  initDisabilityOff
  initDone } = require '../../actions/health/health-disability-actions.js'

DisabilityChartComponent = require '../../../ui/health/health-disability-component.js'

mapStateToProps = (state) ->

	chartName: state.disabilityChart.chartName
	_category: state.disabilityChart._category
	_value: state.disabilityChart._value	
	data: state.disabilityChart.data
	isFetching: state.disabilityChart.isFetching
	activeCategory: state.disabilityChart.activeCategory
	activeValue: state.disabilityChart.activeValue	
	error: state.disabilityChart.error
	updateDisability: state.disabilityChart.updateDisability
	isDefault: state.disabilityChart.isDefault
	isControlsOpen: state.disabilityChart.isControlsOpen
	district_query: state.disabilityChart.district_query
	init_disability: state.disabilityChart.init_gen_health
	init_done: state.disabilityChart.init_done
	sex: state.disabilityChart.sex
	sex_code: state.disabilityChart.sex_code

mapDispatchToProps = (dispatch) ->

	onCategoryChange: (category) ->
		dispatch toggleCategory category
	onValueChange: (value) ->
		dispatch toggleValue value
	onControlsOpen: () ->
		dispatch controlsOpened()
	onControlsClosed: () ->
		dispatch controlsClosed()
	fetchDisabilityData: (filterOptions) ->
		dispatch fetchDisabilityData filterOptions
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData
	onDistrictSearch: (query) ->
		dispatch districtSearch query
	onInitDisability: () ->
		dispatch initDisability()
	offInitDisability: () ->
		dispatch initDisabilityOff()
	onInitDone: () ->
		dispatch initDone()

DisabilityChart = connect(
	mapStateToProps,
	mapDispatchToProps
)(DisabilityChartComponent)

module.exports = {
	DisabilityChart
}
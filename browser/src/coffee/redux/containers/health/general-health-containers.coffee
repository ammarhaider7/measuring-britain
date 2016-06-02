{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  requestGenHealthData
  fetchGenHealthData
  controlsOpened
  controlsClosed
  districtSearch
  initGenHealth
  initGenHealthOff
  initDone } = require '../../actions/health/general-health-actions.js'

GenHealthChartComponent = require '../../../ui/health/general-health-component.js'
GenHealthChartDetailComponent = require '../../../ui/health/general-health-detail-component.js'

mapStateToProps = (state) ->

	chartName: state.genHealthChart.chartName
	_category: state.genHealthChart._category
	_value: state.genHealthChart._value	
	data: state.genHealthChart.data
	isFetching: state.genHealthChart.isFetching
	activeCategory: state.genHealthChart.activeCategory
	activeValue: state.genHealthChart.activeValue	
	error: state.genHealthChart.error
	updateGenHealth: state.genHealthChart.updateGenHealth
	isDefault: state.genHealthChart.isDefault
	isControlsOpen: state.genHealthChart.isControlsOpen
	district_query: state.genHealthChart.district_query
	init_gen_health: state.genHealthChart.init_gen_health
	init_done: state.genHealthChart.init_done

mapStateToPropsDetail = (state) ->

	data: state.genHealthChart.data
	activeCategory: state.genHealthChart.activeCategory
	activeValue: state.genHealthChart.activeValue	
	isFetching: state.genHealthChart.isFetching
	isDefault: state.genHealthChart.isDefault
	mouseOverData: state.genHealthChart._mouseOverData
	updateTable: state.genHealthChart.updateTable

mapDispatchToProps = (dispatch) ->

	onCategoryChange: (category) ->
		dispatch toggleCategory category
	onValueChange: (value) ->
		dispatch toggleValue value
	onControlsOpen: () ->
		dispatch controlsOpened()
	onControlsClosed: () ->
		dispatch controlsClosed()
	fetchGenHealthData: (filterOptions) ->
		dispatch fetchGenHealthData filterOptions
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData
	onDistrictSearch: (query) ->
		dispatch districtSearch query
	onInitGenHealth: () ->
		dispatch initGenHealth()
	offInitGenHealth: () ->
		dispatch initGenHealthOff()
	onInitDone: () ->
		dispatch initDone()

GenHealthChart = connect(
	mapStateToProps,
	mapDispatchToProps
)(GenHealthChartComponent)

GenHealthChartDetail = connect(
	mapStateToPropsDetail
)(GenHealthChartDetailComponent)

module.exports = {
	GenHealthChart
	GenHealthChartDetail
}
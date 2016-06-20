{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  requestEconCountryData
  fetchEconCountryData
  controlsOpened
  controlsClosed
  districtSearch
  initEconCountry
  initEconCountryOff
  initDone } = require '../../actions/labour/econ-activity-country-actions.js'

EconByCountryChartComponent = require '../../../ui/labour/econ-activity-country-component.js'
EconByCountryChartDetailComponent = require '../../../ui/labour/econ-activity-country-details-component.js'

mapStateToProps = (state) ->

	chartName: state.economicActivityByCountry.chartName
	_category: state.economicActivityByCountry._category
	_value: state.economicActivityByCountry._value	
	data: state.economicActivityByCountry.data
	isFetching: state.economicActivityByCountry.isFetching
	activeCategory: state.economicActivityByCountry.activeCategory
	activeValue: state.economicActivityByCountry.activeValue	
	error: state.economicActivityByCountry.error
	updateMainChart: state.economicActivityByCountry.updateMainChart
	isDefault: state.economicActivityByCountry.isDefault
	isControlsOpen: state.economicActivityByCountry.isControlsOpen
	district_query: state.economicActivityByCountry.district_query
	init_econ_country: state.economicActivityByCountry.init_gen_health
	init_done: state.economicActivityByCountry.init_done

mapStateToPropsDetail = (state) ->

	data: state.economicActivityByCountry.data
	_category: state.economicActivityByCountry._category
	_value: state.economicActivityByCountry._value	
	activeCategory: state.economicActivityByCountry.activeCategory
	activeValue: state.economicActivityByCountry.activeValue	
	isFetching: state.economicActivityByCountry.isFetching
	isDefault: state.economicActivityByCountry.isDefault
	mouseOverData: state.economicActivityByCountry._mouseOverData
	updateTable: state.economicActivityByCountry.updateTable

# mapDispatchToPropsDetail = (dispatch) ->

# 	fetchEconCountryData: (filterOptions) ->
# 		dispatch fetchEconCountryData filterOptions

mapDispatchToProps = (dispatch) ->

	onCategoryChange: (category) ->
		dispatch toggleCategory category
	onValueChange: (value) ->
		dispatch toggleValue value
	onControlsOpen: () ->
		dispatch controlsOpened()
	onControlsClosed: () ->
		dispatch controlsClosed()
	fetchEconCountryData: (filterOptions) ->
		dispatch fetchEconCountryData filterOptions
	onMouseOver: (mouseOverData) ->
		dispatch mouseOver mouseOverData
	onDistrictSearch: (query) ->
		dispatch districtSearch query
	onInitEconCountry: () ->
		dispatch initEconCountry()
	offInitEconCountry: () ->
		dispatch initEconCountryOff()
	onInitDone: () ->
		dispatch initDone()

EconByCountry = connect(
	mapStateToProps,
	mapDispatchToProps
)(EconByCountryChartComponent)

EconByCountryDetail = connect(
	mapStateToPropsDetail
)(EconByCountryChartDetailComponent)

module.exports = {
	EconByCountry
	EconByCountryDetail
}
{ connect } = require 'react-redux'
{ mouseOver
  toggleCategory
  toggleValue
  requestSunburstData
  fetchSunburstData
  controlsOpened
  controlsClosed
  districtSearch
  initSunburst
  initSunburstOff
  initDone } = require '../../actions/demographics/ethnic-sunburst-actions.js'

SunburstComponent = require '../../../ui/demographics/ethnic-sunburst-component.js'

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
	init_sunburst: state.ethnicSunburst.init_sunburst
	init_done: state.ethnicSunburst.init_done

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
	onInitSunburst: () ->
		dispatch initSunburst()
	offInitSunburst: () ->
		dispatch initSunburstOff()
	onInitDone: () ->
		dispatch initDone()

Sunburst = connect(
	mapStateToProps,
	mapDispatchToProps
)(SunburstComponent)

module.exports = {
	Sunburst
}
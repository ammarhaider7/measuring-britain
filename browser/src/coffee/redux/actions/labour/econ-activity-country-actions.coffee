econActCountryService = require '../../../services/nomis/labour/econ-activity-country-service.js'
econActCountryParser = require '../../../services/nomis/labour/econ-activity-country-parser.js'

REQUEST_ECON_COUNTRY_DATA = "REQUEST_ECON_COUNTRY_DATA"
RECEIVE_ECON_COUNTRY_DATA = "RECEIVE_ECON_COUNTRY_DATA"
TOGGLE_CATEGORY = "E_TOGGLE_CATEGORY"
MOUSE_OVER = "E_MOUSE_OVER"
TOGGLE_VALUE = "E_TOGGLE_VALUE"
ERROR_RECEIVE_ECON_COUNTRY_DATA = "ERROR_RECEIVE_ECON_COUNTRY_DATA"
FILTER_USED = "E_FILTER_USED"
CONTROLS_OPENED = "E_CONTROLS_OPENED"
CONTROLS_CLOSED = "E_CONTROLS_CLOSED"
DISTRICT_SEARCH = "E_DISTRICT_SEARCH"
INIT_ECON_COUNTRY = "INIT_DISABIlITY"
INIT_ECON_COUNTRY_OFF = "INIT_DISABIlITY_OFF"
INIT_DONE = "E_INIT_DONE"
# TOGGLE_SEX = "E_TOGGLE_SEX"

toggleValue = (value) ->
	{
		type: TOGGLE_VALUE
		value
	}

toggleCategory = (category) ->
	{
		type: TOGGLE_CATEGORY
		category
	}
# toggleSex = (sex, code) ->
# 	{
# 		type: TOGGLE_SEX
# 		sex: sex
# 		sex_code: code
# 	}

controlsOpened = () ->
	{
		type: CONTROLS_OPENED
		isControlsOpen: yes
	}

districtSearch = (query) ->
	{
		type: DISTRICT_SEARCH
		query: query
	}

controlsClosed = () ->
	{
		type: CONTROLS_CLOSED
		isControlsOpen: no
	}
	
mouseOver = (mouseOverData) ->
	{
		type: MOUSE_OVER
		mouseOverData: mouseOverData 
	}

initEconCountry = () ->
	{
		type: INIT_ECON_COUNTRY
	}

initEconCountryOff = () ->
	{
		type: INIT_ECON_COUNTRY_OFF
	}

initDone = () ->
	{
		type: INIT_DONE
	}

requestEconCountryData = (filterOptions) ->
	{
		type: REQUEST_ECON_COUNTRY_DATA
		filterOptions
	}

filterUsed = () ->
	{
		type: FILTER_USED
	}

receiveEconCountryData = (data) ->
	{
		type: RECEIVE_ECON_COUNTRY_DATA
		data: data
		receivedAt: Date.now()
	}

errorReceivingEconCountryData = (error) ->
	{
		type: ERROR_RECEIVE_ECON_COUNTRY_DATA
		error: error
	}

fetchEconCountryData = (filterOptions) ->
	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
 	# thus making it able to dispatch actions itself.
	(dispatch) ->

		dispatch filterUsed() if filterOptions?
		dispatch requestEconCountryData filterOptions
		econActCountryService filterOptions
			.done (response) ->
		        # We can dispatch many times!
		        # Here, we update the app state with the results of the API call.
				data = econActCountryParser response.obs
				dispatch receiveEconCountryData data
				return
			.fail (jqxhr, textStatus, error) ->
				# Handle errors..
				dispatch errorReceivingEconCountryData textStatus + " : " + error
				return

module.exports = {

	REQUEST_ECON_COUNTRY_DATA
	RECEIVE_ECON_COUNTRY_DATA
	TOGGLE_CATEGORY
	MOUSE_OVER
	TOGGLE_VALUE
	ERROR_RECEIVE_ECON_COUNTRY_DATA
	FILTER_USED
	CONTROLS_OPENED
	CONTROLS_CLOSED
	DISTRICT_SEARCH
	INIT_ECON_COUNTRY
	INIT_ECON_COUNTRY_OFF
	INIT_DONE
	# TOGGLE_SEX
	# toggleSex
	initDone
	initEconCountry
	initEconCountryOff
	mouseOver
	fetchEconCountryData
	districtSearch
	requestEconCountryData
	receiveEconCountryData
	toggleCategory
	toggleValue
	errorReceivingEconCountryData
	filterUsed
	controlsOpened
	controlsClosed

}
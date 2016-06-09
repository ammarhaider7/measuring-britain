disabilityService = require '../../../services/nomis/health/health-disability-service.js'
disabilityDataParser = require '../../../services/nomis/health/health-disability-parser.js'

REQUEST_DISABILITY_DATA = "REQUEST_DISABIlITY_DATA"
RECEIVE_DISABILITY_DATA = "RECEIVE_DISABIlITY_DATA"
TOGGLE_CATEGORY = "D_TOGGLE_CATEGORY"
MOUSE_OVER = "D_MOUSE_OVER"
TOGGLE_VALUE = "D_TOGGLE_VALUE"
ERROR_RECEIVE_DISABILITY_DATA = "ERROR_RECEIVE_DISABIlITY_DATA"
FILTER_USED = "D_FILTER_USED"
CONTROLS_OPENED = "D_CONTROLS_OPENED"
CONTROLS_CLOSED = "D_CONTROLS_CLOSED"
DISTRICT_SEARCH = "D_DISTRICT_SEARCH"
INIT_DISABILITY = "INIT_DISABIlITY"
INIT_DISABILITY_OFF = "INIT_DISABIlITY_OFF"
INIT_DONE = "D_INIT_DONE"
TOGGLE_SEX = "D_TOGGLE_SEX"

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
toggleSex = (sex, code) ->
	{
		type: TOGGLE_SEX
		sex: sex
		sex_code: code
	}

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

initDisability = () ->
	{
		type: INIT_BARS
	}

initDisabilityOff = () ->
	{
		type: INIT_BARS_OFF
	}

initDone = () ->
	{
		type: INIT_DONE
	}

requestDisabilityData = (filterOptions) ->
	{
		type: REQUEST_DISABILITY_DATA
		filterOptions
	}

filterUsed = () ->
	{
		type: FILTER_USED
	}

receiveDisabilityData = (data) ->
	{
		type: RECEIVE_DISABILITY_DATA
		data: data
		receivedAt: Date.now()
	}

errorReceivingeDisabilityData = (error) ->
	{
		type: ERROR_RECEIVE_DISABILITY_DATA
		error: error
	}

fetchDisabilityData = (filterOptions) ->

	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
 	# thus making it able to dispatch actions itself.
	(dispatch) ->

		dispatch filterUsed() if filterOptions?
		dispatch requestDisabilityData filterOptions
		disabilityService filterOptions
			.done (response) ->
		        # We can dispatch many times!
		        # Here, we update the app state with the results of the API call.
				data = disabilityDataParser response.obs
				dispatch receiveDisabilityData data
				return
			.fail (jqxhr, textStatus, error) ->
				# Handle errors..
				dispatch errorReceivingeDisabilityData textStatus + " : " + error
				return

module.exports = {

	REQUEST_DISABILITY_DATA
	RECEIVE_DISABILITY_DATA
	TOGGLE_CATEGORY
	MOUSE_OVER
	TOGGLE_VALUE
	ERROR_RECEIVE_DISABILITY_DATA
	FILTER_USED
	CONTROLS_OPENED
	CONTROLS_CLOSED
	DISTRICT_SEARCH
	INIT_DISABILITY
	INIT_DISABILITY_OFF
	INIT_DONE
	TOGGLE_SEX
	toggleSex
	initDone
	initDisability
	initDisabilityOff
	mouseOver
	fetchDisabilityData
	districtSearch
	requestDisabilityData
	receiveDisabilityData
	toggleCategory
	toggleValue
	errorReceivingeDisabilityData
	filterUsed
	controlsOpened
	controlsClosed

}
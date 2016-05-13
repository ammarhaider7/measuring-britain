relBarsService = require '../../../services/nomis/demographics/rel-bars-service.js'
relBarsDataParser = require '../../../services/nomis/demographics/rel-bars-parser.js'

REQUEST_RELIGION_DATA = "REQUEST_RELIGION_DATA"
RECEIVE_RELIGION_DATA = "RECEIVE_RELIGION_DATA"
TOGGLE_CATEGORY = "R_TOGGLE_CATEGORY"
MOUSE_OVER = "R_MOUSE_OVER"
TOGGLE_VALUE = "R_TOGGLE_VALUE"
ERROR_RECEIVE_RELIGION_DATA = "ERROR_RECEIVE_RELIGION_DATA"
FILTER_USED = "R_FILTER_USED"
CONTROLS_OPENED = "R_CONTROLS_OPENED"
CONTROLS_CLOSED = "R_CONTROLS_CLOSED"
DISTRICT_SEARCH = "R_DISTRICT_SEARCH"
INIT_BARS = "INIT_BARS"
INIT_BARS_OFF = "INIT_BARS_OFF"
INIT_DONE = "INIT_DONE"

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

initBars = () ->
	{
		type: INIT_BARS
	}

initBarsOff = () ->
	{
		type: INIT_BARS_OFF
	}

initDone = () ->
	{
		type: INIT_DONE
	}

requestReligionData = (filterOptions) ->
	{
		type: REQUEST_RELIGION_DATA
		filterOptions
	}

filterUsed = () ->
	{
		type: FILTER_USED
	}

receiveReligionData = (data) ->
	{
		type: RECEIVE_RELIGION_DATA
		data: data
		receivedAt: Date.now()
	}

errorReceivingeReligionData = (error) ->
	{
		type: ERROR_RECEIVE_RELIGION_DATA
		error: error
	}

fetchReligionData = (filterOptions) ->

	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
 	# thus making it able to dispatch actions itself.
	(dispatch) ->

		dispatch filterUsed() if filterOptions?
		dispatch requestReligionData filterOptions
		relBarsService(filterOptions)
			.done (response) ->
		        # We can dispatch many times!
		        # Here, we update the app state with the results of the API call.
				data = relBarsDataParser response.obs
				dispatch receiveReligionData data
				return
			.fail (jqxhr, textStatus, error) ->
				# Handle errors..
				dispatch errorReceivingeEthnicData textStatus + " : " + error
				return

module.exports = {

	REQUEST_RELIGION_DATA
	RECEIVE_RELIGION_DATA
	TOGGLE_CATEGORY
	MOUSE_OVER
	TOGGLE_VALUE
	ERROR_RECEIVE_RELIGION_DATA
	FILTER_USED
	CONTROLS_OPENED
	CONTROLS_CLOSED
	DISTRICT_SEARCH
	INIT_BARS
	INIT_BARS_OFF
	INIT_DONE
	initDone
	initBars
	initBarsOff
	mouseOver
	fetchReligionData
	districtSearch
	requestReligionData
	receiveReligionData
	toggleCategory
	toggleValue
	errorReceivingeReligionData
	filterUsed
	controlsOpened
	controlsClosed

}
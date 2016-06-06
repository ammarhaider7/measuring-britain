genHealthService = require '../../../services/nomis/health/general-health-service.js'
genHealthDataParser = require '../../../services/nomis/health/general-health-parser.js'

REQUEST_GEN_HEALTH_DATA = "REQUEST_GEN_HEALTH_DATA"
RECEIVE_GEN_HEALTH_DATA = "RECEIVE_GEN_HEALTH_DATA"
TOGGLE_CATEGORY = "H_TOGGLE_CATEGORY"
MOUSE_OVER = "H_MOUSE_OVER"
HIGHLIGHT_LINE = "HIGHLIGHT_LINE"
UNHIGHLIGHT_LINE = "UNHIGHLIGHT_LINE"
TOGGLE_VALUE = "H_TOGGLE_VALUE"
ERROR_RECEIVE_GEN_HEALTH_DATA = "ERROR_RECEIVE_GEN_HEALTH_DATA"
FILTER_USED = "H_FILTER_USED"
CONTROLS_OPENED = "H_CONTROLS_OPENED"
CONTROLS_CLOSED = "H_CONTROLS_CLOSED"
DISTRICT_SEARCH = "H_DISTRICT_SEARCH"
INIT_GEN_HEALTH = "INIT_GEN_HEALTH"
INIT_GEN_HEALTH_OFF = "INIT_GEN_HEALTH_OFF"
INIT_DONE = "INIT_DONE"
TOGGLE_SEX = "TOGGLE_SEX"

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

highlightLine = (ethnicity) ->
	{
		type: HIGHLIGHT_LINE
		ethnicity: ethnicity
	}
unHighlightLine = (ethnicity, index) ->
	{
		type: UNHIGHLIGHT_LINE
		ethnicity: ethnicity
		index: index
	}

initGenHealth = () ->
	{
		type: INIT_BARS
	}

initGenHealthOff = () ->
	{
		type: INIT_BARS_OFF
	}

initDone = () ->
	{
		type: INIT_DONE
	}

requestGenHealthData = (filterOptions) ->
	{
		type: REQUEST_GEN_HEALTH_DATA
		filterOptions
	}

filterUsed = () ->
	{
		type: FILTER_USED
	}

receiveGenHealthData = (data) ->
	{
		type: RECEIVE_GEN_HEALTH_DATA
		data: data
		receivedAt: Date.now()
	}

errorReceivingeGenHealthData = (error) ->
	{
		type: ERROR_RECEIVE_GEN_HEALTH_DATA
		error: error
	}

fetchGenHealthData = (filterOptions) ->

	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
 	# thus making it able to dispatch actions itself.
	(dispatch) ->

		dispatch filterUsed() if filterOptions?
		dispatch requestGenHealthData filterOptions
		genHealthService filterOptions
			.done (response) ->
		        # We can dispatch many times!
		        # Here, we update the app state with the results of the API call.
				data = genHealthDataParser response.obs
				dispatch receiveGenHealthData data
				return
			.fail (jqxhr, textStatus, error) ->
				# Handle errors..
				dispatch errorReceivingeGenHealthData textStatus + " : " + error
				return

module.exports = {

	REQUEST_GEN_HEALTH_DATA
	RECEIVE_GEN_HEALTH_DATA
	TOGGLE_CATEGORY
	MOUSE_OVER
	HIGHLIGHT_LINE
	UNHIGHLIGHT_LINE
	TOGGLE_VALUE
	ERROR_RECEIVE_GEN_HEALTH_DATA
	FILTER_USED
	CONTROLS_OPENED
	CONTROLS_CLOSED
	DISTRICT_SEARCH
	INIT_GEN_HEALTH
	INIT_GEN_HEALTH_OFF
	INIT_DONE
	TOGGLE_SEX
	toggleSex
	initDone
	initGenHealth
	initGenHealthOff
	mouseOver
	highlightLine
	unHighlightLine
	fetchGenHealthData
	districtSearch
	requestGenHealthData
	receiveGenHealthData
	toggleCategory
	toggleValue
	errorReceivingeGenHealthData
	filterUsed
	controlsOpened
	controlsClosed

}
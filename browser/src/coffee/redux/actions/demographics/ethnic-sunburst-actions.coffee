sunBurstService = require '../../../services/nomis/demographics/ethnic-sunburst-service.js'
sunburstDataParser = require '../../../services/nomis/demographics/ethnic-sunburst-parser.js'

REQUEST_ETHNIC_DATA = "REQUEST_ETHNIC_DATA"
RECEIVE_ETHNIC_DATA = "RECEIVE_ETHNIC_DATA"
TOGGLE_CATEGORY = "S_TOGGLE_CATEGORY"
MOUSE_OVER = "S_MOUSE_OVER"
TOGGLE_VALUE = "S_TOGGLE_VALUE"
ERROR_RECEIVE_ETHNIC_DATA = "ERROR_RECEIVE_ETHNIC_DATA"
FILTER_USED = "S_FILTER_USED"
CONTROLS_OPENED = "S_CONTROLS_OPENED"
CONTROLS_CLOSED = "S_CONTROLS_CLOSED"
DISTRICT_SEARCH = "S_DISTRICT_SEARCH"
INIT_SUNBURST = "INIT_SUNBURST"
INIT_SUNBURST_OFF = "INIT_SUNBURST_OFF"
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

initSunburst = () ->
	{
		type: INIT_SUNBURST
	}

initSunburstOff = () ->
	{
		type: INIT_SUNBURST_OFF
	}

initDone = () ->
	{
		type: INIT_DONE
	}

requestEthnicData = (filterOptions) ->
	{
		type: REQUEST_ETHNIC_DATA
		filterOptions
	}

filterUsed = () ->
	{
		type: FILTER_USED
	}

receiveEthnicData = (data) ->
	{
		type: RECEIVE_ETHNIC_DATA
		data: data
		receivedAt: Date.now()
	}

errorReceivingeEthnicData = (error) ->
	{
		type: ERROR_RECEIVE_ETHNIC_DATA
		error: error
	}


# Meet our first thunk action creator!
# Though its insides are different, you would use it just like any other action creator:
# store.dispatch(fetchPosts('reactjs'))

fetchSunburstData = (filterOptions) ->

	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
 	# thus making it able to dispatch actions itself.
	(dispatch) ->

		dispatch filterUsed() if filterOptions?
		dispatch requestEthnicData filterOptions
		sunBurstService(filterOptions)
			.done (response) ->
		        # We can dispatch many times!
		        # Here, we update the app state with the results of the API call.
				data = sunburstDataParser response.obs
				# window.sunburst_data = data
				dispatch receiveEthnicData data
				return
			.fail (jqxhr, textStatus, error) ->
				# Handle errors..
				dispatch errorReceivingeEthnicData textStatus + " : " + error
				# console.log textStatus + " - " + error
				return

module.exports = {

	REQUEST_ETHNIC_DATA
	RECEIVE_ETHNIC_DATA
	TOGGLE_CATEGORY
	MOUSE_OVER
	TOGGLE_VALUE
	ERROR_RECEIVE_ETHNIC_DATA
	FILTER_USED
	CONTROLS_OPENED
	CONTROLS_CLOSED
	DISTRICT_SEARCH
	INIT_SUNBURST
	INIT_SUNBURST_OFF
	INIT_DONE
	initDone
	initSunburst
	initSunburstOff
	mouseOver
	fetchSunburstData
	districtSearch
	requestEthnicData
	receiveEthnicData
	toggleCategory
	toggleValue
	errorReceivingeEthnicData
	filterUsed
	controlsOpened
	controlsClosed

}
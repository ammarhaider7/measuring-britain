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

toggleValue = (value, selectionOption) ->
	{
		type: TOGGLE_VALUE
		value
		selectionOption
	}

toggleCategory = (category, selectionOption) ->
	{
		type: TOGGLE_CATEGORY
		category
		selectionOption
	}

controlsOpened = () ->
	{
		type: CONTROLS_OPENED
		isControlsOpen: yes
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
		barsError: error
	}


# Meet our first thunk action creator!
# Though its insides are different, you would use it just like any other action creator:
# store.dispatch(fetchPosts('reactjs'))

fetchSunburstData = (filterOptions) ->

	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
 	# thus making it able to dispatch actions itself.
# 	(dispatch) ->

		# pyramidService(barOptions)
		# 	.done (response) ->
		#         # We can dispatch many times!
		#         # Here, we update the app state with the results of the API call.
		# 		data = pyramidDataParser response.obs
		# 		# console.log data
		# 		dispatch receivePyramidDataBars data
		# 		return
		# 	.fail (jqxhr, textStatus, error) ->
		# 		# Handle errors..
		# 		dispatch errorReceivingPyramidDataBars textStatus + " : " + error
		# 		# console.log textStatus + " - " + error
		# 		return

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
	requestEthnicData
	receiveEthnicData
	toggleCategory
	toggleValue
	errorReceivingeEthnicData
	filterUsed
	controlsOpened
	controlsClosed

}
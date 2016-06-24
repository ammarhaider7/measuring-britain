pyramidService = require '../../../services/nomis/demographics/pyramid-service.js'
pyramidDataParser = require '../../../services/nomis/demographics/pyramid-parser.js'

REQUEST_PYRAMID_DATA = "REQUEST_PYRAMID_DATA"
RECEIVE_PYRAMID_DATA_BARS = "RECEIVE_PYRAMID_DATA_BARS"
RECEIVE_PYRAMID_DATA_OUTLINE = "RECEIVE_PYRAMID_DATA_OUTLINE"
TOGGLE_CATEGORY = "TOGGLE_CATEGORY"
MOUSE_OVER = "MOUSE_OVER"
ADD_FILTER = "ADD_FILTER"
REMOVE_FILTER = "REMOVE_FILTER"
TOGGLE_OUTLINE_CATEGORY = "TOGGLE_OUTLINE_CATEGORY"
TOGGLE_OUTLINE_VALUE = "TOGGLE_OUTLINE_VALUE"
TOGGLE_VALUE = "TOGGLE_VALUE"
ERROR_RECEIVE_PYRAMID_DATA_BARS = "ERROR_RECEIVE_PYRAMID_DATA_BARS"
ERROR_RECEIVE_PYRAMID_DATA_OUTLINE = "ERROR_RECEIVE_PYRAMID_DATA_OUTLINE"
FILTER_USED = "FILTER_USED"
CONTROLS_OPENED = "P_CONTROLS_OPENED"
CONTROLS_CLOSED = "P_CONTROLS_CLOSED"
DISTRICT_SEARCH = "P_DISTRICT_SEARCH"
TOGGLE_FILTERING_OPTION = "TOGGLE_FILTERING_OPTION"
FIRST_LINE_DRAWN = "FIRST_LINE_DRAWN"

toggleValue = (value) ->
	{
		type: TOGGLE_VALUE
		value
	}

controlsClosed = () ->
	{
		type: CONTROLS_CLOSED
		isControlsOpen: no
	}

controlsOpened = () ->
	{
		type: CONTROLS_OPENED
		isControlsOpen: yes
	}

toggleFilteringOption = (option) ->
	{
		type: TOGGLE_FILTERING_OPTION
		filteringOption: option
	}

districtSearch = (query) ->
	{
		type: DISTRICT_SEARCH
		query: query
	}

toggleOutlineCategory = (category) ->
	{
		type: TOGGLE_OUTLINE_CATEGORY
		category
	}

toggleOutlineValue = (value) ->
	{
		type: TOGGLE_OUTLINE_VALUE
		value
	}	

addFilter = () ->
	{
		type: ADD_FILTER
	}

removeFilter = () ->
	{
		type: REMOVE_FILTER
	}

toggleCategory = (category) ->
	{
		type: TOGGLE_CATEGORY
		category
	}
	
mouseOver = (mouseOverData) ->
	{
		type: MOUSE_OVER
		mouseOverData: mouseOverData 
	}

firstLineDrawn = () ->
	{
		type: FIRST_LINE_DRAWN
	}

requestPyramidData = (filterOptions) ->
	{
		type: REQUEST_PYRAMID_DATA
		filterOptions
	}

filterUsed = () ->
	{
		type: FILTER_USED
	}

receivePyramidDataBars = (data) ->
	{
		type: RECEIVE_PYRAMID_DATA_BARS
		data: data
		receivedAt: Date.now()
	}

receivePyramidDataOutline = (data) ->
	{
		type: RECEIVE_PYRAMID_DATA_OUTLINE
		data: data
		receivedAt: Date.now()
	}
errorReceivingPyramidDataBars = (error) ->
	{
		type: ERROR_RECEIVE_PYRAMID_DATA_BARS
		barsError: error
	}

errorReceivingPyramidDataOutline = (error) ->
	{
		type: ERROR_RECEIVE_PYRAMID_DATA_OUTLINE
		outlineError: error
	}

# Meet our first thunk action creator!
# Though its insides are different, you would use it just like any other action creator:
# store.dispatch(fetchPosts('reactjs'))

fetchPyramidData = (filterOptions) ->
	# console.log 'fetchPyramidData'
	# console.log filterOptions
	shouldFetchOutline = if filterOptions? then filterOptions.outlineRequested else no
	barOptions = if filterOptions? then filterOptions.bars else null
	outlineOptions = if filterOptions? then filterOptions.outline else null
	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
	# thus making it able to dispatch actions itself.
	(dispatch) ->

		dispatch filterUsed() if filterOptions?
		dispatch requestPyramidData barOptions
		# The function called by the thunk middleware can return a value,
		# that is passed on as the return value of the dispatch method.
		# In this case, we return a promise to wait for.
		# This is not required by thunk middleware, but it is convenient for us.
		if shouldFetchOutline is no

			pyramidService(barOptions)
				.done (response) ->
			        # We can dispatch many times!
			        # Here, we update the app state with the results of the API call.
					data = pyramidDataParser response.obs
					# console.log data
					dispatch receivePyramidDataBars data
					return
				.fail (jqxhr, textStatus, error) ->
					# Handle errors..
					dispatch errorReceivingPyramidDataBars textStatus + " : " + error
					# console.log textStatus + " - " + error
					return

		else if shouldFetchOutline is yes

			pyramidService(barOptions)
				.done (response) ->
					data = pyramidDataParser response.obs
					# console.log data
					dispatch receivePyramidDataBars data
					return
				.fail (jqxhr, textStatus, error) ->
					# Handle errors..
					dispatch errorReceivingPyramidDataBars textStatus + " : " + error
					# console.log textStatus + " - " + error
					return

			pyramidService(outlineOptions)
				.done (response) ->
					data = pyramidDataParser response.obs
					# console.log data
					dispatch receivePyramidDataOutline data
					return
				.fail (jqxhr, textStatus, error) ->
					# Handle errors..
					dispatch errorReceivingPyramidDataOutline textStatus + " : " + error
					# console.log textStatus + " - " + error
					return


module.exports = {

	RECEIVE_PYRAMID_DATA_BARS
	RECEIVE_PYRAMID_DATA_OUTLINE
	ERROR_RECEIVE_PYRAMID_DATA_OUTLINE
	ERROR_RECEIVE_PYRAMID_DATA_BARS
	REQUEST_PYRAMID_DATA
	TOGGLE_CATEGORY
	MOUSE_OVER
	ADD_FILTER
	REMOVE_FILTER
	TOGGLE_OUTLINE_CATEGORY
	TOGGLE_OUTLINE_VALUE
	TOGGLE_VALUE
	FILTER_USED
	CONTROLS_OPENED
	CONTROLS_CLOSED
	DISTRICT_SEARCH
	TOGGLE_FILTERING_OPTION
	FIRST_LINE_DRAWN
	firstLineDrawn
	toggleFilteringOption
	controlsOpened
	controlsClosed
	districtSearch
	filterUsed
	receivePyramidDataBars
	receivePyramidDataOutline
	requestPyramidData
	fetchPyramidData
	toggleCategory
	mouseOver
	addFilter
	removeFilter
	toggleOutlineCategory
	toggleValue
	toggleOutlineValue
	errorReceivingPyramidDataOutline
	errorReceivingPyramidDataBars
	
}
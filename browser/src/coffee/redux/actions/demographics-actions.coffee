pyramidService = require '../../services/nomis/pyramid-service.js'

REQUEST_PYRAMID_DATA = "REQUEST_PYRAMID_DATA"
RECEIVE_PYRAMID_DATA = "RECEIVE_PYRAMID_DATA"
TOGGLE_CATEGORY = "TOGGLE_CATEGORY"
MOUSE_OVER = "MOUSE_OVER"
ADD_FILTER = "ADD_FILTER"
REMOVE_FILTER = "REMOVE_FILTER"
TOGGLE_OUTLINE_CATEGORY = "TOGGLE_OUTLINE_CATEGORY"
TOGGLE_VALUE = "TOGGLE_VALUE"


toggleValue = (value) ->
	{
		type: TOGGLE_VALUE
		value
	}

toggleOutlineCategory = (category) ->
	{
		type: TOGGLE_OUTLINE_CATEGORY
		category
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
# mouseOver options should take the form of:-
# {
# 	chart= [chart],
# 	segment= [segment]
# }
mouseOver = (mouseOverOptions) ->
	{
		type: MOUSE_OVER
		mouseOverOptions
	}


requestPyramidData = (filterOptions) ->
	{
		type: REQUEST_PYRAMID_DATA
		filterOptions
	}

receivePyramidData = (data) ->
	{
		type: RECEIVE_PYRAMID_DATA
		data: data
		receivedAt: Date.now()
	}

# Meet our first thunk action creator!
# Though its insides are different, you would use it just like any other action creator:
# store.dispatch(fetchPosts('reactjs'))

fetchPyramidData = (filterOptions) ->
	# Thunk middleware knows how to handle functions.
	# It passes the dispatch method as an argument to the function,
	# thus making it able to dispatch actions itself.
	(dispatch) ->
		dispatch requestPyramidData filterOptions
		# The function called by the thunk middleware can return a value,
		# that is passed on as the return value of the dispatch method.
		# In this case, we return a promise to wait for.
		# This is not required by thunk middleware, but it is convenient for us.
		pyramidService(filterOptions)
			.done (response) ->
		        # We can dispatch many times!
		        # Here, we update the app state with the results of the API call.
				dispatch receivePyramidData response.obs
				return
			.fail (jqxhr, textStatus, error) ->
				# Handle errors..
				console.log textStatus + " - " + error
				return


module.exports = {
	RECEIVE_PYRAMID_DATA
	REQUEST_PYRAMID_DATA
	TOGGLE_CATEGORY
	MOUSE_OVER
	ADD_FILTER
	REMOVE_FILTER
	TOGGLE_OUTLINE_CATEGORY
	TOGGLE_VALUE
	receivePyramidData
	requestPyramidData
	fetchPyramidData
	toggleCategory
	mouseOver
	addFilter
	removeFilter
	toggleOutlineCategory
	toggleValue
}
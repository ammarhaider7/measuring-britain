{ combineReducers } = require 'redux'

objectAssign = require 'object-assign'

{ TOGGLE_CATEGORY, MOUSE_OVER } = require '../actions/actions.js'

pyramidChart = require './demographics-reducers.js'

mouseOverOptions = (state = {}, action) ->
	switch action.type
		when MOUSE_OVER then objectAssign {}, state, {
			options: action.mouseOverOptions
		}
		else state

mbReducer = combineReducers {
	mouseOverOptions
	pyramidChart
}

module.exports = mbReducer
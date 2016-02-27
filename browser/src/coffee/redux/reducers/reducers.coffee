{ combineReducers } = require 'redux'

objectAssign = require 'object-assign'

{ TOGGLE_FILTER, TOGGLE_CATEGORY, MOUSE_OVER } = require '../actions/actions.js'

initialOptions = {
	options: {
		category: 'default'
		value: 'default'
	}
}

filterOptions = (state = initialOptions, action) ->
	switch action.type
		when TOGGLE_FILTER then objectAssign {}, state, {
			options: action.filterOptions
		}
		else state

mouseOverOptions = (state = {}, action) ->
	switch action.type
		when MOUSE_OVER then objectAssign {}, state, {
			options: action.mouseOverOptions
		}
		else state

category = (state = 'default', action) ->
	switch action.type
		when TOGGLE_CATEGORY then action.category
		else state

mbReducer = combineReducers {
	filterOptions
	mouseOverOptions
	category
}

module.exports = mbReducer
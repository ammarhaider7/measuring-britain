objectAssign = require 'object-assign'

{ RECEIVE_PYRAMID_DATA, REQUEST_PYRAMID_DATA, TOGGLE_CATEGORY, TOGGLE_VALUE, MOUSE_OVER, ADD_FILTER, REMOVE_FILTER, TOGGLE_OUTLINE_CATEGORY } = require '../actions/demographics-actions.js'

pyramid = {
	chartName: 'pyramid'
	isFetching: false
	category: 'default'
	value: 'default'
	data: []
	outlineFilter: false
	outlineCategory: 'default'
}

pyramidChart = (state = pyramid, action) ->
	switch action.type
		when TOGGLE_CATEGORY then objectAssign {}, state, {
			category: action.category
		}
		when TOGGLE_VALUE then objectAssign {}, state, {
			value: action.value
		}
		when REQUEST_PYRAMID_DATA then objectAssign {}, state, {
			isFetching: true
		}
		when RECEIVE_PYRAMID_DATA then objectAssign {}, state, {
			isFetching: false
			data: action.data
			lastUpdated: action.receivedAt
		}
		when MOUSE_OVER then objectAssign {}, state, {
			mouseOptions: action.mouseOverOptions
		}
		when ADD_FILTER then objectAssign {}, state, {
			outlineFilter: true
		}
		when REMOVE_FILTER then objectAssign {}, state, {
			outlineFilter: false
		}
		when TOGGLE_OUTLINE_CATEGORY then objectAssign {}, state, {
			outlineCategory: action.category
		}
		else state

module.exports = pyramidChart
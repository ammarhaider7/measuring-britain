objectAssign = require 'object-assign'

{ RECEIVE_PYRAMID_DATA, REQUEST_PYRAMID_DATA } = require '../actions/demographics-actions.js'
{ TOGGLE_CATEGORY, MOUSE_OVER } = require '../actions/actions.js'

pyramid = {
	isFetching: false
	category: 'default'
	value: 'default'
	data: []
}

pyramidChart = (state = pyramid, action) ->
	switch action.type
		when TOGGLE_CATEGORY then objectAssign {}, state, {
			category: action.category
		}
		when REQUEST_PYRAMID_DATA then objectAssign {}, state, {
			isFetching: true
		}
		when RECEIVE_PYRAMID_DATA then objectAssign {}, state, {
			isFetching: false
			data: action.data
			lastUpdated: action.receivedAt
		}
		else state

module.exports = pyramidChart
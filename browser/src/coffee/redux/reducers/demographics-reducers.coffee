objectAssign = require 'object-assign'

{ RECEIVE_PYRAMID_DATA, REQUEST_PYRAMID_DATA, TOGGLE_CATEGORY, TOGGLE_VALUE, MOUSE_OVER, ADD_FILTER, REMOVE_FILTER, TOGGLE_OUTLINE_CATEGORY, TOGGLE_OUTLINE_VALUE } = require '../actions/demographics-actions.js'

pyramid = {
	chartName: 'pyramid'
	isFetching: false
	_barsCategory: {
		value: 'default'
		label: 'default'
	}
	barsCategory: 'default'
	barsValue: 'default'
	_barsValue: {
		value: 'default'
		label: 'default'		
	}
	data: []
	outlineFilter: false
	_outlineCategory: {
		value: 'default'
		label: 'default'
	}
	outlineCategory: 'default'
	_outlineValue: {
		value: 'default'
		label: 'default'		
	}
	outlineValue: 'default'
}

pyramidChart = (state = pyramid, action) ->
	switch action.type
		when TOGGLE_CATEGORY then objectAssign {}, state, {
			barsCategory: action.category
			_barsCategory: action.selectionOption
		}
		when TOGGLE_VALUE then objectAssign {}, state, {
			barsValue: action.value
			_barsValue: action.selectionOption
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
			_outlineCategory: action.selectionOption
		}
		when TOGGLE_OUTLINE_VALUE then objectAssign {}, state, {
			outlineValue: action.value
			_outlineValue: action.selectionOption
		}
		else state

module.exports = pyramidChart
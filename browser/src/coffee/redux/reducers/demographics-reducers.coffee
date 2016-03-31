objectAssign = require 'object-assign'

{ RECEIVE_PYRAMID_DATA_BARS, ERROR_RECEIVE_PYRAMID_DATA_BARS, ERROR_RECEIVE_PYRAMID_DATA_OUTLINE, RECEIVE_PYRAMID_DATA_OUTLINE, REQUEST_PYRAMID_DATA, TOGGLE_CATEGORY, TOGGLE_VALUE, MOUSE_OVER, ADD_FILTER, REMOVE_FILTER, TOGGLE_OUTLINE_CATEGORY, TOGGLE_OUTLINE_VALUE } = require '../actions/demographics-actions.js'

pyramid = {
	chartName: 'pyramid'
	isFetching: no
	_barsCategory:
		value: 'default'
		label: 'default'
	_barsValue:
		value: 'default'
		label: 'default'		
	data:
		bars: {}
		outline: {}
	outlineFilter: no
	_outlineCategory:
		value: 'default'
		label: 'default'
	_outlineValue:
		value: 'default'
		label: 'default'		
	error: no
}

pyramidChart = (state = pyramid, action) ->
	switch action.type
		when TOGGLE_CATEGORY then objectAssign {}, state, {
			_barsCategory: action.selectionOption
		}
		when TOGGLE_VALUE then objectAssign {}, state, {
			_barsValue: action.selectionOption
		}
		when REQUEST_PYRAMID_DATA then objectAssign {}, state, {
			isFetching: yes
		}
		when RECEIVE_PYRAMID_DATA_BARS then objectAssign {}, state, {
			isFetching: no
			data:
				bars: action.data
				outline: state.data.outline
			lastUpdated: action.receivedAt
		}
		when RECEIVE_PYRAMID_DATA_OUTLINE then objectAssign {}, state, {
			isFetching: no
			data:
				outline: action.data
				bars: state.data.bars
			lastUpdated: action.receivedAt
		}
		when ERROR_RECEIVE_PYRAMID_DATA_BARS then objectAssign {}, state, {
			isFetching: no
			error: yes
			errorMessage: action.barsError
		}
		when ERROR_RECEIVE_PYRAMID_DATA_OUTLINE then objectAssign {}, state, {
			isFetching: no
			error: yes
			errorMessage: action.outlineError
		}		
		when MOUSE_OVER then objectAssign {}, state, {
			mouseOptions: action.mouseOverOptions
		}
		when ADD_FILTER then objectAssign {}, state, {
			outlineFilter: yes
		}
		when REMOVE_FILTER then objectAssign {}, state, {
			outlineFilter: no
		}
		when TOGGLE_OUTLINE_CATEGORY then objectAssign {}, state, {
			_outlineCategory: action.selectionOption
		}
		when TOGGLE_OUTLINE_VALUE then objectAssign {}, state, {
			_outlineValue: action.selectionOption
		}
		else state

module.exports = pyramidChart
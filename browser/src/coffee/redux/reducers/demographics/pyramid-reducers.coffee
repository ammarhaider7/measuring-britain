objectAssign = require 'object-assign'

{ FILTER_USED
  RECEIVE_PYRAMID_DATA_BARS
  ERROR_RECEIVE_PYRAMID_DATA_BARS
  ERROR_RECEIVE_PYRAMID_DATA_OUTLINE
  RECEIVE_PYRAMID_DATA_OUTLINE
  REQUEST_PYRAMID_DATA
  TOGGLE_CATEGORY
  TOGGLE_VALUE
  MOUSE_OVER
  CONTROLS_OPENED
  CONTROLS_CLOSED
  DISTRICT_SEARCH
  ADD_FILTER
  REMOVE_FILTER
  TOGGLE_OUTLINE_CATEGORY
  TOGGLE_OUTLINE_VALUE } = require '../../actions/demographics/pyramid-actions.js'

pyramidInitialState = {
	chartName: 'pyramid'
	isFetching: no
	isDefault: yes
	isControlsOpen: no
	_barsCategory:
	    value: 'countries'
	    label: 'Geography (Countries)'
	_barsValue:
	    value: 'K04000001'
	    label: 'England \& Wales'
	activeBarsCategory: 'Geography (Countries)'
	activeBarsValue: 'England \& Wales'
	data:
		bars: {}
		outline: {}
	_mouseOverData: {}
	outlineFilter: no
	_outlineCategory:
		value: 'default'
		label: 'default'
	_outlineValue:
		value: 'default'
		label: 'default'		
	error: no
	updateBars: no
	updatePyramid: no
	updateOutline: no
}

pyramidChart = (state = pyramidInitialState, action) ->
	switch action.type
		when TOGGLE_CATEGORY then objectAssign {}, state, {
			_barsCategory: action.selectionOption
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when TOGGLE_VALUE then objectAssign {}, state, {
			_barsValue: action.selectionOption
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when FILTER_USED then objectAssign {}, state, {
			isDefault: no
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when REQUEST_PYRAMID_DATA then objectAssign {}, state, {
			isFetching: yes
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when RECEIVE_PYRAMID_DATA_BARS then objectAssign {}, state, {
			isFetching: no
			data:
				bars: action.data
				outline: state.data.outline
			lastUpdated: action.receivedAt
			updatePyramid: yes
			updateBars: yes
			updateOutline: no
			activeBarsValue: state._barsValue.label
			activeBarsCategory: state._barsCategory.label
		}
		when RECEIVE_PYRAMID_DATA_OUTLINE then objectAssign {}, state, {
			isFetching: no
			data:
				outline: action.data
				bars: state.data.bars
			lastUpdated: action.receivedAt
			updateOutline: yes
		}
		when ERROR_RECEIVE_PYRAMID_DATA_BARS then objectAssign {}, state, {
			isFetching: no
			error: yes
			errorMessage: action.barsError
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when ERROR_RECEIVE_PYRAMID_DATA_OUTLINE then objectAssign {}, state, {
			isFetching: no
			error: yes
			errorMessage: action.outlineError
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}		
		when MOUSE_OVER then objectAssign {}, state, {
			_mouseOverData: action.mouseOverData
			updateBars: yes
			updateOutline: no
		}
		when ADD_FILTER then objectAssign {}, state, {
			outlineFilter: yes
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when REMOVE_FILTER then objectAssign {}, state, {
			outlineFilter: no
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when TOGGLE_OUTLINE_CATEGORY then objectAssign {}, state, {
			_outlineCategory: action.selectionOption
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		when TOGGLE_OUTLINE_VALUE then objectAssign {}, state, {
			_outlineValue: action.selectionOption
			updatePyramid: no
			updateBars: no
			updateOutline: no
		}
		else state

module.exports = pyramidChart
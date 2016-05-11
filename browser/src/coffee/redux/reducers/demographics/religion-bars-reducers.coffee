objectAssign = require 'object-assign'

{ REQUEST_RELIGION_DATA
  RECEIVE_RELIGION_DATA
  TOGGLE_CATEGORY
  MOUSE_OVER
  TOGGLE_VALUE
  ERROR_RECEIVE_RELIGION_DATA
  FILTER_USED
  CONTROLS_OPENED
  CONTROLS_CLOSED
  DISTRICT_SEARCH
  INIT_BARS
  INIT_BARS_OFF
  INIT_DONE } = require '../../actions/demographics/religion-bars-actions.js'

barsInitialState = {
  chartName: 'relBars'
  isFetching: no
  isDefault: yes
  isControlsOpen: no
  _category:
    value: 'countries'
    label: 'Geography (Countries)'
  _value:
    value: 'K04000001'
    label: 'England \& Wales'
  activeCategory: 'Geography (Countries)'
  activeValue: 'England \& Wales'
  data: {}
  error: no
  updateTable: no
  updateRelBars: no
  district_query: 'default'
  _mouseOverData: {}
  init_bars: no
  init_done: no
}

barChart = (state = barsInitialState, action) ->

  switch action.type

    when TOGGLE_CATEGORY then objectAssign {}, state, {
      _category: action.category
      updateRelBars: no
      init_bars: no
    }
    when TOGGLE_VALUE then objectAssign {}, state, {
      _value: action.value
      updateRelBars: no
      init_bars: no
    }
    when CONTROLS_OPENED then objectAssign {}, state, {
      isControlsOpen: yes
      updateRelBars: no
      init_bars: no
    }
    when CONTROLS_CLOSED then objectAssign {}, state, {
      isControlsOpen: no
      updateRelBars: no
      init_bars: no
    }
    when DISTRICT_SEARCH then objectAssign {}, state, {
      district_query: action.query
      updateRelBars: no
      init_bars: no
    }
    when FILTER_USED then objectAssign {}, state, {
      isDefault: no
      updateRelBars: no
      init_bars: no
    }
    when INIT_BARS then objectAssign {}, state, {
      init_bars: yes
    }
    when INIT_BARS_OFF then objectAssign {}, state, {
      init_bars: no
    }
    when INIT_DONE then objectAssign {}, state, {
      init_done: yes
      updateRelBars: no
    }
    when REQUEST_RELIGION_DATA then objectAssign {}, state, {
      isFetching: yes
      updateRelBars: no
      init_bars: no
    }
    when RECEIVE_RELIGION_DATA then objectAssign {}, state, {
      isFetching: no
      data: action.data
      activeCategory: state._category.label
      activeValue: state._value.label
      updateRelBars: yes
      init_bars: no
    }
    when ERROR_RECEIVE_RELIGION_DATA then objectAssign {}, state, {
      isFetching: no
      error: yes
      errorMessage: action.error
      init_bars: no
    }  
    when MOUSE_OVER then objectAssign {}, state, {
      updateRelBars: no
      _mouseOverData: action.mouseOverData
      init_bars: no
    }
    else state

module.exports = barChart


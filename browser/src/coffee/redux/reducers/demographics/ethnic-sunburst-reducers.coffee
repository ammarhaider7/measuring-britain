objectAssign = require 'object-assign'

{ REQUEST_ETHNIC_DATA
  RECEIVE_ETHNIC_DATA
  TOGGLE_CATEGORY
  MOUSE_OVER
  TOGGLE_VALUE
  ERROR_RECEIVE_ETHNIC_DATA
  FILTER_USED
  CONTROLS_OPENED
  CONTROLS_CLOSED
  DISTRICT_SEARCH } = require '../../actions/demographics/ethnic-sunburst-actions.js'

sunburstInitialState = {
  chartName: 'sunburst'
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
  _mouseOverData: {}  
  error: no
  updateTable: no
  updateSunburst: no
  district_query: 'default'
}

sunburstChart = (state = sunburstInitialState, action) ->
  switch action.type
    when TOGGLE_CATEGORY then objectAssign {}, state, {
      _category: action.category
    }
    when TOGGLE_VALUE then objectAssign {}, state, {
      _value: action.value
    }
    when CONTROLS_OPENED then objectAssign {}, state, {
      isControlsOpen: yes
    }
    when CONTROLS_CLOSED then objectAssign {}, state, {
      isControlsOpen: no
    }
    when DISTRICT_SEARCH then objectAssign {}, state, {
      district_query: action.query
    }
    when FILTER_USED then objectAssign {}, state, {
      # isDefault: no
      # updatePyramid: no
      # updateBars: no
      # updateOutline: no
    }
    when REQUEST_ETHNIC_DATA then objectAssign {}, state, {
      isFetching: yes
    }
    when RECEIVE_ETHNIC_DATA then objectAssign {}, state, {
      isFetching: no
      # data: action.data
      # lastUpdated: action.receivedAt
      activeCategory: state._category.label
      activeValue: state._value.label
    }
    when ERROR_RECEIVE_ETHNIC_DATA then objectAssign {}, state, {
      # isFetching: no
      # error: yes
      # errorMessage: action.barsError
      # updatePyramid: no
      # updateBars: no
      # updateOutline: no
    }  
    when MOUSE_OVER then objectAssign {}, state, {
      # _mouseOverData: action.mouseOverData
      # updateBars: yes
      # updateOutline: no
    }
    else state

module.exports = sunburstChart


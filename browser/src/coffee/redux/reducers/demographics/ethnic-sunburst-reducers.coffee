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
  DISTRICT_SEARCH
  INIT_SUNBURST
  INIT_SUNBURST_OFF
  INIT_DONE } = require '../../actions/demographics/ethnic-sunburst-actions.js'

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
  error: no
  updateTable: no
  updateSunburst: no
  district_query: 'default'
  _mouseOverData: {}
  init_sunburst: no
  init_done: no
}

sunburstChart = (state = sunburstInitialState, action) ->

  switch action.type

    when TOGGLE_CATEGORY then objectAssign {}, state, {
      _category: action.category
      updateSunburst: no
      init_sunburst: no
    }
    when TOGGLE_VALUE then objectAssign {}, state, {
      _value: action.value
      updateSunburst: no
      init_sunburst: no
    }
    when CONTROLS_OPENED then objectAssign {}, state, {
      isControlsOpen: yes
      updateSunburst: no
      init_sunburst: no
    }
    when CONTROLS_CLOSED then objectAssign {}, state, {
      isControlsOpen: no
      updateSunburst: no
      init_sunburst: no
    }
    when DISTRICT_SEARCH then objectAssign {}, state, {
      district_query: action.query
      updateSunburst: no
      init_sunburst: no
    }
    when FILTER_USED then objectAssign {}, state, {
      isDefault: no
      updateSunburst: no
      init_sunburst: no
    }
    when INIT_SUNBURST then objectAssign {}, state, {
      init_sunburst: yes
    }
    when INIT_SUNBURST_OFF then objectAssign {}, state, {
      init_sunburst: no
    }
    when INIT_DONE then objectAssign {}, state, {
      init_done: yes
      updateSunburst: no
    }
    when REQUEST_ETHNIC_DATA then objectAssign {}, state, {
      isFetching: yes
      updateSunburst: no
      init_sunburst: no
    }
    when RECEIVE_ETHNIC_DATA then objectAssign {}, state, {
      isFetching: no
      data: action.data
      activeCategory: state._category.label
      activeValue: state._value.label
      updateSunburst: yes
      init_sunburst: no
    }
    when ERROR_RECEIVE_ETHNIC_DATA then objectAssign {}, state, {
      isFetching: no
      error: yes
      errorMessage: action.error
      init_sunburst: no
    }  
    when MOUSE_OVER then objectAssign {}, state, {
      updateSunburst: no
      _mouseOverData: action.mouseOverData
      init_sunburst: no
    }
    else state

module.exports = sunburstChart


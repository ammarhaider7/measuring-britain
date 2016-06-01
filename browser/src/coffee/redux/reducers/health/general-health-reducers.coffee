objectAssign = require 'object-assign'

{ REQUEST_GEN_HEALTH_DATA
  RECEIVE_GEN_HEALTH_DATA
  TOGGLE_CATEGORY
  MOUSE_OVER
  TOGGLE_VALUE
  ERROR_RECEIVE_GEN_HEALTH_DATA
  FILTER_USED
  CONTROLS_OPENED
  CONTROLS_CLOSED
  DISTRICT_SEARCH
  INIT_GEN_HEALTH
  INIT_GEN_HEALTH_OFF
  INIT_DONE } = require '../../actions/health/general-health-actions.js'

genHealthInitState = {
  chartName: 'genHealthChart'
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
  updateGenHealth: no
  district_query: 'default'
  _mouseOverData: {}
  init_gen_health: no
  init_done: no
}

GenHealthChart = (state = genHealthInitState, action) ->

  switch action.type

    when TOGGLE_CATEGORY then objectAssign {}, state, {
      _category: action.category
      updateGenHealth: no
      init_gen_health: no
    }
    when TOGGLE_VALUE then objectAssign {}, state, {
      _value: action.value
      updateGenHealth: no
      init_gen_health: no
    }
    when CONTROLS_OPENED then objectAssign {}, state, {
      isControlsOpen: yes
      updateGenHealth: no
      init_gen_health: no
    }
    when CONTROLS_CLOSED then objectAssign {}, state, {
      isControlsOpen: no
      updateGenHealth: no
      init_gen_health: no
    }
    when DISTRICT_SEARCH then objectAssign {}, state, {
      district_query: action.query
      updateGenHealth: no
      init_gen_health: no
    }
    when FILTER_USED then objectAssign {}, state, {
      isDefault: no
      updateGenHealth: no
      init_gen_health: no
    }
    when INIT_GEN_HEALTH then objectAssign {}, state, {
      init_gen_health: yes
    }
    when INIT_GEN_HEALTH_OFF then objectAssign {}, state, {
      init_gen_health: no
    }
    when INIT_DONE then objectAssign {}, state, {
      init_done: yes
      updateGenHealth: no
    }
    when REQUEST_GEN_HEALTH_DATA then objectAssign {}, state, {
      isFetching: yes
      updateGenHealth: no
      init_gen_health: no
    }
    when RECEIVE_GEN_HEALTH_DATA then objectAssign {}, state, {
      isFetching: no
      data: action.data
      activeCategory: state._category.label
      activeValue: state._value.label
      updateGenHealth: yes
      init_gen_health: no
    }
    when ERROR_RECEIVE_GEN_HEALTH_DATA then objectAssign {}, state, {
      isFetching: no
      error: yes
      errorMessage: action.error
      init_gen_health: no
    }  
    when MOUSE_OVER then objectAssign {}, state, {
      updateGenHealth: no
      _mouseOverData: action.mouseOverData
      init_gen_health: no
    }
    else state

module.exports = GenHealthChart
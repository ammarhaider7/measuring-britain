objectAssign = require 'object-assign'

{ REQUEST_DISABILITY_DATA
  RECEIVE_DISABILITY_DATA
  TOGGLE_CATEGORY
  MOUSE_OVER
  TOGGLE_VALUE
  ERROR_RECEIVE_DISABILITY_DATA
  FILTER_USED
  CONTROLS_OPENED
  CONTROLS_CLOSED
  DISTRICT_SEARCH
  INIT_DISABILITY
  INIT_DISABILITY_OFF
  INIT_DONE
  TOGGLE_SEX } = require '../../actions/health/health-disability-actions.js'

disabilityInitState = {
  chartName: 'disabilityChart'
  isFetching: no
  isDefault: yes
  isControlsOpen: no
  _category:
    value: 'countries'
    label: 'Geography (Countries)'
  _value:
    value: '2092957703'
    label: 'England \& Wales'
  activeCategory: 'Geography (Countries)'
  activeValue: 'England \& Wales'
  data: {}
  error: no
  updateDisability: no
  district_query: 'default'
  _mouseOverData: {}
  init_disability: no
  sex: 'All'
  sex_code: 0
  init_done: no
}

DisabilityChart = (state = disabilityInitState, action) ->

  switch action.type

    when TOGGLE_CATEGORY then objectAssign {}, state, {
      _category: action.category
      updateDisability: no
      
      init_disability: no
    }
    when TOGGLE_VALUE then objectAssign {}, state, {
      _value: action.value
      updateDisability: no
      init_disability: no
      
    }
    when TOGGLE_SEX then objectAssign {}, state, {
      sex: action.sex
      sex_code: action.sex_code
      updateDisability: no
      init_disability: no
      
    }
    when CONTROLS_OPENED then objectAssign {}, state, {
      isControlsOpen: yes
      updateDisability: no
      init_disability: no
      
      
    }
    when CONTROLS_CLOSED then objectAssign {}, state, {
      isControlsOpen: no
      updateDisability: no
      init_disability: no
      
      
    }
    when DISTRICT_SEARCH then objectAssign {}, state, {
      district_query: action.query
      updateDisability: no
      init_disability: no
      
      
    }
    when FILTER_USED then objectAssign {}, state, {
      isDefault: no
      updateDisability: no
      init_disability: no
      
      
    }
    when INIT_DISABILITY then objectAssign {}, state, {
      init_disability: yes
      
      
    }
    when INIT_DISABILITY_OFF then objectAssign {}, state, {
      init_disability: no
      
      
    }
    when INIT_DONE then objectAssign {}, state, {
      init_done: yes
      updateDisability: no
      
      
    }
    when REQUEST_DISABILITY_DATA then objectAssign {}, state, {
      isFetching: yes
      updateDisability: no
      
      init_disability: no
      
    }
    when RECEIVE_DISABILITY_DATA then objectAssign {}, state, {
      isFetching: no
      data: action.data
      activeCategory: state._category.label
      activeValue: state._value.label
      updateDisability: yes
      init_disability: no
      
      
    }
    when ERROR_RECEIVE_DISABILITY_DATA then objectAssign {}, state, {
      isFetching: no
      error: yes
      errorMessage: action.error
      init_disability: no
      
      
    }  
    when MOUSE_OVER then objectAssign {}, state, {
      updateDisability: no
      _mouseOverData: action.mouseOverData
      init_disability: no
      updateTable: yes
      
    }
    else state

module.exports = DisabilityChart
objectAssign = require 'object-assign'

{ REQUEST_ECON_COUNTRY_DATA
  RECEIVE_ECON_COUNTRY_DATA
  TOGGLE_CATEGORY
  MOUSE_OVER
  TOGGLE_VALUE
  ERROR_RECEIVE_ECON_COUNTRY_DATA
  FILTER_USED
  CONTROLS_OPENED
  CONTROLS_CLOSED
  DISTRICT_SEARCH
  INIT_ECON_COUNTRY
  INIT_ECON_COUNTRY_OFF
  INIT_DONE } = require '../../actions/labour/econ-activity-country-actions.js'

econCountryInitState = {
  chartName: 'economicActivityByCountry'
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
  updateTable: no
  updateMainChart: no
  district_query: 'default'
  _mouseOverData: {}
  init_econ_country: no
  init_done: no
}

EconCountryChart = (state = econCountryInitState, action) ->

  switch action.type

    when TOGGLE_CATEGORY then objectAssign {}, state, {
      _category: action.category
      updateMainChart: no
      updateTable: no
      init_econ_country: no
    }
    when TOGGLE_VALUE then objectAssign {}, state, {
      _value: action.value
      updateMainChart: no
      init_econ_country: no
      updateTable: no
    }
    when CONTROLS_OPENED then objectAssign {}, state, {
      isControlsOpen: yes
      updateMainChart: no
      init_econ_country: no
      updateTable: no
    }
    when CONTROLS_CLOSED then objectAssign {}, state, {
      isControlsOpen: no
      updateMainChart: no
      init_econ_country: no
      updateTable: no
      
    }
    when DISTRICT_SEARCH then objectAssign {}, state, {
      district_query: action.query
      updateMainChart: no
      init_econ_country: no
      updateTable: no
      
    }
    when FILTER_USED then objectAssign {}, state, {
      isDefault: no
      updateMainChart: no
      init_econ_country: no
      updateTable: no
      
    }
    when INIT_ECON_COUNTRY then objectAssign {}, state, {
      init_econ_country: yes
      updateTable: no
      
    }
    when INIT_ECON_COUNTRY_OFF then objectAssign {}, state, {
      init_econ_country: no
      updateTable: no
    }
    when INIT_DONE then objectAssign {}, state, {
      init_done: yes
      updateMainChart: no
      updateTable: no
    }
    when REQUEST_ECON_COUNTRY_DATA then objectAssign {}, state, {
      isFetching: yes
      updateMainChart: no
      updateTable: no
      init_econ_country: no
      
    }
    when RECEIVE_ECON_COUNTRY_DATA then objectAssign {}, state, {
      isFetching: no
      data: action.data
      activeCategory: state._category.label
      activeValue: state._value.label
      updateMainChart: yes
      init_econ_country: no
      updateTable: no
      
    }
    when ERROR_RECEIVE_ECON_COUNTRY_DATA then objectAssign {}, state, {
      isFetching: no
      error: yes
      errorMessage: action.error
      init_econ_country: no
      updateTable: no
      
    }  
    when MOUSE_OVER then objectAssign {}, state, {
      updateMainChart: no
      _mouseOverData: action.mouseOverData
      init_econ_country: no
      updateTable: yes
      
    }
    else state

module.exports = EconCountryChart
objectAssign = require 'object-assign'

{ REQUEST_ETHNIC_DATA
  RECEIVE_ETHNIC_DATA
  TOGGLE_CATEGORY
  MOUSE_OVER
  TOGGLE_VALUE
  ERROR_RECEIVE_ETHNIC_DATA
  FILTER_USED
  CONTROLS_OPENED
  CONTROLS_CLOSED } = require '../../actions/demographics/ethnic-sunburst-actions.js'

sunburstInitialState = {
  chartName: 'sunburst'
  isFetching: no
  isDefault: yes
  isControlsOpen: no
  _category:
    value: 'default'
    label: 'default'
  _value:
    value: 'default'
    label: 'default'
  activeCategory: 'default'
  activeValue: 'default'
  data: {}
  _mouseOverData: {}  
  error: no
  updateTable: no
  updateSunburst: no
}

sunburstChart = (state = sunburstInitialState, action) ->
  switch action.type
    when TOGGLE_CATEGORY then objectAssign {}, state, {
      _category: action.category
    }
    when TOGGLE_VALUE then objectAssign {}, state, {
      # _barsValue: action.selectionOption
      # updatePyramid: no
      # updateBars: no
      # updateOutline: no
    }
    when CONTROLS_OPENED then objectAssign {}, state, {
      isControlsOpen: yes
    }
    when CONTROLS_CLOSED then objectAssign {}, state, {
      isControlsOpen: no
    }
    when FILTER_USED then objectAssign {}, state, {
      # isDefault: no
      # updatePyramid: no
      # updateBars: no
      # updateOutline: no
    }
    when REQUEST_ETHNIC_DATA then objectAssign {}, state, {
      # isFetching: yes
      # updatePyramid: no
      # updateBars: no
      # updateOutline: no
    }
    when RECEIVE_ETHNIC_DATA then objectAssign {}, state, {
      # isFetching: no
      # data:
      #   bars: action.data
      #   outline: state.data.outline
      # lastUpdated: action.receivedAt
      # updatePyramid: yes
      # updateBars: yes
      # updateOutline: no
      # activeBarsValue: state._barsValue.label
      # activeBarsCategory: state._barsCategory.label
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


// Generated by CoffeeScript 1.10.0
var CONTROLS_CLOSED, CONTROLS_OPENED, DISTRICT_SEARCH, ERROR_RECEIVE_RELIGION_DATA, FILTER_USED, INIT_BARS, INIT_BARS_OFF, INIT_DONE, MOUSE_OVER, RECEIVE_RELIGION_DATA, REQUEST_RELIGION_DATA, TOGGLE_CATEGORY, TOGGLE_VALUE, barChart, barsInitialState, objectAssign, ref;

objectAssign = require('object-assign');

ref = require('../../actions/demographics/religion-bars-actions.js'), REQUEST_RELIGION_DATA = ref.REQUEST_RELIGION_DATA, RECEIVE_RELIGION_DATA = ref.RECEIVE_RELIGION_DATA, TOGGLE_CATEGORY = ref.TOGGLE_CATEGORY, MOUSE_OVER = ref.MOUSE_OVER, TOGGLE_VALUE = ref.TOGGLE_VALUE, ERROR_RECEIVE_RELIGION_DATA = ref.ERROR_RECEIVE_RELIGION_DATA, FILTER_USED = ref.FILTER_USED, CONTROLS_OPENED = ref.CONTROLS_OPENED, CONTROLS_CLOSED = ref.CONTROLS_CLOSED, DISTRICT_SEARCH = ref.DISTRICT_SEARCH, INIT_BARS = ref.INIT_BARS, INIT_BARS_OFF = ref.INIT_BARS_OFF, INIT_DONE = ref.INIT_DONE;

barsInitialState = {
  chartName: 'religiousBars',
  isFetching: false,
  isDefault: true,
  isControlsOpen: false,
  _category: {
    value: 'countries',
    label: 'Geography (Countries)'
  },
  _value: {
    value: 'K04000001',
    label: 'England \& Wales'
  },
  activeCategory: 'Geography (Countries)',
  activeValue: 'England \& Wales',
  data: {},
  error: false,
  updateTable: false,
  updateRelBars: false,
  district_query: 'default',
  _mouseOverData: {},
  init_bars: false,
  init_done: false
};

barChart = function(state, action) {
  if (state == null) {
    state = barsInitialState;
  }
  switch (action.type) {
    case TOGGLE_CATEGORY:
      return objectAssign({}, state, {
        _category: action.category,
        updateRelBars: false,
        init_bars: false
      });
    case TOGGLE_VALUE:
      return objectAssign({}, state, {
        _value: action.value,
        updateRelBars: false,
        init_bars: false
      });
    case CONTROLS_OPENED:
      return objectAssign({}, state, {
        isControlsOpen: true,
        updateRelBars: false,
        init_bars: false
      });
    case CONTROLS_CLOSED:
      return objectAssign({}, state, {
        isControlsOpen: false,
        updateRelBars: false,
        init_bars: false
      });
    case DISTRICT_SEARCH:
      return objectAssign({}, state, {
        district_query: action.query,
        updateRelBars: false,
        init_bars: false
      });
    case FILTER_USED:
      return objectAssign({}, state, {
        isDefault: false,
        updateRelBars: false,
        init_bars: false
      });
    case INIT_BARS:
      return objectAssign({}, state, {
        init_bars: true
      });
    case INIT_BARS_OFF:
      return objectAssign({}, state, {
        init_bars: false
      });
    case INIT_DONE:
      return objectAssign({}, state, {
        init_done: true,
        updateRelBars: false
      });
    case REQUEST_RELIGION_DATA:
      return objectAssign({}, state, {
        isFetching: true,
        updateRelBars: false,
        init_bars: false
      });
    case RECEIVE_RELIGION_DATA:
      return objectAssign({}, state, {
        isFetching: false,
        data: action.data,
        activeCategory: state._category.label,
        activeValue: state._value.label,
        updateRelBars: true,
        init_bars: false
      });
    case ERROR_RECEIVE_RELIGION_DATA:
      return objectAssign({}, state, {
        isFetching: false,
        error: true,
        errorMessage: action.error,
        init_bars: false
      });
    case MOUSE_OVER:
      return objectAssign({}, state, {
        updateRelBars: false,
        _mouseOverData: action.mouseOverData,
        init_bars: false
      });
    default:
      return state;
  }
};

module.exports = barChart;

//# sourceMappingURL=religion-bars-reducers.map
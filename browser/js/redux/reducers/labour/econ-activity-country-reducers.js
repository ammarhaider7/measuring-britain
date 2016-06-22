// Generated by CoffeeScript 1.10.0
var CONTROLS_CLOSED, CONTROLS_OPENED, DISTRICT_SEARCH, ERROR_RECEIVE_ECON_COUNTRY_DATA, EconCountryChart, FILTER_USED, INIT_DONE, INIT_ECON_COUNTRY, INIT_ECON_COUNTRY_OFF, MOUSE_OVER, RECEIVE_ECON_COUNTRY_DATA, REQUEST_ECON_COUNTRY_DATA, TOGGLE_CATEGORY, TOGGLE_VALUE, econCountryInitState, objectAssign, ref;

objectAssign = require('object-assign');

ref = require('../../actions/labour/econ-activity-country-actions.js'), REQUEST_ECON_COUNTRY_DATA = ref.REQUEST_ECON_COUNTRY_DATA, RECEIVE_ECON_COUNTRY_DATA = ref.RECEIVE_ECON_COUNTRY_DATA, TOGGLE_CATEGORY = ref.TOGGLE_CATEGORY, MOUSE_OVER = ref.MOUSE_OVER, TOGGLE_VALUE = ref.TOGGLE_VALUE, ERROR_RECEIVE_ECON_COUNTRY_DATA = ref.ERROR_RECEIVE_ECON_COUNTRY_DATA, FILTER_USED = ref.FILTER_USED, CONTROLS_OPENED = ref.CONTROLS_OPENED, CONTROLS_CLOSED = ref.CONTROLS_CLOSED, DISTRICT_SEARCH = ref.DISTRICT_SEARCH, INIT_ECON_COUNTRY = ref.INIT_ECON_COUNTRY, INIT_ECON_COUNTRY_OFF = ref.INIT_ECON_COUNTRY_OFF, INIT_DONE = ref.INIT_DONE;

econCountryInitState = {
  chartName: 'economicActivityByCountry',
  isFetching: false,
  isDefault: true,
  isControlsOpen: false,
  _category: {
    value: 'countries',
    label: 'Geography (Countries)'
  },
  _value: {
    value: '2092957703',
    label: 'England & Wales'
  },
  activeCategory: 'Geography (Countries)',
  activeValue: 'England & Wales',
  data: {},
  error: false,
  updateTable: false,
  updateMainChart: false,
  district_query: 'default',
  _mouseOverData: {},
  init_econ_country: false,
  init_done: false
};

EconCountryChart = function(state, action) {
  if (state == null) {
    state = econCountryInitState;
  }
  switch (action.type) {
    case TOGGLE_CATEGORY:
      return objectAssign({}, state, {
        _category: action.category,
        updateMainChart: false,
        updateTable: false,
        init_econ_country: false
      });
    case TOGGLE_VALUE:
      return objectAssign({}, state, {
        _value: action.value,
        updateMainChart: false,
        init_econ_country: false,
        updateTable: false
      });
    case CONTROLS_OPENED:
      return objectAssign({}, state, {
        isControlsOpen: true,
        updateMainChart: false,
        init_econ_country: false,
        updateTable: false
      });
    case CONTROLS_CLOSED:
      return objectAssign({}, state, {
        isControlsOpen: false,
        updateMainChart: false,
        init_econ_country: false,
        updateTable: false
      });
    case DISTRICT_SEARCH:
      return objectAssign({}, state, {
        district_query: action.query,
        updateMainChart: false,
        init_econ_country: false,
        updateTable: false
      });
    case FILTER_USED:
      return objectAssign({}, state, {
        isDefault: false,
        updateMainChart: false,
        init_econ_country: false,
        updateTable: false
      });
    case INIT_ECON_COUNTRY:
      return objectAssign({}, state, {
        init_econ_country: true,
        updateTable: false
      });
    case INIT_ECON_COUNTRY_OFF:
      return objectAssign({}, state, {
        init_econ_country: false,
        updateTable: false
      });
    case INIT_DONE:
      return objectAssign({}, state, {
        init_done: true,
        updateMainChart: false,
        updateTable: false
      });
    case REQUEST_ECON_COUNTRY_DATA:
      return objectAssign({}, state, {
        isFetching: true,
        updateMainChart: false,
        updateTable: false,
        init_econ_country: false
      });
    case RECEIVE_ECON_COUNTRY_DATA:
      return objectAssign({}, state, {
        isFetching: false,
        data: action.data,
        activeCategory: state._category.label,
        activeValue: state._value.label,
        updateMainChart: true,
        init_econ_country: false,
        updateTable: false
      });
    case ERROR_RECEIVE_ECON_COUNTRY_DATA:
      return objectAssign({}, state, {
        isFetching: false,
        error: true,
        errorMessage: action.error,
        init_econ_country: false,
        updateTable: false
      });
    case MOUSE_OVER:
      return objectAssign({}, state, {
        updateMainChart: false,
        _mouseOverData: action.mouseOverData,
        init_econ_country: false,
        updateTable: true
      });
    default:
      return state;
  }
};

module.exports = EconCountryChart;

//# sourceMappingURL=econ-activity-country-reducers.map

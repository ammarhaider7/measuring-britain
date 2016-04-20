// Generated by CoffeeScript 1.10.0
var CONTROLS_CLOSED, CONTROLS_OPENED, ERROR_RECEIVE_ETHNIC_DATA, FILTER_USED, MOUSE_OVER, RECEIVE_ETHNIC_DATA, REQUEST_ETHNIC_DATA, TOGGLE_CATEGORY, TOGGLE_VALUE, controlsClosed, controlsOpened, errorReceivingeEthnicData, fetchSunburstData, filterUsed, mouseOver, receiveEthnicData, requestEthnicData, sunBurstService, sunburstDataParser, toggleCategory, toggleValue;

sunBurstService = require('../../../services/nomis/demographics/ethnic-sunburst-service.js');

sunburstDataParser = require('../../../services/nomis/demographics/ethnic-sunburst-parser.js');

REQUEST_ETHNIC_DATA = "REQUEST_ETHNIC_DATA";

RECEIVE_ETHNIC_DATA = "RECEIVE_ETHNIC_DATA";

TOGGLE_CATEGORY = "S_TOGGLE_CATEGORY";

MOUSE_OVER = "S_MOUSE_OVER";

TOGGLE_VALUE = "S_TOGGLE_VALUE";

ERROR_RECEIVE_ETHNIC_DATA = "ERROR_RECEIVE_ETHNIC_DATA";

FILTER_USED = "S_FILTER_USED";

CONTROLS_OPENED = "S_CONTROLS_OPENED";

CONTROLS_CLOSED = "S_CONTROLS_CLOSED";

toggleValue = function(value, selectionOption) {
  return {
    type: TOGGLE_VALUE,
    value: value,
    selectionOption: selectionOption
  };
};

toggleCategory = function(category, selectionOption) {
  return {
    type: TOGGLE_CATEGORY,
    category: category,
    selectionOption: selectionOption
  };
};

controlsOpened = function() {
  return {
    type: CONTROLS_OPENED,
    isControlsOpen: true
  };
};

controlsClosed = function() {
  return {
    type: CONTROLS_CLOSED,
    isControlsOpen: false
  };
};

mouseOver = function(mouseOverData) {
  return {
    type: MOUSE_OVER,
    mouseOverData: mouseOverData
  };
};

requestEthnicData = function(filterOptions) {
  return {
    type: REQUEST_ETHNIC_DATA,
    filterOptions: filterOptions
  };
};

filterUsed = function() {
  return {
    type: FILTER_USED
  };
};

receiveEthnicData = function(data) {
  return {
    type: RECEIVE_ETHNIC_DATA,
    data: data,
    receivedAt: Date.now()
  };
};

errorReceivingeEthnicData = function(error) {
  return {
    type: ERROR_RECEIVE_ETHNIC_DATA,
    barsError: error
  };
};

fetchSunburstData = function(filterOptions) {};

module.exports = {
  REQUEST_ETHNIC_DATA: REQUEST_ETHNIC_DATA,
  RECEIVE_ETHNIC_DATA: RECEIVE_ETHNIC_DATA,
  TOGGLE_CATEGORY: TOGGLE_CATEGORY,
  MOUSE_OVER: MOUSE_OVER,
  TOGGLE_VALUE: TOGGLE_VALUE,
  ERROR_RECEIVE_ETHNIC_DATA: ERROR_RECEIVE_ETHNIC_DATA,
  FILTER_USED: FILTER_USED,
  CONTROLS_OPENED: CONTROLS_OPENED,
  CONTROLS_CLOSED: CONTROLS_CLOSED,
  requestEthnicData: requestEthnicData,
  receiveEthnicData: receiveEthnicData,
  toggleCategory: toggleCategory,
  toggleValue: toggleValue,
  errorReceivingeEthnicData: errorReceivingeEthnicData,
  filterUsed: filterUsed,
  controlsOpened: controlsOpened,
  controlsClosed: controlsClosed
};

//# sourceMappingURL=ethnic-sunburst-actions.map

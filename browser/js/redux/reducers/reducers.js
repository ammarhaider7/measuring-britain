// Generated by CoffeeScript 1.10.0
var MOUSE_OVER, TOGGLE_CATEGORY, TOGGLE_FILTER, category, combineReducers, filterOptions, initialOptions, mbReducer, mouseOverOptions, objectAssign, ref;

combineReducers = require('redux').combineReducers;

objectAssign = require('object-assign');

ref = require('../actions/actions.js'), TOGGLE_FILTER = ref.TOGGLE_FILTER, TOGGLE_CATEGORY = ref.TOGGLE_CATEGORY, MOUSE_OVER = ref.MOUSE_OVER;

initialOptions = {
  options: {
    category: 'default',
    value: 'default'
  }
};

filterOptions = function(state, action) {
  if (state == null) {
    state = initialOptions;
  }
  switch (action.type) {
    case TOGGLE_FILTER:
      return objectAssign({}, state, {
        options: action.filterOptions
      });
    default:
      return state;
  }
};

mouseOverOptions = function(state, action) {
  if (state == null) {
    state = {};
  }
  switch (action.type) {
    case MOUSE_OVER:
      return objectAssign({}, state, {
        options: action.mouseOverOptions
      });
    default:
      return state;
  }
};

category = function(state, action) {
  if (state == null) {
    state = 'default';
  }
  switch (action.type) {
    case TOGGLE_CATEGORY:
      return action.category;
    default:
      return state;
  }
};

mbReducer = combineReducers({
  filterOptions: filterOptions,
  mouseOverOptions: mouseOverOptions,
  category: category
});

module.exports = mbReducer;

//# sourceMappingURL=reducers.map

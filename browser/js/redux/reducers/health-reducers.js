// Generated by CoffeeScript 1.10.0
var combineReducers, disabilityChart, genHealthChart, mbReducer, objectAssign;

combineReducers = require('redux').combineReducers;

objectAssign = require('object-assign');

genHealthChart = require('./health/general-health-reducers.js');

disabilityChart = require('./health/health-disability-reducers.js');

mbReducer = combineReducers({
  genHealthChart: genHealthChart,
  disabilityChart: disabilityChart
});

module.exports = mbReducer;

//# sourceMappingURL=health-reducers.map

// Generated by CoffeeScript 1.10.0
var combineReducers, disabilityChart, mbReducer;

combineReducers = require('redux').combineReducers;

disabilityChart = require('../health/health-disability-reducers.js');

mbReducer = combineReducers({
  disabilityChart: disabilityChart
});

module.exports = mbReducer;

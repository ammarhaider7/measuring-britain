{ combineReducers } = require 'redux'
objectAssign = require 'object-assign'
stackedAreaChart = require './health/general-health-reducers.js'

mbReducer = combineReducers {
	stackedAreaChart
}

module.exports = mbReducer
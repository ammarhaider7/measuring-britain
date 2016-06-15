{ combineReducers } = require 'redux'
disabilityChart = require '../health/health-disability-reducers.js'

mbReducer = combineReducers {
	disabilityChart
}

module.exports = mbReducer
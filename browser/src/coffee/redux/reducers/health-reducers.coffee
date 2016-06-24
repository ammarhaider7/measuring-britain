{ combineReducers } = require 'redux'
objectAssign = require 'object-assign'
genHealthChart = require './health/general-health-reducers.js'
disabilityChart = require './health/health-disability-reducers.js'

mbReducer = combineReducers {
	genHealthChart
	disabilityChart
}

module.exports = mbReducer
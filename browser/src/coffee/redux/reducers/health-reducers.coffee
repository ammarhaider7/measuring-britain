{ combineReducers } = require 'redux'
objectAssign = require 'object-assign'
genHealthChart = require './health/general-health-reducers.js'

mbReducer = combineReducers {
	genHealthChart
}

module.exports = mbReducer
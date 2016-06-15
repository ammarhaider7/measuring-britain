{ combineReducers } = require 'redux'
genHealthChart = require '../health/general-health-reducers.js'

mbReducer = combineReducers {
	genHealthChart
}

module.exports = mbReducer
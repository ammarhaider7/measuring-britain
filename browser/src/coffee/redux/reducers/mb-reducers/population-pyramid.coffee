{ combineReducers } = require 'redux'
pyramidChart = require '../demographics/pyramid-reducers.js'

mbReducer = combineReducers {
	pyramidChart
}

module.exports = mbReducer
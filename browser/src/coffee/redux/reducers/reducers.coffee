{ combineReducers } = require 'redux'
objectAssign = require 'object-assign'
pyramidChart = require './demographics-reducers.js'

mbReducer = combineReducers {
	pyramidChart
}

module.exports = mbReducer
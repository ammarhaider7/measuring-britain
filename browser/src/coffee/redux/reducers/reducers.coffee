{ combineReducers } = require 'redux'
objectAssign = require 'object-assign'
pyramidChart = require './demographics/pyramid-reducers.js'

mbReducer = combineReducers {
	pyramidChart
}

module.exports = mbReducer
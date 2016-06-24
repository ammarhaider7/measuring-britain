{ combineReducers } = require 'redux'
relBarChart = require '../demographics/religion-bars-reducers.js'

mbReducer = combineReducers {
	relBarChart
}

module.exports = mbReducer
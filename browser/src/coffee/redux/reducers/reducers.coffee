{ combineReducers } = require 'redux'
objectAssign = require 'object-assign'
pyramidChart = require './demographics/pyramid-reducers.js'
ethnicSunburst = require './demographics/ethnic-sunburst-reducers.js'

mbReducer = combineReducers {
	pyramidChart
	ethnicSunburst
}

module.exports = mbReducer
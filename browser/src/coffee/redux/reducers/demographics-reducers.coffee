{ combineReducers } = require 'redux'
objectAssign = require 'object-assign'
pyramidChart = require './demographics/pyramid-reducers.js'
ethnicSunburst = require './demographics/ethnic-sunburst-reducers.js'
relBarChart = require './demographics/religion-bars-reducers.js'

mbReducer = combineReducers {
	pyramidChart
	ethnicSunburst
	relBarChart
}

module.exports = mbReducer
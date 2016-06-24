{ combineReducers } = require 'redux'
ethnicSunburst = require '../demographics/ethnic-sunburst-reducers.js'

mbReducer = combineReducers {
	ethnicSunburst
}

module.exports = mbReducer
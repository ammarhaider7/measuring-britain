{ combineReducers } = require 'redux'
economicActivityByCountry = require '../labour/econ-activity-country-reducers.js'

mbReducer = combineReducers {
	economicActivityByCountry
}

module.exports = mbReducer
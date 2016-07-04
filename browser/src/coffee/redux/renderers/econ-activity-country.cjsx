ReactDOM = require 'react-dom'
React = require 'react'
{ createStore, applyMiddleware } = require 'redux'
# { requestPyramidData, fetchPyramidData, mouseOver } = require './actions/demographics/pyramid-actions.js'
{ Provider } = require 'react-redux'
ReduxThunk = require('redux-thunk').default
{ EconByCountry, EconByCountryDetail } = require '../containers/labour/econ-activity-country-containers.js'
mbReducer = require '../reducers/mb-reducers/econ-activity-country.js'

# creating the store, associating the root reducer and thunk middleware
store = createStore mbReducer, applyMiddleware ReduxThunk

# log state
console.log 'getState 1'
console.log store.getState()
	
# Every time the state changes, log it
# Note that subscribe() returns a function for unregistering the listener
unsubscribe = store.subscribe ->
	console.log 'getState 2'
	console.log store.getState()

render = ->
	ReactDOM.render <Provider store={store}><EconByCountry/></Provider>, document.getElementById 'econ-country-component'
	ReactDOM.render <Provider store={store}><EconByCountryDetail/></Provider>, document.getElementById 'econ-country-details'

module.exports = render
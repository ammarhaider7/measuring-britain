ReactDOM = require 'react-dom'
React = require 'react'
{ createStore, applyMiddleware, compose } = require 'redux'
# { requestPyramidData, fetchPyramidData, mouseOver } = require './actions/demographics/pyramid-actions.js'
{ Provider } = require 'react-redux'
ReduxThunk = require('redux-thunk').default
{ Sunburst, SunburstTable } = require '../containers/demographics/ethnic-sunburst-containers.js'
mbReducer = require '../reducers/mb-reducers/ethnic-diversity.js'

# creating the store, associating the root reducer and thunk middleware
store = createStore(mbReducer, compose(
	applyMiddleware(ReduxThunk), 
	if window.devToolsExtension then window.devToolsExtension() else undefined
))

# log state
# console.log 'getState 1'
# console.log store.getState()
	
# Every time the state changes, log it
# Note that subscribe() returns a function for unregistering the listener
unsubscribe = store.subscribe ->
	# console.log 'getState 2'
	# console.log store.getState()

render = ->
	ReactDOM.render <Provider store={store}><Sunburst/></Provider>, document.getElementById 'sunburst-component'
	
module.exports = render
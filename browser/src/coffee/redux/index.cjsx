{ createStore, applyMiddleware } = require 'redux'
# { requestPyramidData, fetchPyramidData, mouseOver } = require './actions/demographics/pyramid-actions.js'
{ Provider } = require 'react-redux'
ReduxThunk = require('redux-thunk').default
{ Pyramid, Table, Bars } = require './containers/demographics/pyramid-containers.js'
{ Sunburst, SunburstTable } = require './containers/demographics/ethnic-sunburst-containers.js'
{ ReligionBars } = require './containers/demographics/religion-bars-containers.js'
mbReducer = require './reducers/reducers.js'
ReactDOM = require 'react-dom'
React = require 'react'

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
	ReactDOM.render <Provider store={store}><Pyramid/></Provider>, document.getElementById 'pyramid-container'
	ReactDOM.render <Provider store={store}><Table/></Provider>, document.getElementById 'pyramid-table'
	ReactDOM.render <Provider store={store}><Bars/></Provider>, document.getElementById 'pyramid-bars'
	ReactDOM.render <Provider store={store}><Sunburst/></Provider>, document.getElementById 'sunburst-component'
	ReactDOM.render <Provider store={store}><ReligionBars/></Provider>, document.getElementById 'rel-bar-chart-component'

module.exports = render
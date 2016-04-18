{ createStore, applyMiddleware } = require 'redux'
# { requestPyramidData, fetchPyramidData, mouseOver } = require './actions/demographics/pyramid-actions.js'
{ Provider } = require 'react-redux'
ReduxThunk = require('redux-thunk').default
{ Pyramid, Table, Bars } = require './containers/demographics/pyramid-containers.js'
{ Sunburst, SunburstTable } = require './containers/demographics/ethnic-sunburst-containers.js'
mbReducer = require './reducers/reducers.js'
ReactDOM = require 'react-dom'
React = require 'react'

# creating the store, associating the root reducer and thunk middleware
store = createStore mbReducer, applyMiddleware ReduxThunk

# log state
# console.log 'getState 1'
# console.log store.getState()

# store.dispatch fetchPyramidData null
	
# Every time the state changes, log it
# Note that subscribe() returns a function for unregistering the listener
unsubscribe = store.subscribe ->
	console.log 'getState 2'
	console.log store.getState()

# Dispatch some actions
# store.dispatch toggleFilter { category: 'FILTER_TOGGLED_CATEGORY', value: 'FILTER_TOGGLED_VALUE' }
# store.dispatch toggleCategory 'CATEGORY_TOGGLED'
# store.dispatch mouseOver { chart: 'MOUSEOVER_TOGGLED_CHART', segment: 'MOUSEOVER_TOGGLED_SEGMENT' }
# unsubscribe()

render = ->
	ReactDOM.render <Provider store={store}><Pyramid/></Provider>, document.getElementById 'pyramid-container'
	ReactDOM.render <Provider store={store}><Table/></Provider>, document.getElementById 'pyramid-table'
	ReactDOM.render <Provider store={store}><Bars/></Provider>, document.getElementById 'pyramid-bars'
	ReactDOM.render <Provider store={store}><Sunburst/></Provider>, document.getElementById 'sunburst-component'

module.exports = render
{ createStore } = require 'redux'
# { boundToggleFilter, boundToggleCategory, boundMouseOver, toggleFilter, toggleCategory, mouseOver } = require './actions/actions.js'
{ Provider } = require 'react-redux'
{ Pyramid, Table } = require './containers/containers.js'
mbReducer = require './reducers/reducers.js'
ReactDOM = require 'react-dom'
React = require 'react'

store = createStore mbReducer

# log state
console.log 'getState 1'
console.log store.getState()

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

renderPyramid = ->
	ReactDOM.render <Provider store={store}><Pyramid/></Provider>, document.getElementById 'pyramid-container'
	ReactDOM.render <Provider store={store}><Table/></Provider>, document.getElementById 'pyramid-table'

module.exports = renderPyramid
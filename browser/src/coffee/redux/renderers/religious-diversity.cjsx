{ createStore, applyMiddleware } = require 'redux'
# { requestPyramidData, fetchPyramidData, mouseOver } = require './actions/demographics/pyramid-actions.js'
{ Provider } = require 'react-redux'
ReduxThunk = require('redux-thunk').default
{ ReligionBars } = require '../containers/demographics/religion-bars-containers.js'
mbReducer = require '../reducers/mb-reducers/religious-diversity.js'

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
	ReactDOM.render <Provider store={store}><ReligionBars/></Provider>, document.getElementById 'rel-bar-chart-component'	

module.exports = render
{ createStore, applyMiddleware } = require 'redux'
{ Provider } = require 'react-redux'
ReduxThunk = require('redux-thunk').default
mbReducer = require '../reducers/health-reducers.js'
{ DisabilityChart } = require '../containers/health/health-disability-containers.js'

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
	ReactDOM.render <Provider store={store}><DisabilityChart/></Provider>, document.getElementById 'health-disability-component'

module.exports = render
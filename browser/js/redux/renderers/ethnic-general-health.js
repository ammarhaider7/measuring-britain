// Generated by CoffeeScript 1.10.0
var GenHealthChart, GenHealthChartDetail, Provider, ReduxThunk, applyMiddleware, createStore, mbReducer, ref, ref1, render, store, unsubscribe;

ref = require('redux'), createStore = ref.createStore, applyMiddleware = ref.applyMiddleware;

Provider = require('react-redux').Provider;

ReduxThunk = require('redux-thunk')["default"];

ref1 = require('../containers/health/general-health-containers.js'), GenHealthChart = ref1.GenHealthChart, GenHealthChartDetail = ref1.GenHealthChartDetail;

mbReducer = require('../reducers/mb-reducers/ethnic-general-health.js');

store = createStore(mbReducer, applyMiddleware(ReduxThunk));

console.log('getState 1');

console.log(store.getState());

unsubscribe = store.subscribe(function() {
  console.log('getState 2');
  return console.log(store.getState());
});

render = function() {
  ReactDOM.render(React.createElement(Provider, {
    "store": store
  }, React.createElement(GenHealthChart, null)), document.getElementById('general-health-component'));
  return ReactDOM.render(React.createElement(Provider, {
    "store": store
  }, React.createElement(GenHealthChartDetail, null)), document.getElementById('general-health-details'));
};

module.exports = render;

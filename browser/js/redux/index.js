// Generated by CoffeeScript 1.10.0
var Bars, Provider, Pyramid, React, ReactDOM, ReduxThunk, ReligionBars, Sunburst, SunburstTable, Table, applyMiddleware, createStore, mbReducer, ref, ref1, ref2, render, store, unsubscribe;

ref = require('redux'), createStore = ref.createStore, applyMiddleware = ref.applyMiddleware;

Provider = require('react-redux').Provider;

ReduxThunk = require('redux-thunk')["default"];

ref1 = require('./containers/demographics/pyramid-containers.js'), Pyramid = ref1.Pyramid, Table = ref1.Table, Bars = ref1.Bars;

ref2 = require('./containers/demographics/ethnic-sunburst-containers.js'), Sunburst = ref2.Sunburst, SunburstTable = ref2.SunburstTable;

ReligionBars = require('./containers/demographics/religion-bars-containers.js').ReligionBars;

mbReducer = require('./reducers/reducers.js');

ReactDOM = require('react-dom');

React = require('react');

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
  }, React.createElement(Pyramid, null)), document.getElementById('pyramid-container'));
  ReactDOM.render(React.createElement(Provider, {
    "store": store
  }, React.createElement(Table, null)), document.getElementById('pyramid-table'));
  ReactDOM.render(React.createElement(Provider, {
    "store": store
  }, React.createElement(Bars, null)), document.getElementById('pyramid-bars'));
  ReactDOM.render(React.createElement(Provider, {
    "store": store
  }, React.createElement(Sunburst, null)), document.getElementById('sunburst-component'));
  return ReactDOM.render(React.createElement(Provider, {
    "store": store
  }, React.createElement(ReligionBars, null)), document.getElementById('rel-bar-chart-component'));
};

module.exports = render;

//# sourceMappingURL=index.map

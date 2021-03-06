// Generated by CoffeeScript 1.10.0
var Provider, React, ReactDOM, ReduxThunk, Sunburst, SunburstTable, applyMiddleware, compose, createStore, mbReducer, ref, ref1, render, store, unsubscribe;

ReactDOM = require('react-dom');

React = require('react');

ref = require('redux'), createStore = ref.createStore, applyMiddleware = ref.applyMiddleware, compose = ref.compose;

Provider = require('react-redux').Provider;

ReduxThunk = require('redux-thunk')["default"];

ref1 = require('../containers/demographics/ethnic-sunburst-containers.js'), Sunburst = ref1.Sunburst, SunburstTable = ref1.SunburstTable;

mbReducer = require('../reducers/mb-reducers/ethnic-diversity.js');

store = createStore(mbReducer, compose(applyMiddleware(ReduxThunk)));

unsubscribe = store.subscribe(function() {});

render = function() {
  return ReactDOM.render(React.createElement(Provider, {
    "store": store
  }, React.createElement(Sunburst, null)), document.getElementById('sunburst-component'));
};

module.exports = render;

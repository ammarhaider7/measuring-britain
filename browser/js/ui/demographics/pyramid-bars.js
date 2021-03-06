// Generated by CoffeeScript 1.10.0
var $, React, drawPyrBars, pyBarsComponent;

React = require('react');

drawPyrBars = require('./d3/pyramidBars.js');

$ = require('jquery');

pyBarsComponent = React.createClass({displayName: "pyBarsComponent",
  getAppropriateHeight: function() {
    var window_height;
    window_height = $(window).height();
    if (window_height > 700) {
      return 320;
    } else {
      return $(window).height() - 320;
    }
  },
  componentDidMount: function() {
    return $(window).resize((function(_this) {
      return function() {
        return _this.onResize();
      };
    })(this));
  },
  onResize: function() {
    var resizeChart;
    resizeChart = drawPyrBars({
      resize: true,
      container: this.refs.pyramidBarsSvg,
      age: this.props._mouseOverData.age,
      females: this.props._mouseOverData.females,
      males: this.props._mouseOverData.males,
      initial: this.props._mouseOverData.initial,
      isDefault: this.props.isDefault,
      activeBarsValue: this.props.activeBarsValue
    });
    return resizeChart();
  },
  componentDidUpdate: function() {
    var pyrBars;
    if (this.props.updateBars === true) {
      pyrBars = drawPyrBars({
        resize: false,
        container: this.refs.pyramidBarsSvg,
        age: this.props._mouseOverData.age,
        females: this.props._mouseOverData.females,
        males: this.props._mouseOverData.males,
        initial: this.props._mouseOverData.initial,
        isDefault: this.props.isDefault,
        activeBarsValue: this.props.activeBarsValue
      });
      return pyrBars();
    }
  },
  render: function() {
    return React.createElement("div", {
      "className": (!(this.props.isFetching === true && this.props.isDefault === true) ? 'mb-grey-box' : void 0)
    }, (this.props.isFetching === true && this.props.isDefault === true ? React.createElement("img", {
      "src": "/images/mb_ajax_loader.gif",
      "className": "mb-spinner"
    }) : void 0), React.createElement("svg", {
      "className": "pyramid-bars-svg",
      "style": {
        width: '100%',
        height: this.getAppropriateHeight()
      },
      "ref": "pyramidBarsSvg"
    }, React.createElement("g", {
      "className": "x axis"
    }), React.createElement("g", {
      "className": "labels-group"
    }), React.createElement("g", {
      "className": "ages-group"
    }), React.createElement("g", {
      "className": "main-group"
    })));
  }
});

module.exports = pyBarsComponent;

// Generated by CoffeeScript 1.10.0
var React, drawPyrBars, pyBarsComponent;

React = require('react');

drawPyrBars = require('./d3/pyramidBars.js');

pyBarsComponent = React.createClass({displayName: "pyBarsComponent",
  componentDidUpdate: function() {
    var pyrBars;
    if (this.props.updateBars === true) {
      pyrBars = drawPyrBars({
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
      "src": "./images/mb_ajax_loader.gif",
      "className": "mb-spinner"
    }) : void 0), React.createElement("svg", {
      "className": "pyramid-bars-svg",
      "style": {
        width: '100%',
        height: '275px'
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

//# sourceMappingURL=pyramid-bars.map
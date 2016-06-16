// Generated by CoffeeScript 1.10.0
var ControlsNew, DisabilityChart, category_options, data, disabilityChart, value_options;

ControlsNew = require('../chart-controls-new.js');

data = require('../demographics/data/pyramid-chart-controls.js');

disabilityChart = require('./d3/health-disability-chart.js');

value_options = {
  districts: data.districts,
  ethnicities: data.ethnic_groups,
  religions: data.religions,
  regions: data.regions,
  countries: data.countries
};

category_options = data.category_options;

DisabilityChart = React.createClass({displayName: "DisabilityChart",
  componentWillMount: function() {
    if (this.props.isDefault === true && this.props.init_done === false) {
      this.props.fetchDisabilityData(null);
      return this.props.onInitDone();
    }
  },
  componentDidUpdate: function() {
    var draw;
    if (this.props.updateDisability === true) {
      draw = disabilityChart({
        container: this.refs.disabilitySvg,
        isDefault: this.props.isDefault,
        data: this.props.data,
        activeCategory: this.props.activeCategory,
        activeValue: this.props.activeValue,
        onMouseOver: this.props.onMouseOver
      });
      if (this.props.isDefault === true) {
        return draw.init();
      } else {
        return draw.update();
      }
    }
  },
  render: function() {
    return React.createElement("div", {
      "className": "col-xs-12 col-sm-12 mb-no-padding"
    }, React.createElement("div", {
      "className": "mt-medium"
    }, React.createElement(ControlsNew, React.__spread({}, this.props, {
      "omitted_categories": ["ethnicities", "districts", "religions"],
      "categories": category_options,
      "values": value_options
    })), React.createElement("img", {
      "src": "/images/mb_ajax_loader.gif",
      "className": (this.props.isFetching === true && this.props.isDefault === true ? 'mb-spinner' : 'hide')
    }), React.createElement("svg", {
      "className": "disability-svg mb-oxygen",
      "style": {
        width: '100%',
        height: '485px'
      },
      "ref": "disabilitySvg"
    }, React.createElement("g", {
      "className": "title-group mb-oxygen"
    }), React.createElement("g", {
      "className": "y axis"
    }), React.createElement("g", {
      "className": "x axis"
    }), React.createElement("g", {
      "className": "main-group"
    }, React.createElement("g", {
      "className": "legend-group"
    })))));
  }
});

module.exports = DisabilityChart;

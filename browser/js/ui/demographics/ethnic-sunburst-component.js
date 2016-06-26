// Generated by CoffeeScript 1.10.0
var ControlsNew, OnsAttr, SunburstComponent, category_options, data, drawSunburst, value_options;

ControlsNew = require('../chart-controls-new.js');

data = require('./data/pyramid-chart-controls.js');

drawSunburst = require('./d3/sunburst-partition.js');

OnsAttr = require('../../partials/chart-ons-attribution.js');

value_options = {
  districts: data.districts,
  ethnicities: data.ethnic_groups,
  religions: data.religions,
  regions: data.regions,
  countries: data.countries
};

category_options = data.category_options;

SunburstComponent = React.createClass({displayName: "SunburstComponent",
  getAppropriateHeight: function() {
    var window_height, window_width;
    window_width = $(window).width();
    window_height = $(window).height();
    if (window_height > 550 && window_width > 740) {
      return 550;
    } else {
      return 400;
    }
  },
  componentDidMount: function() {
    if (this.props.isDefault === true && this.props.init_done === false) {
      this.props.fetchSunburstData(null);
    }
    return $(window).resize((function(_this) {
      return function() {
        return _this.reactDrawSunburst({
          resize: true
        });
      };
    })(this));
  },
  reactDrawSunburst: function(resize_flag) {
    var sunburst;
    sunburst = drawSunburst({
      resize: resize_flag.resize,
      container: this.refs.sunburstSvg,
      data: this.props.data,
      isDefault: this.props.isDefault,
      onMouseOver: this.props.onMouseOver,
      activeCategory: this.props.activeCategory,
      activeValue: this.props.activeValue,
      onInitDone: this.props.onInitDone
    });
    if (resize_flag.resize === true) {
      return sunburst.resize();
    }
    if (this.props.isDefault === true && this.props.updateSunburst === true) {
      return sunburst.init();
    } else {
      return sunburst.update();
    }
  },
  componentDidUpdate: function() {
    if (this.props.updateSunburst === true) {
      return this.reactDrawSunburst({
        resize: false
      });
    }
  },
  render: function() {
    return React.createElement("div", {
      "className": "col-xs-12 col-sm-12 mb-no-padding"
    }, React.createElement("div", {
      "className": "sunburst mt-medium"
    }, React.createElement(ControlsNew, React.__spread({}, this.props, {
      "omitted_categories": ["ethnicities"],
      "categories": category_options,
      "values": value_options
    })), React.createElement("img", {
      "src": "/images/mb_ajax_loader.gif",
      "className": (this.props.isFetching === true && this.props.isDefault === true ? 'mb-spinner' : 'hide')
    }), React.createElement("svg", {
      "className": "sunburst-svg",
      "style": {
        width: '100%',
        height: this.getAppropriateHeight()
      },
      "ref": "sunburstSvg"
    }, React.createElement("g", {
      "className": "main-group"
    }), React.createElement("g", {
      "className": "key-group"
    }), React.createElement("g", {
      "className": "key-text-group mb-oxygen"
    }), React.createElement("g", {
      "className": "center-text-group"
    }), React.createElement("g", {
      "className": "ethnic-group-text"
    }), React.createElement("g", {
      "className": "total-value-group"
    }), React.createElement("g", {
      "className": "percentage-group"
    })), React.createElement(OnsAttr, null)));
  }
});

module.exports = SunburstComponent;

//# sourceMappingURL=ethnic-sunburst-component.map

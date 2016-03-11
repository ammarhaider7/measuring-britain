// Generated by CoffeeScript 1.10.0
var Controls, FancySelect, React;

React = require('react');

FancySelect = require('react-select');

Controls = React.createClass({displayName: "Controls",
  render: function() {
    return React.createElement("div", {
      "className": "mb-form hidden-xs clearfix"
    }, React.createElement("div", {
      "className": "mb-form-container col-sm-11 col-sm-offset-1"
    }, React.createElement("label", null, "Filter by"), React.createElement("div", {
      "className": "mb-form-group col-sm-4 mb-oxygen"
    }, React.createElement(FancySelect, {
      "className": "mb-input-sm",
      "placeholder": "1. Choose a category",
      "options": this.props.categories,
      "value": (function(_this) {
        return function() {
          var category, i, len, ref;
          ref = _this.props.categories;
          for (i = 0, len = ref.length; i < len; i++) {
            category = ref[i];
            if (category.value === _this.props.category) {
              return category.label;
            }
          }
        };
      })(this)(),
      "onChange": this.props.onCategoryChange
    })), React.createElement("div", {
      "className": "mb-form-group category-group col-sm-5 mb-oxygen"
    }, React.createElement(FancySelect, {
      "className": "mb-input-sm",
      "placeholder": (function(_this) {
        return function() {
          var category, i, len, ref;
          ref = _this.props.categories;
          for (i = 0, len = ref.length; i < len; i++) {
            category = ref[i];
            if (category.value === _this.props.category) {
              return 'Search ' + category.value + '..';
            } else if (category.value !== _this.props.category) {
              continue;
            }
          }
          return '2. Choose a value';
        };
      })(this)(),
      "options": (function(_this) {
        return function() {
          var category, i, len, ref;
          ref = _this.props.categories;
          for (i = 0, len = ref.length; i < len; i++) {
            category = ref[i];
            if (category.value === _this.props.category) {
              return _this.props.values[category.value];
            }
          }
        };
      })(this)()
    })), React.createElement("button", {
      "className": "btn btn-sm btn-default"
    }, "Go")));
  }
});

module.exports = Controls;

//# sourceMappingURL=chart-controls.map

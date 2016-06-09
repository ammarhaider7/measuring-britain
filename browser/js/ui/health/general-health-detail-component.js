// Generated by CoffeeScript 1.10.0
var GenHealthDetailComponent, format, percFormat;

format = d3.format('.3s');

percFormat = d3.format(',.2%');

GenHealthDetailComponent = React.createClass({displayName: "GenHealthDetailComponent",
  onToggleSex: function(e) {
    var el, sexLabel, sexVal;
    el = e.target;
    sexVal = el.getAttribute('data-value');
    sexLabel = el.innerHTML;
    this.props.onToggleSex(sexLabel, sexVal);
    return this.props.fetchGenHealthData({
      isDefault: false,
      category: this.props._category,
      value: this.props._value,
      sex: {
        label: sexLabel,
        value: sexVal
      }
    });
  },
  highlight: function(ethnicity) {
    return this.props.onHighlightLine(ethnicity);
  },
  unHighlight: function(ethnicity, index) {
    return this.props.onUnHighlightLine(ethnicity, index);
  },
  handleChange: function(event) {
    var $el, arr, index, value;
    $el = $(event.target);
    value = event.target.value;
    if ($el.parent().hasClass('highlight') === true) {
      $el.parent().removeClass('highlight');
      arr = this.props._highlights;
      index = arr.indexOf(value);
      return this.unHighlight(value, index);
    } else {
      $el.parent().addClass('highlight');
      return this.highlight(value);
    }
  },
  trimEthnicity: function(ethnicity_string) {
    var str, trimmedStr;
    if (ethnicity_string.indexOf('Gypsy') !== -1) {
      trimmedStr = 'Gypsy';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('English') !== -1) {
      trimmedStr = 'British';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('Any other') !== -1) {
      trimmedStr = 'Any other';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('Arab') !== -1) {
      trimmedStr = 'Arab';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('and') !== -1) {
      str = ethnicity_string.replace(' and ', '/');
      trimmedStr = str.substr(str.indexOf(':') + 2, str.length);
      return trimmedStr;
    } else if (ethnicity_string.indexOf('Other') !== -1) {
      trimmedStr = 'Other';
      return trimmedStr;
    } else {
      str = ethnicity_string;
      trimmedStr = str.substr(str.indexOf(':') + 2, str.length);
      return trimmedStr;
    }
  },
  render: function() {
    var ethnicity, group, i, j;
    return React.createElement("div", null, React.createElement("div", null, React.createElement("span", {
      "className": "mb-oxygen mb-gender-toggles-label"
    }, "Choose gender: "), React.createElement("div", {
      "className": "btn-group mb-gender-toggles mb-oxygen mb-right",
      "role": "group",
      "aria-label": "..."
    }, React.createElement("button", {
      "type": "button",
      "className": (this.props.sex === 'All' ? "btn btn-default active" : "btn btn-default"),
      "data-value": '0',
      "onClick": this.onToggleSex
    }, "All"), React.createElement("button", {
      "type": "button",
      "className": (this.props.sex === 'Female' ? "btn btn-default active" : "btn btn-default"),
      "data-value": '2',
      "onClick": this.onToggleSex
    }, "Female"), React.createElement("button", {
      "type": "button",
      "className": (this.props.sex === 'Male' ? "btn btn-default active" : "btn btn-default"),
      "data-value": '1',
      "onClick": this.onToggleSex
    }, "Male"))), React.createElement("div", {
      "className": "mb-oxygen clearfix mt-medium"
    }, React.createElement("h4", {
      "className": "mb-left"
    }, React.createElement("strong", null, "Highlight ethnicities")), React.createElement("div", {
      "className": "checkbox mb-right"
    }, React.createElement("label", {
      "className": "checkbox-zone"
    }, React.createElement("input", {
      "type": "checkbox",
      "value": "Mean",
      "onChange": this.handleChange
    }), "Show mean")), React.createElement("div", {
      "className": ""
    }, React.createElement("img", {
      "src": "./images/mb_ajax_loader.gif",
      "className": (this.props.isFetching === true && this.props.isDefault === true ? 'mb-spinner' : 'hide')
    }), ((function() {

      /* jshint ignore:start */
      var k, len, ref, results;
      if (this.props.data.ethnicities != null) {
        ref = this.props.data.ethnicities_grouped;
        results = [];
        for (i = k = 0, len = ref.length; k < len; i = ++k) {
          group = ref[i];
          results.push(React.createElement("div", {
            "key": i,
            "className": "col-sm-4 mt-small ethnic-checkboxes-column"
          }, (function() {
            var l, len1, results1;
            results1 = [];
            for (j = l = 0, len1 = group.length; l < len1; j = ++l) {
              ethnicity = group[j];
              if (typeof ethnicity === 'object') {
                results1.push(React.createElement("div", {
                  "key": ethnicity.title
                }, React.createElement("label", {
                  "className": "ethnic_title"
                }, React.createElement("strong", null, ethnicity.title))));
              } else {
                results1.push(React.createElement("div", {
                  "className": "checkbox ethnicity",
                  "key": ethnicity
                }, React.createElement("label", {
                  "className": "checkbox-zone"
                }, React.createElement("input", {
                  "type": "checkbox",
                  "value": ethnicity,
                  "onChange": this.handleChange
                }), this.trimEthnicity(ethnicity))));
              }
            }
            return results1;
          }).call(this)));
        }
        return results;
      }

      /* jshint ignore:end */
    }).call(this)))));
  }
});

module.exports = GenHealthDetailComponent;

//# sourceMappingURL=general-health-detail-component.map

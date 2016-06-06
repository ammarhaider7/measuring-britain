// Generated by CoffeeScript 1.10.0
var ControlsNew;

ControlsNew = React.createClass({displayName: "ControlsNew",
  onCategoryChange: function(e) {
    var catLabel, catVal, el;
    el = e.target;
    catVal = el.getAttribute('data-value');
    catLabel = el.innerHTML;
    return this.props.onCategoryChange({
      value: catVal,
      label: catLabel
    });
  },
  onValueChange: function(e) {
    var $currVals, $el, $ethnicDiv, el, valLabel, valVal;
    e.preventDefault();
    el = e.target;
    valVal = el.getAttribute('data-value');
    valLabel = el.innerHTML;
    this.props.onValueChange({
      value: valVal,
      label: valLabel
    });
    $ethnicDiv = d3.select('#mb_ethnic_diversity');
    $el = d3.select(el);
    $currVals = $ethnicDiv.selectAll('.mb-pill.active');
    $currVals.classed('active', false);
    return $el.classed('active', true);
  },
  onControlsOpen: function() {
    var $controlsContainer, isClosed, isOpen;
    $controlsContainer = d3.select(this.refs.controlsContainer);
    isOpen = $controlsContainer.classed('open');
    isClosed = $controlsContainer.classed('closed');
    if (isOpen) {
      this.props.onControlsClosed();
    }
    if (isClosed) {
      this.props.onControlsOpen();
    }
    return $controlsContainer.classed('open', !isOpen).classed('closed', !isClosed);
  },
  doSearch: function(e) {
    var query;
    query = e.target.value;
    return this.props.onDistrictSearch(query);
  },
  fetchData: function() {
    var fetchChartData;
    this.refs.controlsLink.click();
    if (this.props.chartName === 'sunburst') {
      fetchChartData = 'fetchSunburstData';
    } else if (this.props.chartName === 'relBars') {
      fetchChartData = 'fetchReligionData';
    } else if (this.props.chartName === "genHealthChart") {
      fetchChartData = 'fetchGenHealthData';
      return this.props[fetchChartData]({
        isDefault: false,
        category: this.props._category,
        value: this.props._value,
        sex: {
          label: this.props.sex,
          value: +this.props.sex_code
        }
      });
    }
    return this.props[fetchChartData]({
      isDefault: false,
      category: this.props._category,
      value: this.props._value
    });
  },
  render: function() {
    var category, district, i, query, value;
    return React.createElement("div", {
      "className": "controls-container clearfix closed mb-oxygen",
      "ref": "controlsContainer"
    }, React.createElement("a", {
      "onClick": this.onControlsOpen,
      "ref": "controlsLink",
      "className": "controls-toggle-link",
      "role": "button",
      "data-toggle": "collapse",
      "data-target": "#collapse" + this.props.chartName,
      "aria-expanded": "false",
      "aria-controls": "collapse" + this.props.chartName
    }, React.createElement("img", {
      "src": "./images/mb_ajax_loader.gif",
      "className": (this.props.isFetching === true && this.props.isDefault === false ? 'mb-spinner-controls' : 'hide')
    }), React.createElement("div", {
      "className": (this.props.isFetching === true && this.props.isDefault === false ? 'hide' : void 0)
    }, React.createElement("span", {
      "className": "text-center mb-control-value col-sm-5"
    }, this.props.activeCategory), React.createElement("span", {
      "className": "col-sm-5 text-center mb-control-value"
    }, this.props.activeValue), React.createElement("span", {
      "className": (this.props.isControlsOpen === true ? "glyphicon glyphicon-chevron-up mt-medium" : "glyphicon glyphicon-chevron-down mt-medium")
    }))), React.createElement("div", {
      "className": "collapse col-sm-12 mb-collapse",
      "id": "collapse" + this.props.chartName
    }, React.createElement("div", {
      "className": "container col-sm-12"
    }, React.createElement("div", {
      "className": "form-group mt-medium row"
    }, React.createElement("label", {
      "className": "pr-medium"
    }, "Filter by"), React.createElement("div", {
      "className": "btn-group"
    }, (function() {
      var j, len, ref, results;
      ref = this.props.categories;
      results = [];
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        category = ref[i];
        if ($.inArray(category.value, this.props.omitted_categories) === -1) {
          results.push(React.createElement("button", {
            "key": i,
            "type": "button",
            "className": (this.props._category.value === category.value ? "btn btn-default active" : "btn btn-default"),
            "onClick": this.onCategoryChange,
            "data-value": category.value
          }, category.label));
        } else {
          results.push(void 0);
        }
      }
      return results;
    }).call(this))), React.createElement("div", {
      "className": "form-group row"
    }, " ", (this.props._category.value !== 'districts' ? React.createElement("ul", {
      "className": "nav nav-pills pt-small pb-small pl-small"
    }, " ", (function() {
      var j, len, ref, results;
      ref = this.props.values[this.props._category.value];
      results = [];
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        value = ref[i];
        results.push(React.createElement("li", {
          "role": "presentation",
          "key": value.value
        }, React.createElement("a", {
          "data-value": value.value,
          "href": "#",
          "className": (this.props._value.label === value.label ? "mb-pill active" : "mb-pill"),
          "onClick": this.onValueChange
        }, value.label)));
      }
      return results;
    }).call(this)) : React.createElement("div", null, React.createElement("div", {
      "className": "col-sm-6"
    }, React.createElement("div", {
      "className": "input-group"
    }, React.createElement("span", {
      "className": "input-group-addon glyphicon glyphicon-search mb-glyphicon-input-addon",
      "aria-hidden": "true"
    }), React.createElement("input", {
      "type": "text",
      "className": "form-control",
      "placeholder": "Search Local Authority Districts...",
      "onChange": this.doSearch
    }))), React.createElement("div", {
      "className": "col-sm-6 mt-xsmall"
    }, React.createElement("a", {
      "href": "//local.direct.gov.uk/LDGRedirect/Start.do?mode=1",
      "target": "_blank"
    }, "What\'s my Local Authority District?"))))), (this.props._category.value === 'districts' ? React.createElement("div", {
      "className": "form-group row"
    }, (query = this.props.district_query, query !== '' && query.length > 1 && query !== 'default' ? React.createElement("ul", {
      "className": "nav nav-pills pl-small pt-small pb-small"
    }, (function() {
      var j, len, ref, results;
      ref = this.props.values.districts;
      results = [];
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        district = ref[i];
        if (district.label.toLowerCase().indexOf(query) !== -1) {
          results.push(React.createElement("li", {
            "role": "presentation",
            "key": district.value
          }, React.createElement("a", {
            "data-value": district.value,
            "href": "#",
            "className": (this.props.activeValue === district.label ? "mb-pill active" : "mb-pill"),
            "onClick": this.onValueChange
          }, district.label)));
        } else {
          results.push(void 0);
        }
      }
      return results;
    }).call(this)) : void 0)) : void 0), React.createElement("div", {
      "className": "row mb-medium"
    }, React.createElement("button", {
      "className": (this.props.isFetching === true ? "btn btn-default mb-btn-primary mb-btn-fetching" : "btn btn-default mb-btn-primary"),
      "onClick": this.fetchData
    }, (this.props.isFetching === true ? "Loading..." : "Customise"))))));
  }
});

module.exports = ControlsNew;

//# sourceMappingURL=chart-controls-new.map

// Generated by CoffeeScript 1.10.0
var $, ControlsNew, React, d3;

d3 = require('d3');

$ = require('jquery');

React = require('react');

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
  manualControlsLinkClick: function() {
    var targetId;
    targetId = this.refs.controlsLink.getAttribute('data-target');
    console.log('targetId');
    console.log(targetId);
    $(targetId).collapse('toggle');
    return this.onControlsOpen();
  },
  fetchData: function() {
    var fetchChartData;
    if (this.props.chartName === 'sunburst') {
      fetchChartData = 'fetchSunburstData';
    } else if (this.props.chartName === 'relBars') {
      fetchChartData = 'fetchReligionData';
    } else if (this.props.chartName === 'economicActivityByCountry') {
      fetchChartData = 'fetchEconCountryData';
    } else if (this.props.chartName === 'disabilityChart') {
      fetchChartData = 'fetchDisabilityData';
      return (function(_this) {
        return function() {
          _this.props[fetchChartData]({
            isDefault: false,
            category: _this.props._category,
            value: _this.props._value,
            sex: {
              label: _this.props.sex,
              value: +_this.props.sex_code
            }
          });
          return _this.manualControlsLinkClick();
        };
      })(this)();
    } else if (this.props.chartName === "genHealthChart") {
      fetchChartData = 'fetchGenHealthData';
      return (function(_this) {
        return function() {
          _this.props[fetchChartData]({
            isDefault: false,
            category: _this.props._category,
            value: _this.props._value,
            sex: {
              label: _this.props.sex,
              value: +_this.props.sex_code
            }
          });
          return _this.manualControlsLinkClick();
        };
      })(this)();
    }
    this.props[fetchChartData]({
      isDefault: false,
      category: this.props._category,
      value: this.props._value
    });
    return this.manualControlsLinkClick();
  },
  render: function() {
    var query;
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
      "src": "/images/mb_ajax_loader.gif",
      "className": (this.props.isFetching === true && this.props.isDefault === false ? 'mb-spinner-controls' : 'hide')
    }), React.createElement("div", {
      "className": (this.props.isFetching === true && this.props.isDefault === false ? 'hide' : void 0)
    }, React.createElement("span", {
      "className": "text-center mb-control-value col-sm-5"
    }, (this.props.chartName === "genHealthChart" ? this.props.activeValue : this.props.activeCategory)), React.createElement("span", {
      "className": "col-sm-5 text-center mb-control-value"
    }, (this.props.chartName === "genHealthChart" ? "Gender: " + this.props.sex : this.props.activeValue)), React.createElement("span", {
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
    }, ((function() {

      /*
      for category, i in @props.categories
         * unless category.value is @props.omitted_category
        unless $.inArray(category.value, @props.omitted_categories) isnt -1
          <button 
            key={i} 
            type="button" 
            className={ if @props._category.value is category.value then "btn btn-default active" else "btn btn-default" }
            onClick={ @onCategoryChange }
            data-value={ category.value }
          >
          { category.label }
          </button>
       */
      return this.props.categories.map((function(_this) {
        return function(category, i) {
          if ($.inArray(category.value, _this.props.omitted_categories) === -1) {
            return React.createElement("button", {
              "key": i,
              "type": "button",
              "className": (_this.props._category.value === category.value ? "btn btn-default active" : "btn btn-default"),
              "onClick": _this.onCategoryChange,
              "data-value": category.value
            }, category.label);
          }
        };
      })(this));
    }).call(this)))), React.createElement("div", {
      "className": "form-group row"
    }, " ", (this.props._category.value !== 'districts' ? React.createElement("ul", {
      "className": "nav nav-pills pt-small pb-small pl-small"
    }, ((function() {

      /*
      for value, i in @props.values[@props._category.value]
        <li role="presentation" key={value.value}>
          <a 
            data-value={ value.value }
            href="#" 
            className={ if @props._value.label is value.label then "mb-pill active" else "mb-pill" }
            onClick={ @onValueChange }
          >
          { value.label }
          </a>
        </li>
       */
      return this.props.values[this.props._category.value].map((function(_this) {
        return function(value, i) {
          return React.createElement("li", {
            "role": "presentation",
            "key": value.value
          }, React.createElement("a", {
            "data-value": value.value,
            "href": "#",
            "className": (_this.props._value.label === value.label ? "mb-pill active" : "mb-pill"),
            "onClick": _this.onValueChange
          }, value.label));
        };
      })(this));
    }).call(this))) : React.createElement("div", null, React.createElement("div", {
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
    }, ((function() {

      /*
      for district, i in @props.values.districts
        if district.label.toLowerCase().indexOf(query) isnt -1
          <li role="presentation" key={district.value}>
            <a 
              data-value={ district.value }
              href="#" 
              className={ if @props.activeValue is district.label then "mb-pill active" else "mb-pill" }
              onClick={ @onValueChange }
            >
            { district.label }
            </a>
          </li>
       */
      return this.props.values.districts.map((function(_this) {
        return function(district, i) {
          if (district.label.toLowerCase().indexOf(query) > -1) {
            return React.createElement("li", {
              "role": "presentation",
              "key": district.value
            }, React.createElement("a", {
              "data-value": district.value,
              "href": "#",
              "className": (_this.props.activeValue === district.label ? "mb-pill active" : "mb-pill"),
              "onClick": _this.onValueChange
            }, district.label));
          }
        };
      })(this));
    }).call(this))) : void 0)) : void 0), React.createElement("div", {
      "className": "row mb-medium"
    }, React.createElement("button", {
      "className": (this.props.isFetching === true ? "btn btn-default mb-btn-primary mb-btn-fetching" : "btn btn-default mb-btn-primary"),
      "onClick": this.fetchData
    }, (this.props.isFetching === true ? "Loading..." : "Customise"))))));
  }
});

module.exports = ControlsNew;

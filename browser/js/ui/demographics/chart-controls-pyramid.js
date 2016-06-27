// Generated by CoffeeScript 1.10.0
var PyramidControls;

PyramidControls = React.createClass({displayName: "PyramidControls",
  onCategoryChange: function(e) {
    var catLabel, catVal, el, filteringOption;
    el = e.target;
    catVal = el.getAttribute('data-value');
    catLabel = el.innerHTML;
    filteringOption = this.props.filteringOption.option;
    if (filteringOption === 'bars') {
      return this.props.onCategoryChange({
        value: catVal,
        label: catLabel
      });
    } else if (filteringOption === 'line') {
      return this.props.onOutlineCategoryChange({
        value: catVal,
        label: catLabel
      });
    }
  },
  onValueChange: function(e) {
    var $currVals, $el, $pyramidDiv, el, filteringOption, valLabel, valVal;
    e.preventDefault();
    el = e.target;
    valVal = el.getAttribute('data-value');
    valLabel = el.innerHTML;
    filteringOption = this.props.filteringOption.option;
    if (filteringOption === 'bars') {
      this.props.onValueChange({
        value: valVal,
        label: valLabel
      });
    } else if (filteringOption === 'line') {
      this.props.onOutlineValueChange({
        value: valVal,
        label: valLabel
      });
    }
    $pyramidDiv = d3.select('#pyramid-container');
    $el = d3.select(el);
    $currVals = $pyramidDiv.selectAll('.mb-pill.active');
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
    this.props.fetchPyramidData({
      outlineRequested: this.props.outlineFilter === true ? true : false,
      isDefault: false,
      bars: {
        isDefault: false,
        category: this.props._barsCategory,
        value: this.props._barsValue
      },
      outline: {
        isDefault: false,
        category: this.props._outlineCategory,
        value: this.props._outlineValue
      }
    });
    return this.manualControlsLinkClick();
  },
  manualControlsLinkClick: function() {
    var targetId;
    targetId = this.refs.controlsLink.getAttribute('data-target');
    $(targetId).collapse('toggle');
    return this.onControlsOpen();
  },
  onToggleFilteringOption: function(e) {
    var activeCat, activeVal, cat, el, option, val;
    e.preventDefault();
    el = e.target;
    cat = el.getAttribute('data-option-cat');
    val = el.getAttribute('data-option-val');
    activeCat = el.getAttribute('data-active-cat');
    activeVal = el.getAttribute('data-active-val');
    option = el.getAttribute('data-option');
    if (option === 'line') {
      this.props.onAddOutline();
    }
    return this.props.onFilterOptionToggle({
      option: option,
      cat: cat,
      val: val,
      activeCat: activeCat,
      activeVal: activeVal
    });
  },
  render: function() {
    var query;
    return React.createElement("div", {
      "className": "controls-container clearfix closed mb-oxygen",
      "ref": "controlsContainer",
      "data-toggle": "tooltip",
      "data-placement": "top",
      "title": "Customise this chart!"
    }, React.createElement("a", {
      "onClick": this.onControlsOpen,
      "className": "controls-toggle-link",
      "ref": "controlsLink",
      "role": "button",
      "data-toggle": "collapse",
      "data-target": "#collapsePyramid",
      "aria-expanded": "false",
      "aria-controls": "collapsePyramid"
    }, React.createElement("img", {
      "src": "/images/mb_ajax_loader.gif",
      "className": (this.props.isFetching === true && this.props.isDefault === false ? 'mb-spinner-controls' : 'hide')
    }), React.createElement("div", {
      "className": (this.props.isFetching === true && this.props.isDefault === false ? 'hide' : void 0)
    }, React.createElement("span", {
      "className": (this.props.activeLineValue !== 'default' ? "col-sm-4 text-center mb-control-value" : "col-sm-11 text-center mb-control-value")
    }, "" + this.props.activeBarsValue, React.createElement("span", {
      "className": "mb-mini"
    }, " Bars")), (this.props.activeLineValue !== 'default' ? React.createElement("div", null, React.createElement("span", {
      "className": "col-sm-3 text-center mb-control-value"
    }, "compared to"), React.createElement("span", {
      "className": "col-sm-4 text-center mb-control-value"
    }, "" + this.props.activeLineValue, React.createElement("span", {
      "className": "mb-mini"
    }, " Line"))) : void 0), React.createElement("span", {
      "className": (this.props.isControlsOpen === true ? "glyphicon glyphicon-chevron-up mt-medium" : "glyphicon glyphicon-chevron-down mt-medium")
    }))), React.createElement("div", {
      "className": "collapse col-sm-12 mb-collapse",
      "id": "collapsePyramid"
    }, React.createElement("div", {
      "className": "container col-sm-12"
    }, React.createElement("ul", {
      "className": "nav nav-tabs mt-medium mb-controls-tabs"
    }, React.createElement("li", {
      "role": "presentation",
      "className": (this.props.filteringOption.option === 'bars' ? "active" : '')
    }, React.createElement("a", {
      "href": "#",
      "onClick": this.onToggleFilteringOption,
      "data-option": "bars",
      "data-option-cat": "_barsCategory",
      "data-option-val": "_barsValue",
      "data-active-cat": "activeBarsCategory",
      "data-active-val": "activeBarsValue"
    }, "Bars")), React.createElement("li", {
      "role": "presentation",
      "className": (this.props.filteringOption.option === 'line' ? "active" : '')
    }, React.createElement("a", {
      "href": "#",
      "onClick": this.onToggleFilteringOption,
      "data-option": "line",
      "data-option-cat": "_outlineCategory",
      "data-option-val": "_outlineValue",
      "data-active-cat": "activeLineCategory",
      "data-active-val": "activeLineValue"
    }, "+ Line"))), React.createElement("div", {
      "className": "form-group mt-medium row"
    }, React.createElement("label", {
      "className": "pr-medium"
    }, "Filter by"), React.createElement("div", {
      "className": "btn-group"
    }, ((function() {

      /*
      for category, i in @props.categories
         * unless category.value is @props.omitted_category
        <button 
          key={i} 
          type="button" 
          className={ if @props[@props.filteringOption.cat].value is category.value then "btn btn-default active" else "btn btn-default" }
          onClick={ @onCategoryChange }
          data-value={ category.value }
        >
        { category.label }
        </button>
       */
      return this.props.categories.map((function(_this) {
        return function(category, i) {
          return React.createElement("button", {
            "key": i,
            "type": "button",
            "className": (_this.props[_this.props.filteringOption.cat].value === category.value ? "btn btn-default active" : "btn btn-default"),
            "onClick": _this.onCategoryChange,
            "data-value": category.value
          }, category.label);
        };
      })(this));
    }).call(this)))), React.createElement("div", {
      "className": "form-group row"
    }, " ", (this.props[this.props.filteringOption.cat].value !== 'districts' && this.props[this.props.filteringOption.cat].value !== 'default' ? React.createElement("ul", {
      "className": "nav nav-pills pt-small pb-small pl-small"
    }, ((function() {

      /*
      for value, i in @props.values[@props[@props.filteringOption.cat].value]
        <li role="presentation" key={value.value}>
          <a
            data-value={ value.value }
            href="#" 
            className={ if @props[@props.filteringOption.val].label is value.label then "mb-pill active" else "mb-pill" }
            onClick={ @onValueChange }
          >
          { value.label }
          </a>
        </li>
       */
      return this.props.values[this.props[this.props.filteringOption.cat].value].map((function(_this) {
        return function(value, i) {
          return React.createElement("li", {
            "role": "presentation",
            "key": value.value
          }, React.createElement("a", {
            "data-value": value.value,
            "href": "#",
            "className": (_this.props[_this.props.filteringOption.val].label === value.label ? "mb-pill active" : "mb-pill"),
            "onClick": _this.onValueChange
          }, value.label));
        };
      })(this));
    }).call(this))) : this.props[this.props.filteringOption.cat].value === 'districts' ? React.createElement("div", null, React.createElement("div", {
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
    }, "What\'s my Local Authority District?"))) : void 0)), (this.props[this.props.filteringOption.cat].value === 'districts' ? React.createElement("div", {
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
              className={ if @props[@props.filteringOption.val].label is district.label then "mb-pill active" else "mb-pill" }
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
              "className": (_this.props[_this.props.filteringOption.val].label === district.label ? "mb-pill active" : "mb-pill"),
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

module.exports = PyramidControls;

//# sourceMappingURL=chart-controls-pyramid.map

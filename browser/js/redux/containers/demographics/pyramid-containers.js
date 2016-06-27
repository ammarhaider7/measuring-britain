// Generated by CoffeeScript 1.10.0
var Bars, Pyramid, PyramidComponent, Table, TableComponent, addFilter, connect, controlsClosed, controlsOpened, districtSearch, fetchPyramidData, firstLineDrawn, mapDispatchToProps, mapStateToProps, mapStateToPropsPyrBars, mapStateToPropsPyrTable, mouseOver, pyBarsComponent, ref, removeFilter, requestPyramidData, toggleCategory, toggleFilteringOption, toggleOutlineCategory, toggleOutlineValue, toggleValue;

connect = require('react-redux').connect;

ref = require('../../actions/demographics/pyramid-actions.js'), mouseOver = ref.mouseOver, toggleCategory = ref.toggleCategory, addFilter = ref.addFilter, toggleOutlineCategory = ref.toggleOutlineCategory, toggleValue = ref.toggleValue, removeFilter = ref.removeFilter, toggleOutlineValue = ref.toggleOutlineValue, requestPyramidData = ref.requestPyramidData, fetchPyramidData = ref.fetchPyramidData, districtSearch = ref.districtSearch, controlsOpened = ref.controlsOpened, controlsClosed = ref.controlsClosed, toggleFilteringOption = ref.toggleFilteringOption, firstLineDrawn = ref.firstLineDrawn;

PyramidComponent = require('../../../ui/demographics/pyramid-component.js');

TableComponent = require('../../../ui/demographics/pyramid-table.js');

pyBarsComponent = require('../../../ui/demographics/pyramid-bars.js');

mapStateToProps = function(state) {
  return {
    chartName: state.pyramidChart.chartName,
    _barsCategory: state.pyramidChart._barsCategory,
    _barsValue: state.pyramidChart._barsValue,
    activeBarsCategory: state.pyramidChart.activeBarsCategory,
    activeBarsValue: state.pyramidChart.activeBarsValue,
    activeLineCategory: state.pyramidChart.activeLineCategory,
    activeLineValue: state.pyramidChart.activeLineValue,
    data: state.pyramidChart.data,
    isFetching: state.pyramidChart.isFetching,
    district_query: state.pyramidChart.district_query,
    outlineFilter: state.pyramidChart.outlineFilter,
    _outlineCategory: state.pyramidChart._outlineCategory,
    _outlineValue: state.pyramidChart._outlineValue,
    error: state.pyramidChart.error,
    updatePyramid: state.pyramidChart.updatePyramid,
    isDefault: state.pyramidChart.isDefault,
    updateOutline: state.pyramidChart.updateOutline,
    filteringOption: state.pyramidChart.filteringOption,
    isControlsOpen: state.pyramidChart.isControlsOpen,
    isFirstLine: state.pyramidChart.isFirstLine
  };
};

mapStateToPropsPyrTable = function(state) {
  return {
    data: state.pyramidChart.data,
    activeBarsCategory: state.pyramidChart.activeBarsCategory,
    activeBarsValue: state.pyramidChart.activeBarsValue,
    isFetching: state.pyramidChart.isFetching,
    isDefault: state.pyramidChart.isDefault
  };
};

mapStateToPropsPyrBars = function(state) {
  return {
    _mouseOverData: state.pyramidChart._mouseOverData,
    updateBars: state.pyramidChart.updateBars,
    isFetching: state.pyramidChart.isFetching,
    isDefault: state.pyramidChart.isDefault,
    activeBarsCategory: state.pyramidChart.activeBarsCategory,
    activeBarsValue: state.pyramidChart.activeBarsValue
  };
};

mapDispatchToProps = function(dispatch) {
  return {
    onCategoryChange: function(category) {
      return dispatch(toggleCategory(category));
    },
    onValueChange: function(value) {
      return dispatch(toggleValue(value));
    },
    onAddOutline: function() {
      return dispatch(addFilter());
    },
    onRemoveFilter: function() {
      return dispatch(removeFilter());
    },
    onOutlineCategoryChange: function(category) {
      return dispatch(toggleOutlineCategory(category));
    },
    onOutlineValueChange: function(value) {
      return dispatch(toggleOutlineValue(value));
    },
    fetchPyramidData: function(filterOptions) {
      return dispatch(fetchPyramidData(filterOptions));
    },
    onMouseOver: function(mouseOverData) {
      return dispatch(mouseOver(mouseOverData));
    },
    onControlsClosed: function() {
      return dispatch(controlsClosed());
    },
    onControlsOpen: function() {
      return dispatch(controlsOpened());
    },
    onDistrictSearch: function(query) {
      return dispatch(districtSearch(query));
    },
    onFilterOptionToggle: function(option) {
      return dispatch(toggleFilteringOption(option));
    },
    onFirstLineDrawn: function() {
      return dispatch(firstLineDrawn());
    }
  };
};

Pyramid = connect(mapStateToProps, mapDispatchToProps)(PyramidComponent);

Table = connect(mapStateToPropsPyrTable)(TableComponent);

Bars = connect(mapStateToPropsPyrBars)(pyBarsComponent);

module.exports = {
  Pyramid: Pyramid,
  Table: Table,
  Bars: Bars
};

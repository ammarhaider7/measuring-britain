// Generated by CoffeeScript 1.10.0
var d3, parse;

d3 = require('d3');

parse = function(dataArray) {
  var d3ReadyData, d3_nested_data, last, nested_data, re, reLast, total_item, utils;
  total_item = dataArray.shift();
  window.sunBurstData = dataArray;
  re = /^\w+/;
  reLast = /\w+$/;
  last = function(str) {
    return str.substr(str.indexOf(':') + 2, str.length);
  };
  nested_data = d3.nest().key(function(d) {
    return d.c_ethpuk11.description.match(re)[0];
  }).key(function(d) {
    var ethnicity;
    ethnicity = d.c_ethpuk11.description;
    if (ethnicity.indexOf('English') !== -1) {
      return ethnicity.match(reLast);
    } else {
      return last(ethnicity);
    }
  }).rollup(function(values) {
    return d3.sum(values, function(d) {
      return d.obs_value.value;
    });
  }).entries(dataArray);
  utils = {
    getValues: function(array) {
      return array.map(function(ob) {
        return ob.obs_value.value;
      });
    },
    percArray: function(array, sum) {
      return array.map(function(num) {
        return num / sum * 100;
      });
    }
  };
  d3_nested_data = {
    key: "ethnic_diversity",
    values: nested_data
  };
  d3ReadyData = {
    d3_nested_data: d3_nested_data,
    total_item: total_item
  };
  return d3ReadyData;
};

module.exports = parse;

//# sourceMappingURL=ethnic-sunburst-parser.map

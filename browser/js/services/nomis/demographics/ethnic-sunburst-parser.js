// Generated by CoffeeScript 1.10.0
var d3, parse;

d3 = require('d3');

parse = function(dataArray) {
  var d3ReadyData, d3_nested_data, last, nested_data, re, reLast, sunBurstData, total_item, utils;
  sunBurstData = dataArray;
  total_item = dataArray.shift();
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
  nested_data.forEach(function(ob) {
    return ob.values.shift();
  });
  nested_data = nested_data.map(function(ob) {
    return {
      name: ob.key,
      size: total_item.obs_value.value,
      children: ob.values.map(function(ob) {
        return {
          name: ob.key,
          size: ob.values
        };
      })
    };
  });
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
    name: "ethnic_diversity",
    children: nested_data
  };
  d3ReadyData = {
    d3_nested_data: d3_nested_data,
    total_item: total_item
  };
  return d3ReadyData;
};

module.exports = parse;

// Generated by CoffeeScript 1.10.0
var d3, parse;

d3 = require('d3');

parse = function(dataArray) {
  var ages, ethnicities, ethnicity, getMaxValueFromArr, i, len, nested_data, percentages, sort_arr, sorted_ethnicities, sorted_percentages, sumDisability;
  sumDisability = function(arr, val) {
    return d3.sum(arr, function(d) {
      if (d.c_disability.value === val) {
        return d.obs_value.value;
      }
    });
  };
  nested_data = d3.nest().key(function(d) {
    return d.c_ethpuk11.description;
  }).key(function(d) {
    return d.c_age.description;
  }).rollup(function(values) {
    return {
      sum: d3.sum(values, function(d) {
        return d.obs_value.value;
      }),
      limited_a_lot: sumDisability(values, 1),
      limited_a_little: sumDisability(values, 2),
      not_limited: sumDisability(values, 3)
    };
  }).entries(dataArray);
  percentages = nested_data.map(function(ethnicity) {
    return {
      key: ethnicity.key,
      values: ethnicity.values.map(function(age) {
        return {
          key: age.key,
          ethnicity: ethnicity.key,
          values: {
            limited_a_lot: age.values.limited_a_lot / age.values.sum,
            limited_a_little: age.values.limited_a_little / age.values.sum,
            not_limited: age.values.not_limited / age.values.sum
          }
        };
      })
    };
  });
  getMaxValueFromArr = function(arr, value) {
    return d3.max(arr, function(d) {
      return d.values[value];
    });
  };
  sort_arr = [];
  for (i = 0, len = percentages.length; i < len; i++) {
    ethnicity = percentages[i];
    sort_arr.push({
      ethnicity: ethnicity.key,
      max_value: getMaxValueFromArr(ethnicity.values, 'limited_a_lot')
    });
  }
  sort_arr = sort_arr.sort(function(a, b) {
    return b.max_value - a.max_value;
  });
  sorted_ethnicities = sort_arr.map(function(ob) {
    return ob.ethnicity;
  });
  sorted_percentages = sorted_ethnicities.map(function(ob) {
    var j, len1;
    for (j = 0, len1 = percentages.length; j < len1; j++) {
      ethnicity = percentages[j];
      if (ob === ethnicity.key) {
        return ethnicity;
      }
    }
  });
  ethnicities = nested_data.map(function(ethnicity) {
    return ethnicity.key;
  });
  ages = nested_data[0].values.map(function(age) {
    return age.key;
  });
  return {
    ethnicities: ethnicities,
    sorted_ethnicities: sorted_ethnicities,
    percentages: percentages,
    nested_data: nested_data,
    ages: ages,
    sort_arr: sort_arr,
    sorted_percentages: sorted_percentages
  };
};

module.exports = parse;

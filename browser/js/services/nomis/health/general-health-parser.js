// Generated by CoffeeScript 1.10.0
var d3, parse;

d3 = require('d3');

parse = function(dataArray) {
  var ages, breakArrayIntoGroups, ethnicities, ethnicities_grouped, ethnicities_titles, ethnicity_age_detail, flatMaxPercsArray, getFilteredArrLength, max_perc, max_value, means, nested_by_age, nested_data, number_bad_health, percentages, sumHealth, total_age_detail, total_item, total_population;
  sumHealth = function(arr, health_value) {
    return d3.sum(arr, function(d) {
      if (d.c_health.value === health_value) {
        return d.obs_value.value;
      }
    });
  };
  getFilteredArrLength = function(arr, health_value) {
    return arr.filter(function(ob) {
      return ob.c_health.value === health_value;
    }).length;
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
      good: sumHealth(values, 1),
      fair: sumHealth(values, 2),
      bad: sumHealth(values, 3)
    };
  }).entries(dataArray);
  ethnicity_age_detail = d3.nest().key(function(d) {
    return d.c_ethpuk11.description;
  }).key(function(d) {
    return d.c_age.description;
  }).rollup(function(values) {
    return {
      total_population: d3.sum(values, function(d) {
        return d.obs_value.value;
      }),
      bad_health: sumHealth(values, 3)
    };
  }).entries(dataArray);
  total_population = d3.sum(dataArray, function(d) {
    return d.obs_value.value;
  });
  number_bad_health = sumHealth(dataArray, 3);
  total_age_detail = d3.nest().key(function(d) {
    return d.c_age.description;
  }).rollup(function(values) {
    return {
      total_population: d3.sum(values, function(d) {
        return d.obs_value.value;
      }),
      bad_health: sumHealth(values, 3)
    };
  }).entries(dataArray);
  total_item = {
    population: total_population,
    number_bad_health: number_bad_health,
    percent_bad_health: number_bad_health / total_population,
    total_age_detail: total_age_detail
  };
  percentages = nested_data.map(function(ethnicity) {
    return {
      key: ethnicity.key,
      values: ethnicity.values.map(function(age) {
        return {
          key: age.key,
          ethnicity: ethnicity.key,
          values: {
            good: age.values.good / age.values.sum,
            fair: age.values.fair / age.values.sum,
            bad: age.values.bad / age.values.sum
          }
        };
      })
    };
  });
  nested_by_age = d3.nest().key(function(d) {
    return d.c_age.description;
  }).rollup(function(values) {
    return {
      sum: d3.sum(values, function(d) {
        return d.obs_value.value;
      }),
      bad: sumHealth(values, 3)
    };
  }).entries(dataArray);
  means = {
    key: 'Mean',
    values: nested_by_age.map(function(ob) {
      return {
        key: ob.key,
        ethnicity: 'Mean',
        values: {
          bad: ob.values.bad / ob.values.sum
        }
      };
    })
  };
  flatMaxPercsArray = percentages.map(function(ethnicity) {
    return {
      max_bad_perc: d3.max(ethnicity.values, function(d) {
        return d.values.bad;
      })
    };
  });
  max_perc = d3.max(flatMaxPercsArray, function(d) {
    return d.max_bad_perc;
  });
  max_value = d3.max(dataArray, function(d) {
    return d.obs_value.value;
  });
  ethnicities = nested_data.map(function(ethnicity) {
    return ethnicity.key;
  });
  breakArrayIntoGroups = function(data, maxPerGroup) {
    var groups, i, numInGroupProcessed;
    numInGroupProcessed = 0;
    groups = [[]];
    i = 0;
    while (i < data.length) {
      groups[groups.length - 1].push(data[i]);
      ++numInGroupProcessed;
      if (numInGroupProcessed >= maxPerGroup && i !== data.length - 1) {
        groups.push([]);
        numInGroupProcessed = 0;
      }
      i++;
    }
    return groups;
  };
  ethnicities_titles = (function() {
    var arr;
    arr = ethnicities;
    arr.splice(0, 0, {
      title: 'White'
    });
    arr.splice(5, 0, {
      title: 'Mixed'
    });
    arr.splice(10, 0, {
      title: 'Asian'
    });
    arr.splice(16, 0, {
      title: 'Black'
    });
    arr.splice(20, 0, {
      title: 'Other'
    });
    return arr;
  })();
  ethnicities_grouped = breakArrayIntoGroups(ethnicities_titles, 8);
  ages = nested_data[0].values.map(function(age) {
    return age.key;
  });
  return {
    ethnicities: ethnicities,
    ethnicities_grouped: ethnicities_grouped,
    nested_data: nested_data,
    percentages: percentages,
    means: means,
    ethnicity_age_detail: ethnicity_age_detail,
    total_item: total_item,
    max_perc: max_perc,
    max_value: max_value,
    ages: ages
  };
};

module.exports = parse;

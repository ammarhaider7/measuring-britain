// Generated by CoffeeScript 1.10.0
var parse;

parse = function(dataArray) {
  var countries, employment_cats_concat, employment_cats_pretty, in_employment_cats, nested_data, out_employment_cats, percentages, sumEconCat, total_item_percs, total_item_values, total_sum;
  sumEconCat = function(arr, val) {
    return d3.sum(arr, function(d) {
      if (d.c_ecopuk11.value === val) {
        return d.obs_value.value;
      }
    });
  };
  total_sum = d3.sum(dataArray, function(d) {
    return d.obs_value.value;
  });
  total_item_values = d3.nest().key(function(d) {
    return d.c_ecopuk11.description;
  }).rollup(function(values) {
    return {
      sum: d3.sum(values, function(d) {
        return d.obs_value.value;
      })
    };
  }).entries(dataArray);
  total_item_percs = total_item_values.map(function(ob) {
    return {
      economic_activity: ob.key,
      perc: ob.values.sum / total_sum,
      value: ob.values.sum
    };
  });
  nested_data = d3.nest().key(function(d) {
    return d.c_cob.description;
  }).rollup(function(values) {
    return {
      sum: d3.sum(values, function(d) {
        return d.obs_value.value;
      }),
      in_work: {
        employee: sumEconCat(values, 3),
        self_employed: sumEconCat(values, 6)
      },
      out_of_work: {
        unemployed: sumEconCat(values, 11),
        retired: sumEconCat(values, 14),
        student: sumEconCat(values, 15),
        looking_after_home_family: sumEconCat(values, 16),
        long_term_sick_disabled: sumEconCat(values, 17),
        other: sumEconCat(values, 18)
      }
    };
  }).entries(dataArray);
  percentages = nested_data.map(function(country) {
    var in_work, in_work_employee, in_work_self_employed, out_of_work, out_of_work_longterm_sick_disabled, out_of_work_looking_after_home_family, out_of_work_other, out_of_work_retired, out_of_work_student, out_of_work_unemployed, sum, sum_in_work, sum_out_of_work;
    in_work = country.values.in_work;
    out_of_work = country.values.out_of_work;
    sum = country.values.sum;
    in_work_employee = in_work.employee;
    in_work_self_employed = in_work.self_employed;
    out_of_work_unemployed = out_of_work.unemployed;
    out_of_work_retired = out_of_work.retired;
    out_of_work_student = out_of_work.student;
    out_of_work_looking_after_home_family = out_of_work.looking_after_home_family;
    out_of_work_longterm_sick_disabled = out_of_work.long_term_sick_disabled;
    out_of_work_other = out_of_work.other;
    sum_in_work = in_work_employee + in_work_self_employed;
    sum_out_of_work = out_of_work_unemployed + out_of_work_retired + out_of_work_student + out_of_work_looking_after_home_family + out_of_work_longterm_sick_disabled + out_of_work_other;
    return {
      country: country.key,
      in_work: {
        employee: in_work_employee / sum,
        self_employed: in_work_self_employed / sum,
        sum_perc: sum_in_work / sum,
        sum: sum_in_work
      },
      out_of_work: {
        unemployed: out_of_work_unemployed / sum,
        retired: out_of_work_retired / sum,
        student: out_of_work_student / sum,
        looking_after_home_family: out_of_work_looking_after_home_family / sum,
        long_term_sick_disabled: out_of_work_longterm_sick_disabled / sum,
        other: out_of_work_other / sum,
        sum_perc: sum_out_of_work / sum,
        sum: sum_out_of_work
      }
    };
  });
  in_employment_cats = ['employee', 'self_employed'];
  out_employment_cats = ['unemployed', 'retired', 'student', 'other', 'looking_after_home_family', 'long_term_sick_disabled'];
  employment_cats_concat = in_employment_cats.concat(out_employment_cats);
  employment_cats_pretty = ['Employee', 'Self employed', 'Unemployed', 'Retired', 'Student', 'Other', 'Looking after home/family', 'Long-term sick/disabled'];
  percentages.forEach(function(d) {
    var y0;
    y0 = 0;
    d.in_work_categories = in_employment_cats.map(function(category) {
      return {
        country: d.country,
        sum_perc: d.in_work.sum_perc,
        name: category,
        sum: d.in_work.sum,
        value: d.in_work[category],
        y0: y0,
        y1: y0 += d.in_work[category]
      };
    });
  });
  percentages.forEach(function(d) {
    var y0;
    y0 = 0;
    d.out_of_work_categories = out_employment_cats.map(function(category) {
      return {
        country: d.country,
        sum_perc: d.out_of_work.sum_perc,
        sum: d.out_of_work.sum,
        name: category,
        value: d.out_of_work[category],
        y0: y0,
        y1: y0 += d.out_of_work[category]
      };
    });
  });
  percentages = percentages.sort(function(a, b) {
    var a_in_work, b_in_work;
    a_in_work = a.in_work.employee + a.in_work.self_employed;
    b_in_work = b.in_work.employee + b.in_work.self_employed;
    return b_in_work - a_in_work;
  });
  countries = percentages.map(function(country) {
    return country.country;
  });
  return {
    nested_data: nested_data,
    countries: countries,
    percentages: percentages,
    employment_cats_pretty: employment_cats_pretty,
    employment_cats_concat: employment_cats_concat,
    total_item_values: total_item_values,
    total_item_percs: total_item_percs
  };
};

module.exports = parse;

// Generated by CoffeeScript 1.10.0
var drawEconByCountryChart;

drawEconByCountryChart = function(options) {
  var activeCategory, activeValue, attachHoverHandlers, chart_height, chart_width, container, countries, d3_array, data, employment_cats, employment_cats_concat, format, height, in_work_colours, in_work_colours_domain, in_work_colours_range, isDefault, key, margin, my, onInitDone, onMouseOver, out_of_work_colours, out_of_work_colours_domains, out_of_work_range, percFormat, pointPercFormat, ref, ref1, trimCountryString, trimEmploymentStatus, width, x, xAxis, y, y0, yAxisBottom, yAxisTop;
  container = options.container, data = options.data, isDefault = options.isDefault, onMouseOver = options.onMouseOver, activeCategory = options.activeCategory, activeValue = options.activeValue, onInitDone = options.onInitDone;
  my = {};
  width = (ref = $(container).width()) != null ? ref : 800;
  height = (ref1 = $(container).height()) != null ? ref1 : 550;
  margin = {
    top: 35,
    right: 20,
    bottom: 10,
    left: 40,
    p: 25,
    label: 60,
    tooltip_height: 42
  };
  chart_width = width - margin.left - margin.right;
  chart_height = height - margin.top - margin.bottom;
  format = d3.format('.2s');
  percFormat = d3.format(',.0%');
  pointPercFormat = d3.format(',.2%');
  d3_array = data.percentages;
  countries = data.countries;
  employment_cats = data.employment_cats_pretty;
  employment_cats_concat = data.employment_cats_concat;
  key = function(d) {
    return d.country;
  };
  in_work_colours_domain = ["employee", "self_employed"];
  in_work_colours_range = ['#74c476', '#98df8a'];
  in_work_colours = d3.scale.ordinal().domain(in_work_colours_domain).range(in_work_colours_range);
  out_of_work_colours_domains = ["unemployed", "retired", "student", "other", "looking_after_home_family", "long_term_sick_disabled"];
  out_of_work_range = ['#C54E58', '#D6616B', '#B33742', '#E47982', '#F38F97', '#FDABB1'];
  out_of_work_colours = d3.scale.ordinal().domain(out_of_work_colours_domains).range(out_of_work_range);
  trimEmploymentStatus = function(str) {
    switch (str) {
      case 'employee':
        return 'Employee';
      case 'self_employed':
        return 'Self employed';
      case 'unemployed':
        return 'Unemployed';
      case 'retired':
        return 'Retired';
      case 'student':
        return 'Student';
      case 'employee':
        return 'Employee';
      case 'other':
        return 'Other';
      case 'looking_after_home_family':
        return 'Looking after home/family';
      case 'long_term_sick_disabled':
        return 'Long-term sick/disabled';
    }
  };
  trimCountryString = function(str) {
    if (str.indexOf('Antarctica') > -1) {
      return 'Oceanian';
    } else if (str.indexOf('EU countries') > -1) {
      return 'EU';
    } else if (str.indexOf('Africa') > -1) {
      return 'African';
    } else if (str.indexOf('Rest of Europe') > -1) {
      return 'Non-EU';
    } else if (str.indexOf('United Kingdom') > -1) {
      return 'UK';
    } else if (str.indexOf('Americas') > -1) {
      return 'Americas';
    } else if (str.indexOf('Middle') > -1) {
      return 'Asian';
    }
  };
  x = d3.scale.ordinal().domain(countries).rangeRoundBands([0, chart_width], 0.3);
  y = d3.scale.linear().domain([0, 1]).range([0.5 * chart_height, 0]);
  y0 = d3.scale.linear().domain([0, 1]).range([0, 0.5 * chart_height]);
  xAxis = d3.svg.axis().scale(x).orient('bottom');
  yAxisTop = d3.svg.axis().scale(y).ticks(5).tickSize(-chart_width).tickFormat(percFormat).orient('left');
  yAxisBottom = d3.svg.axis().scale(y0).ticks(5).tickSize(-chart_width).tickFormat(percFormat).orient('left');
  my.init = function() {
    var bottom_countries, bottom_rect_group, legend_group, main_bottom_group, main_top_group, svg, title_group, tooltip_group_bottom, tooltip_group_top, top_countries, top_rect_group, x_axis_divider_group, x_axis_group, y_axis_bottom_group, y_axis_top_group;
    svg = d3.select('.econ-country-svg');
    main_top_group = svg.select('.main-group-top');
    main_bottom_group = svg.select('.main-group-bottom');
    x_axis_group = svg.select('.x.axis');
    y_axis_top_group = svg.select('.y.y-top.axis');
    y_axis_bottom_group = svg.select('.y.y-bottom.axis');
    title_group = svg.select('.title-group');
    legend_group = svg.select('.legend-group');
    x_axis_divider_group = svg.select('.x-axis-divider');
    top_rect_group = svg.select('.top-group-rect');
    bottom_rect_group = svg.select('.bottom-group-rect');
    main_top_group.attr('transform', "translate(" + margin.left + ", " + margin.top + ")");
    main_bottom_group.attr('transform', "translate(" + margin.left + ", " + ((chart_height / 2) + margin.top) + ")");
    x_axis_group.attr('transform', "translate(" + margin.left + ", " + ((chart_height / 2) + margin.top) + ")");
    x_axis_divider_group.attr('transform', "translate(" + margin.left + ", " + ((chart_height / 2) + margin.top) + ")");
    top_rect_group.attr('transform', "translate(" + margin.left + ", " + margin.top + ")");
    y_axis_top_group.attr('transform', "translate(" + margin.left + ", " + margin.top + ")");
    y_axis_bottom_group.attr('transform', "translate(" + margin.left + ", " + ((chart_height / 2) + margin.top) + ")");
    bottom_rect_group.attr('transform', "translate(" + margin.left + ", " + ((chart_height / 2) + margin.top) + ")");
    title_group.attr('transform', "translate(" + (chart_width / 2 + margin.left) + ", 0)");
    legend_group.attr('transform', "translate(" + (chart_width - margin.p) + ", " + margin.top + ")");
    top_rect_group.append('rect').attr({
      width: chart_width,
      x: 0,
      height: 0.5 * chart_height,
      fill: 'rgba(152, 223, 138, 0.47)',
      opacity: 0
    }).transition().duration(1500).attr('opacity', 0.3);
    main_top_group.append('text').attr({
      x: chart_width * 0.5,
      y: margin.label,
      "class": 'in-work-label',
      opacity: 0
    }).text('In work').transition().duration(1500).attr('opacity', 0.5);
    bottom_rect_group.append('rect').attr({
      width: chart_width,
      x: 0,
      height: 0.5 * chart_height,
      fill: '#FFCFCF',
      opacity: 0
    }).transition().duration(1500).attr('opacity', 0.3);
    main_bottom_group.append('text').attr({
      x: chart_width * 0.5,
      y: chart_height * 0.5 - margin.label,
      "class": 'out-of-work-label',
      opacity: 0
    }).text('Not in work').transition().duration(1500).attr('opacity', 0.5);
    x_axis_group.transition().duration(1500).call(xAxis);
    y_axis_top_group.transition().duration(1500).call(yAxisTop);
    y_axis_top_group.append("text").attr("transform", "rotate(-90)").attr("y", 6).attr("dy", ".71em").style("text-anchor", "end").text("% of Population");
    y_axis_bottom_group.transition().duration(1500).call(yAxisBottom);
    top_countries = main_top_group.selectAll('.country-g').data(d3_array, key).enter().append('g').attr('transform', function(d) {
      return "translate(" + (x(d.country)) + ", 0)";
    }).attr('class', 'country-g');
    bottom_countries = main_bottom_group.selectAll('.country-g').data(d3_array, key).enter().append('g').attr('transform', function(d) {
      return "translate(" + (x(d.country)) + ", 0)";
    }).attr('class', 'country-g');
    top_countries.selectAll('rect').data(function(d) {
      return d.in_work_categories;
    }).enter().append('rect').attr({
      width: x.rangeBand(),
      y: chart_height * 0.5,
      height: 0,
      fill: function(d) {
        return in_work_colours(d.name);
      },
      "class": 'rect'
    }).transition().duration(1500).attr({
      y: function(d) {
        return y(d.y1);
      },
      height: function(d) {
        return (y(d.y0)) - (y(d.y1));
      }
    });
    bottom_countries.selectAll('rect').data(function(d) {
      return d.out_of_work_categories;
    }).enter().append('rect').attr({
      width: x.rangeBand(),
      y: 0,
      height: 0,
      fill: function(d) {
        return out_of_work_colours(d.name);
      },
      "class": 'rect'
    }).transition().duration(1500).attr({
      y: function(d) {
        return y0(d.y0);
      },
      height: function(d) {
        return (y0(d.y1)) - (y0(d.y0));
      }
    });
    top_countries.append('text').text(function(d) {
      return trimCountryString(d.country);
    }).attr({
      transform: function(d) {
        return "translate(" + (0.5 * x.rangeBand()) + ", " + (y(d.in_work.sum_perc) - 5) + ")";
      },
      'font-size': '100%',
      'font-weight': 'bold',
      'text-anchor': 'middle',
      "class": 'country-label',
      opacity: 0
    }).transition().duration(1500).attr('opacity', 1);
    tooltip_group_top = main_top_group.append('g').attr('class', 'tooltip-group top').attr('opacity', 0);
    tooltip_group_bottom = main_bottom_group.append('g').attr('class', 'tooltip-group bottom').attr('transform', "translate(0, " + (chart_width * 0.5) + ")").attr('opacity', 0);
    tooltip_group_top.append('rect').attr({
      "class": 'tooltip-bg top',
      width: x.rangeBand() + margin.p,
      height: margin.tooltip_height,
      fill: '#333',
      x: -10,
      y: 0,
      opacity: 0.7,
      rx: 6
    });
    tooltip_group_top.append('text').attr({
      "class": 'mb-tooltip top',
      x: x.rangeBand() * 0.5,
      dy: '.35em',
      y: margin.p + 5,
      fill: '#FF8C00',
      opacity: 1,
      'font-size': '85%',
      'font-weight': 'bold',
      'text-anchor': 'middle'
    }).text('');
    tooltip_group_top.append('text').attr({
      "class": 'mb-tooltip-country top',
      x: x.rangeBand() * 0.5,
      dy: '.35em',
      y: 10,
      fill: '#fff',
      opacity: 1,
      'font-size': '85%',
      'font-weight': 'bold',
      'text-anchor': 'middle'
    }).text('');
    tooltip_group_bottom.append('rect').attr({
      "class": 'tooltip-bg bottom',
      width: x.rangeBand() + margin.p * 3,
      height: margin.tooltip_height,
      fill: '#333',
      x: -margin.p * 1.5,
      y: 0,
      opacity: 0.7,
      rx: 6
    });
    tooltip_group_bottom.append('text').attr({
      "class": 'mb-tooltip bottom',
      x: x.rangeBand() * 0.5,
      dy: '.35em',
      y: margin.p + 5,
      fill: '#FF8C00',
      opacity: 1,
      'font-size': '85%',
      'font-weight': 'bold',
      'text-anchor': 'middle'
    }).text('');
    tooltip_group_bottom.append('text').attr({
      "class": 'mb-tooltip-country top',
      x: x.rangeBand() * 0.5,
      dy: '.35em',
      y: 10,
      fill: '#fff',
      opacity: 1,
      'font-size': '85%',
      'font-weight': 'bold',
      'text-anchor': 'middle'
    }).text('');
    x_axis_divider_group.append('line').attr({
      stroke: 'black',
      'stroke-width': 1,
      x1: 0,
      x2: chart_width,
      y1: 0,
      y2: 0,
      opacity: 0
    }).transition().duration(1500).attr('opacity', 1);
    return attachHoverHandlers();
  };
  my.update = function() {
    var bottom_countries, main_bottom_group, main_top_group, svg, top_countries;
    svg = d3.select('.econ-country-svg');
    main_top_group = svg.select('.main-group-top');
    main_bottom_group = svg.select('.main-group-bottom');
    top_countries = main_top_group.selectAll('.country-g').data(d3_array, key);
    top_countries.selectAll('.country-label').data(d3_array, key).transition().duration(1000).attr('transform', function(d) {
      return "translate(" + (0.5 * x.rangeBand()) + ", " + (y(d.in_work.sum_perc) - 5) + ")";
    });
    top_countries.transition().duration(1000).attr('transform', function(d) {
      return "translate(" + (x(d.country)) + ", 0)";
    });
    bottom_countries = main_bottom_group.selectAll('.country-g').data(d3_array, key);
    bottom_countries.transition().duration(1000).attr('transform', function(d) {
      return "translate(" + (x(d.country)) + ", 0)";
    });
    top_countries.selectAll('.rect').data(function(d) {
      return d.in_work_categories;
    }).transition().duration(1000).attr({
      y: function(d) {
        return y(d.y1);
      },
      height: function(d) {
        return (y(d.y0)) - (y(d.y1));
      }
    });
    bottom_countries.selectAll('.rect').data(function(d) {
      return d.out_of_work_categories;
    }).transition().duration(1000).attr({
      y: function(d) {
        return y0(d.y0);
      },
      height: function(d) {
        return (y0(d.y1)) - (y0(d.y0));
      }
    });
    return attachHoverHandlers();
  };
  my.resize = function() {
    var bottom_countries, bottom_rect_group, main_bottom_group, main_top_group, svg, top_countries, top_rect_group, x_axis_divider_group, y_axis_bottom_group, y_axis_top_group;
    svg = d3.select('.econ-country-svg');
    main_top_group = svg.select('.main-group-top');
    main_bottom_group = svg.select('.main-group-bottom');
    top_rect_group = svg.select('.top-group-rect');
    bottom_rect_group = svg.select('.bottom-group-rect');
    top_countries = main_top_group.selectAll('.country-g');
    bottom_countries = main_bottom_group.selectAll('.country-g');
    y_axis_top_group = svg.select('.y.y-top.axis');
    y_axis_bottom_group = svg.select('.y.y-bottom.axis');
    x_axis_divider_group = svg.select('.x-axis-divider');
    top_rect_group.select('rect').attr({
      width: chart_width
    });
    main_top_group.select('text').attr({
      x: chart_width * 0.5
    });
    bottom_rect_group.select('rect').attr({
      width: chart_width
    });
    main_bottom_group.select('text').attr({
      x: chart_width * 0.5,
      y: chart_height * 0.5 - margin.label
    });
    top_countries.selectAll('rect').attr({
      width: x.rangeBand()
    });
    top_countries.selectAll('.country-label').attr('transform', function(d) {
      return "translate(" + (0.5 * x.rangeBand()) + ", " + (y(d.in_work.sum_perc) - 5) + ")";
    });
    top_countries.attr('transform', function(d) {
      return "translate(" + (x(d.country)) + ", 0)";
    });
    bottom_countries.attr('transform', function(d) {
      return "translate(" + (x(d.country)) + ", 0)";
    });
    bottom_countries.selectAll('rect').attr({
      width: x.rangeBand()
    });
    y_axis_top_group.call(yAxisTop);
    y_axis_bottom_group.call(yAxisBottom);
    x_axis_divider_group.select('line').attr({
      x2: chart_width
    });
    return attachHoverHandlers();
  };
  attachHoverHandlers = function() {
    var bottom_rects, hover_colour, main_bottom_group, main_top_group, rect_opacity, svg, top_rects;
    hover_colour = '#ddd';
    rect_opacity = 0.7;
    svg = d3.select('.econ-country-svg');
    countries = svg.selectAll('.country-g');
    main_top_group = svg.select('.main-group-top');
    main_bottom_group = svg.select('.main-group-bottom');
    top_rects = main_top_group.selectAll('.rect');
    bottom_rects = main_bottom_group.selectAll('.rect');
    top_rects.on('mouseover', function(d) {
      var $this, _d, tooltip_group;
      _d = d;
      $this = d3.select(this);
      $this.attr('fill', hover_colour);
      tooltip_group = main_top_group.select('.tooltip-group').attr('transform', "translate(" + (x(_d.country)) + "," + (y(_d.sum_perc) - (margin.tooltip_height + margin.p)) + ")");
      tooltip_group.attr('opacity', 1);
      tooltip_group.select('.mb-tooltip').text((percFormat(_d.value)) + " - " + (format(_d.value * _d.sum)));
      return tooltip_group.select('.mb-tooltip-country').text(trimEmploymentStatus(_d.name));
    }).on('mouseout', function(d) {
      var $this, tooltip_group;
      $this = d3.select(this);
      $this.attr('fill', function(d) {
        return in_work_colours(d.name);
      });
      tooltip_group = main_top_group.select('.tooltip-group');
      return tooltip_group.attr('opacity', 0);
    });
    return bottom_rects.on('mouseover', function(d) {
      var $this, _d, tooltip_group;
      _d = d;
      $this = d3.select(this);
      $this.attr('fill', hover_colour);
      tooltip_group = main_bottom_group.select('.tooltip-group').attr('transform', "translate(" + (x(d.country) - 3) + "," + (y0(_d.sum_perc) + margin.p * 0.5) + ")").attr('opacity', 1);
      tooltip_group.select('.mb-tooltip').text((percFormat(_d.value)) + " - " + (format(_d.value * _d.sum)));
      return tooltip_group.select('.mb-tooltip-country').text(trimEmploymentStatus(_d.name));
    }).on('mouseout', function(d) {
      var $this, tooltip_group;
      $this = d3.select(this);
      $this.attr('fill', function(d) {
        return out_of_work_colours(d.name);
      });
      tooltip_group = main_bottom_group.select('.tooltip-group');
      return tooltip_group.attr('opacity', 0);
    });
  };
  my.width = function(value) {
    if (!arguments.length) {
      return width;
    }
    width = value;
    return my;
  };
  my.height = function(value) {
    if (!arguments.length) {
      return height;
    }
    height = value;
    return my;
  };
  return my;
};

module.exports = drawEconByCountryChart;

//# sourceMappingURL=econ-activity-country-chart.map

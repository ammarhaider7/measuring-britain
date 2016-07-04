// Generated by CoffeeScript 1.10.0
var $, d3, drawDisabilityChart;

d3 = require('d3');

$ = require('jquery');

drawDisabilityChart = function(options) {
  var activeCategory, activeValue, ages, attachHoverHandlers, chart_height, chart_width, colour, container, d3_array, data, ethnicities, format, height, isDefault, margin, my, onInitDone, onMouseOver, percFormat, pointPercFormat, ref, ref1, trimEthnicity, width, x0, x1, xAxis, y, yAxis;
  container = options.container, data = options.data, isDefault = options.isDefault, onMouseOver = options.onMouseOver, activeCategory = options.activeCategory, activeValue = options.activeValue, onInitDone = options.onInitDone;
  my = {};
  width = (ref = $(container).width()) != null ? ref : 1140;
  height = (ref1 = $(container).height()) != null ? ref1 : 550;
  margin = {
    top: 35,
    right: 20,
    bottom: 45,
    left: 40,
    p: 25
  };
  chart_width = width - margin.left - margin.right;
  chart_height = height - margin.top - margin.bottom;
  format = d3.format('.2s');
  percFormat = d3.format(',.0%');
  pointPercFormat = d3.format(',.2%');
  d3_array = data.sorted_percentages;
  ethnicities = data.sorted_ethnicities;
  ages = data.ages;
  colour = d3.scale.ordinal().range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c"]).domain(ages);
  x0 = d3.scale.ordinal().domain(ethnicities).rangeRoundBands([0, chart_width], 0.05);
  x1 = d3.scale.ordinal().domain(ages).rangeRoundBands([0, x0.rangeBand()]);
  y = d3.scale.linear().domain([0, 0.55]).range([chart_height, 0]);
  xAxis = d3.svg.axis().scale(x0).orient('bottom');
  yAxis = d3.svg.axis().scale(y).tickSize(-chart_width).tickFormat(percFormat).orient('left');
  trimEthnicity = function(ethnicity_string) {
    var str, trimmedStr;
    if (ethnicity_string.indexOf('Gypsy') !== -1) {
      trimmedStr = 'Gypsy';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('White and Black Caribbean') !== -1) {
      trimmedStr = 'White/Carribean';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('White and Black African') !== -1) {
      trimmedStr = 'White/African';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('English') !== -1) {
      trimmedStr = 'British';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('Any other') !== -1) {
      trimmedStr = 'Any other';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('Arab') !== -1) {
      trimmedStr = 'Arab';
      return trimmedStr;
    } else if (ethnicity_string.indexOf('and') !== -1) {
      str = ethnicity_string.replace(' and ', '/');
      trimmedStr = str.substr(str.indexOf(':') + 2, str.length);
      return trimmedStr;
    } else {
      str = ethnicity_string;
      trimmedStr = str.substr(str.indexOf(':') + 2, str.length);
      return trimmedStr;
    }
  };
  xAxis.tickFormat(trimEthnicity);
  my.init = function() {
    var ethnicity, legend, legend_group, main_group, svg, ticks, title_group, tooltip, tooltip_age, tooltip_groups, x_axis_group, y_axis_group;
    svg = d3.select('.disability-svg');
    main_group = svg.select('.main-group');
    x_axis_group = svg.select('.x.axis');
    y_axis_group = svg.select('.y.axis');
    title_group = svg.select('.title-group');
    legend_group = svg.select('.legend-group');
    main_group.attr('transform', "translate(" + margin.left + ", " + margin.top + ")");
    x_axis_group.attr('transform', "translate(" + margin.left + ", " + (chart_height + margin.top) + ")");
    y_axis_group.attr('transform', "translate(" + margin.left + ", " + margin.top + ")");
    title_group.attr('transform', "translate(" + (chart_width / 2 + margin.left) + ", 0)");
    legend_group.attr('transform', "translate(" + (chart_width - margin.p) + ", " + margin.top + ")");
    x_axis_group.call(xAxis);
    y_axis_group.call(yAxis).append("text").attr("transform", "rotate(-90)").attr("y", 6).attr("dy", ".71em").style("text-anchor", "end").text("% of Population");
    ethnicity = main_group.selectAll('.ethnicity').data(d3_array).enter().append('g').attr({
      "class": 'ethnicity',
      transform: function(d) {
        return "translate(" + (x0(d.key)) + ", 0)";
      }
    });
    ethnicity.selectAll('rect').data(function(d) {
      return d.values;
    }).enter().append('rect').attr({
      width: x1.rangeBand(),
      x: function(d) {
        return x1(d.key);
      },
      y: chart_height,
      height: 0,
      rx: 3,
      fill: function(d) {
        return colour(d.key);
      },
      "class": 'rect'
    }).transition().duration(1500).attr({
      y: function(d) {
        return y(d.values.limited_a_lot);
      },
      height: function(d) {
        return chart_height - y(d.values.limited_a_lot);
      }
    });
    tooltip_groups = ethnicity.append('g').attr('class', 'tooltip-group');
    tooltip_groups.append('rect').attr({
      "class": 'tooltip-bg',
      width: x0.rangeBand() + margin.p + 5,
      height: '42px',
      fill: '#333',
      x: -10,
      y: y(0.3),
      opacity: 0,
      rx: 6
    });
    tooltip = tooltip_groups.append('text').attr({
      "class": 'mb-tooltip',
      transform: function(d) {
        return "translate(" + (x0.rangeBand() / 2) + ", " + (y(0.3)) + ")";
      },
      x: 5,
      dy: '.35em',
      y: margin.p + 5,
      fill: '#FF8C00',
      opacity: 0,
      'font-size': '75%',
      'font-weight': 'bold',
      'text-anchor': 'middle'
    }).text('');
    tooltip_age = tooltip_groups.append('text').attr({
      "class": 'mb-tooltip-age',
      transform: function(d) {
        return "translate(" + (x0.rangeBand() / 2) + ", " + (y(0.3)) + ")";
      },
      x: 5,
      dy: '.35em',
      y: margin.p / 2,
      fill: '#FFF',
      opacity: 0,
      'font-size': '75%',
      'font-weight': 'bold',
      'text-anchor': 'middle'
    }).text('');
    legend = legend_group.selectAll('.legend').data(ages).enter().append('g').attr({
      "class": 'legend',
      transform: function(d, i) {
        return "translate(0, " + (i * 20) + ")";
      }
    });
    legend.append('rect').attr({
      rx: 3,
      x: 18,
      width: 18,
      height: 18,
      fill: function(d) {
        return colour(d);
      }
    });
    legend.append('text').attr({
      "class": 'legend-text',
      x: 0,
      y: 9,
      dy: '0.35em',
      'text-anchor': 'end'
    }).text(function(d) {
      return d;
    });
    title_group.append('text').attr({
      x: 0,
      y: margin.p,
      opacity: 0,
      'font-size': '12px'
    }).style("text-anchor", "middle").text('Long-term illness / disability by ethinicity and age group').transition().duration(1500).attr('opacity', 1);
    ticks = svg.selectAll('.x .tick');
    ticks.each(function(d, i) {
      var $this;
      if (i % 2 === 0) {
        $this = d3.select(this);
        $this.select('text').attr('y', margin.p);
        return $this.select('line').attr('y2', 15);
      }
    });
    return attachHoverHandlers();
  };
  my.update = function() {
    var groups, svg;
    svg = d3.select('.disability-svg');
    groups = svg.selectAll('.ethnicity');
    groups.data(d3_array);
    groups.selectAll('rect').data(function(d) {
      return d.values;
    }).transition().duration(1000).delay(500).attr({
      y: function(d) {
        return y(d.values.limited_a_lot);
      },
      height: function(d) {
        return chart_height - y(d.values.limited_a_lot);
      }
    });
    return attachHoverHandlers();
  };
  my.resize = function() {
    var groups, legend_group, svg, ticks, title_group, tooltip_groups, x_axis_group, y_axis_group;
    svg = d3.select('.disability-svg');
    groups = svg.selectAll('.ethnicity');
    x_axis_group = svg.select('.x.axis');
    y_axis_group = svg.select('.y.axis');
    title_group = svg.select('.title-group');
    legend_group = svg.select('.legend-group');
    ticks = svg.selectAll('.x .tick');
    title_group.attr('transform', "translate(" + (chart_width / 2 + margin.left) + ", 0)");
    legend_group.attr('transform', "translate(" + (chart_width - margin.p) + ", " + margin.top + ")");
    groups.attr({
      transform: function(d) {
        return "translate(" + (x0(d.key)) + ", 0)";
      }
    });
    groups.selectAll('rect').attr({
      width: x1.rangeBand(),
      x: function(d) {
        return x1(d.key);
      }
    });
    x_axis_group.call(xAxis);
    y_axis_group.call(yAxis);
    ticks.each(function(d, i) {
      var $this;
      if (i % 2 === 0) {
        $this = d3.select(this);
        $this.select('text').attr('y', margin.p);
        return $this.select('line').attr('y2', 15);
      }
    });
    tooltip_groups = groups.select('.tooltip-group');
    tooltip_groups.select('rect').attr({
      width: x0.rangeBand() + margin.p + 5,
      y: y(0.3)
    });
    return tooltip_groups.selectAll('text').attr({
      transform: function(d) {
        return "translate(" + (x0.rangeBand() / 2) + ", " + (y(0.3)) + ")";
      }
    });
  };
  attachHoverHandlers = function() {
    var rects, svg;
    svg = d3.select('.disability-svg');
    rects = svg.selectAll('.rect');
    return rects.on('mouseover', function(d) {
      var $raw_rect_el, _g, _rect, raw_g_el, tooltip, tooltip_age, tooltip_bg, tooltip_group;
      _rect = d3.select(this);
      $raw_rect_el = $(_rect[0]);
      raw_g_el = $raw_rect_el.parent()[0];
      _g = d3.select(raw_g_el);
      tooltip_group = _g.select('.tooltip-group');
      tooltip_bg = tooltip_group.select('.tooltip-bg');
      tooltip = _g.select('.mb-tooltip');
      tooltip_age = _g.select('.mb-tooltip-age');
      _rect.attr('opacity', 0.7);
      tooltip_bg.attr('opacity', 0.8);
      tooltip_age.attr('opacity', 1).text(d.key);
      return tooltip.attr('opacity', 1).text(percFormat(d.values.limited_a_lot));
    }).on('mouseout', function(d) {
      var $raw_rect_el, _g, _rect, raw_g_el, tooltip, tooltip_age, tooltip_bg, tooltip_group;
      _rect = d3.select(this);
      $raw_rect_el = $(_rect[0]);
      raw_g_el = $raw_rect_el.parent()[0];
      _g = d3.select(raw_g_el);
      tooltip_group = _g.select('.tooltip-group');
      tooltip_bg = tooltip_group.select('.tooltip-bg');
      tooltip_age = _g.select('.mb-tooltip-age');
      tooltip = _g.select('.mb-tooltip');
      _rect.attr('opacity', 1);
      tooltip_bg.attr('opacity', 0);
      tooltip_age.attr('opacity', 0);
      return tooltip.attr('opacity', 0);
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

module.exports = drawDisabilityChart;

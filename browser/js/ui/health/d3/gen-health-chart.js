// Generated by CoffeeScript 1.10.0
var $, d3, drawGenHealthChart, wrap;

d3 = require('d3');

$ = require('jquery');

wrap = require('../../d3-helpers/text-wrap.js');

drawGenHealthChart = function(options) {
  var activeCategory, activeValue, ages, attachHoverHandlers, chart_height, chart_width, colour, container, d3_array, data, ethnic_groups, format, height, highlights, isDefault, line, margin, max_perc, max_value, means, my, onInitDone, onMouseOver, percFormat, pointPercFormat, ref, ref1, updateHighlights, width, x, xAxis, y, yAxis;
  container = options.container, data = options.data, isDefault = options.isDefault, onMouseOver = options.onMouseOver, activeCategory = options.activeCategory, activeValue = options.activeValue, onInitDone = options.onInitDone, highlights = options.highlights, updateHighlights = options.updateHighlights;
  my = {};
  width = (ref = $(container).width()) != null ? ref : 750;
  height = (ref1 = $(container).height()) != null ? ref1 : 500;
  margin = {
    top: 30,
    right: 85,
    bottom: 20,
    left: 45,
    p: 25
  };
  chart_width = width - margin.left - margin.right;
  chart_height = height - margin.top - margin.bottom;
  format = d3.format('.2s');
  percFormat = d3.format(',.0%');
  pointPercFormat = d3.format(',.2%');
  means = data.means;
  data.percentages.push(means);
  d3_array = data.percentages;
  ethnic_groups = data.ethnicities;
  ages = data.ages;
  max_value = data.max_value;
  max_perc = data.max_perc;
  colour = d3.scale.category20().domain(ethnic_groups);
  x = d3.scale.ordinal().domain(ages).rangePoints([0, chart_width]);
  y = d3.scale.linear().domain([0, max_perc]).range([chart_height, 0]);
  yAxis = d3.svg.axis().scale(y).tickFormat(percFormat).ticks(10).tickSize(-chart_width).orient('left');
  xAxis = d3.svg.axis().scale(x).tickSize(-chart_height).orient('bottom');
  line = d3.svg.line().interpolate('cardinal').x(function(d) {
    return x(d.key);
  }).y(function(d) {
    return y(d.values.bad);
  });
  my.init = function() {
    var circles, ethnicity, labels, lines, main_group, point_labels, points, svg, title_group, x_axis_group, y_axis_group;
    svg = d3.select('.gen-health-svg');
    main_group = svg.select('.main-group');
    x_axis_group = svg.select('.x.axis');
    y_axis_group = svg.select('.y.axis');
    title_group = svg.select('.title-group');
    main_group.attr('transform', "translate(" + margin.left + ", " + margin.top + ")");
    x_axis_group.attr('transform', "translate(" + margin.left + ", " + (chart_height + margin.top) + ")");
    y_axis_group.attr('transform', "translate(" + margin.left + ", " + margin.top + ")");
    title_group.attr('transform', "translate(" + (chart_width / 3 - margin.left) + ", 0)");
    x_axis_group.call(xAxis);
    y_axis_group.call(yAxis).append("text").attr("transform", "rotate(-90)").attr("y", 6).attr("dy", ".71em").style("text-anchor", "end").text("% of Population");
    ethnicity = main_group.selectAll('.ethnicity').data(d3_array).enter().append('g').attr('class', 'ethnicity');
    lines = ethnicity.append('path').attr({
      "class": function(d) {
        if (d.key === 'Mean') {
          return 'means line';
        } else {
          return 'line';
        }
      },
      d: function(d) {
        return line(d.values);
      },
      opacity: 1
    }).style('stroke', function(d) {
      if (d.key === 'Mean') {
        return '#F44336';
      }
      return colour(d.key);
    });
    points = ethnicity.append('g').attr('class', 'point').attr('opacity', 0);
    circles = points.selectAll('circle').data(function(d) {
      return d.values;
    }).enter().append('circle').attr({
      "class": 'circle',
      cx: function(d) {
        return x(d.key);
      },
      cy: function(d) {
        return y(d.values.bad);
      },
      r: 3,
      fill: 'white',
      stroke: function(d) {
        if (d.ethnicity === 'Mean') {
          return '#F44336';
        }
        return colour(d.ethnicity);
      }
    });
    point_labels = points.selectAll('text').data(function(d) {
      return d.values;
    }).enter().append('text').attr({
      "class": 'point-label',
      transform: function(d) {
        return "translate(" + (x(d.key)) + ", " + (y(d.values.bad)) + ")";
      },
      y: -10,
      dy: '.35em',
      'text-anchor': 'middle',
      'font-weight': 'bold',
      fill: function(d) {
        if (d.ethnicity === 'Mean') {
          return '#F44336';
        }
        return colour(d.ethnicity);
      }
    }).text(function(d) {
      return pointPercFormat(d.values.bad);
    });
    labels = ethnicity.append('text').attr({
      "class": 'label',
      transform: function(d) {
        return "translate(" + (x(d.values[d.values.length - 1].key)) + ", " + (y(d.values[d.values.length - 1].values.bad)) + ")";
      },
      x: 5,
      dy: '.35em',
      opacity: 0
    }).text(function(d) {
      var str, trimmedStr;
      if (d.key.indexOf('Gypsy') !== -1) {
        trimmedStr = 'Gypsy';
      } else if (d.key.indexOf('English') !== -1) {
        trimmedStr = 'British';
      } else if (d.key.indexOf('Mean') !== -1) {
        trimmedStr = 'Mean';
      } else {
        str = d.key;
        trimmedStr = str.substr(str.indexOf(':') + 2, str.length);
      }
      return trimmedStr;
    }).transition().duration(1750).attr('opacity', 0.1);
    wrap(labels, margin.right, 5);
    main_group.append('rect').attr({
      x: 0,
      y: 0,
      width: chart_width,
      height: chart_height,
      "class": 'init-transition-rect',
      fill: '#FFF'
    }).transition().duration(1500).attr({
      width: 0,
      x: chart_width
    }).remove();
    title_group.append('text').attr({
      x: 0,
      y: margin.p,
      opacity: 0,
      'font-size': '12px'
    }).text('Self-assessed bad or very bad health by ethnicity and age group').transition().duration(1500).attr('opacity', 1);
    return attachHoverHandlers();
  };
  my.update = function() {
    var circles, groups, labels, main_group_lines, point_labels, svg, y_axis_group;
    svg = d3.select('.gen-health-svg');
    groups = svg.selectAll('.ethnicity');
    main_group_lines = svg.selectAll('.main-group path');
    labels = svg.selectAll('.label');
    circles = groups.selectAll('.circle');
    point_labels = groups.selectAll('.point-label');
    y_axis_group = svg.select('.y.axis');
    groups.data(d3_array);
    main_group_lines.data(d3_array).transition().duration(1000).delay(500).attr('d', function(d) {
      return line(d.values);
    });
    labels.data(d3_array).transition().duration(1000).delay(500).attr({
      transform: function(d) {
        return "translate(" + (x(d.values[d.values.length - 1].key)) + ", " + (y(d.values[d.values.length - 1].values.bad)) + ")";
      }
    });
    circles.data(function(d) {
      return d.values;
    }).transition().duration(1000).delay(500).attr({
      cx: function(d) {
        return x(d.key);
      },
      cy: function(d) {
        return y(d.values.bad);
      }
    });
    point_labels.data(function(d) {
      return d.values;
    }).transition().duration(1000).delay(500).attr({
      transform: function(d) {
        return "translate(" + (x(d.key)) + ", " + (y(d.values.bad)) + ")";
      }
    }).text(function(d) {
      return pointPercFormat(d.values.bad);
    });
    y_axis_group.transition().duration(1000).delay(500).call(yAxis);
    return attachHoverHandlers();
  };
  my.resize = function() {
    var circles, groups, labels, main_group_lines, point_labels, svg, title_group, x_axis_group, y_axis_group;
    svg = d3.select('.gen-health-svg');
    groups = svg.selectAll('.ethnicity');
    main_group_lines = svg.selectAll('.main-group path');
    labels = svg.selectAll('.label');
    circles = groups.selectAll('.circle');
    point_labels = groups.selectAll('.point-label');
    y_axis_group = svg.select('.y.axis');
    x_axis_group = svg.select('.x.axis');
    title_group = svg.select('.title-group');
    title_group.attr('transform', "translate(" + (chart_width / 3 - margin.left) + ", 0)");
    main_group_lines.attr('d', function(d) {
      return line(d.values);
    });
    labels.attr({
      transform: function(d) {
        return "translate(" + (x(d.values[d.values.length - 1].key)) + ", " + (y(d.values[d.values.length - 1].values.bad)) + ")";
      }
    });
    circles.attr({
      cx: function(d) {
        return x(d.key);
      },
      cy: function(d) {
        return y(d.values.bad);
      }
    });
    point_labels.attr({
      transform: function(d) {
        return "translate(" + (x(d.key)) + ", " + (y(d.values.bad)) + ")";
      }
    });
    y_axis_group.call(yAxis);
    return x_axis_group.call(xAxis);
  };
  my.highlightDetail = function() {
    var groups, labels, lines, points, selected_lines, svg;
    svg = d3.select('.gen-health-svg');
    groups = svg.selectAll('.ethnicity');
    points = groups.selectAll('.point');
    lines = svg.selectAll('.line');
    labels = svg.selectAll('.label');
    selected_lines = [];
    points.transition().duration(250).attr('opacity', function(d) {
      if (highlights.length === 0) {
        return 0;
      } else if (highlights.indexOf(d.key) === -1) {
        return 0;
      } else {
        return 1;
      }
    });
    lines.transition().duration(250).attr('opacity', function(d) {
      if (highlights.length === 0) {
        return 1;
      } else if (highlights.indexOf(d.key) === -1) {
        return 0.1;
      } else {
        return 1;
      }
    });
    return labels.transition().duration(250).attr('opacity', function(d) {
      if (highlights.length === 0) {
        return 0.1;
      }
      if (highlights.indexOf(d.key) === -1) {
        return 0.1;
      } else {
        return 1;
      }
    });
  };
  attachHoverHandlers = function() {
    var groups, svg;
    svg = d3.select('.gen-health-svg');
    groups = svg.selectAll('.ethnicity');
    return groups.on('mouseover', function(d) {
      var _label, _line, g;
      g = d3.select(this);
      _line = g.select('.line');
      _label = g.select('.label');
      if (_line.attr('opacity') !== '1') {
        _line.attr('opacity', 0.99);
      }
      if (_label.attr('opacity') === '0.1') {
        return _label.attr('opacity', 0.99);
      }
    }).on('mouseout', function(d) {
      var _label, _line, g;
      g = d3.select(this);
      _line = g.select('.line');
      _label = g.select('.label');
      if (_line.attr('opacity') === '0.99') {
        _line.attr('opacity', 0.1);
      }
      if (_label.attr('opacity') === '0.99') {
        return _label.attr('opacity', 0.1);
      }
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

module.exports = drawGenHealthChart;

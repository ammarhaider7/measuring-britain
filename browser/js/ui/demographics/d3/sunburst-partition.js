// Generated by CoffeeScript 1.10.0
var drawSunburst;

drawSunburst = function(options) {
  var activeCategory, activeValue, arc, arcTween, attachHoverHandlers, container, data, ethnic_group_arr, format, getColour, getSubColour, height, initTween, isDefault, margin, mobile_portrait_width, my, nested_data, nested_data_init, onInitDone, onMouseOver, partition, percFormat, radius, ref, ref1, stash, total_item, total_item_value, width, y;
  container = options.container, data = options.data, isDefault = options.isDefault, onMouseOver = options.onMouseOver, activeCategory = options.activeCategory, activeValue = options.activeValue, onInitDone = options.onInitDone;
  nested_data = data.d3_nested_data;
  total_item = data.total_item;
  total_item_value = total_item.obs_value.value;
  nested_data_init = {
    name: "ethnic_diversity",
    children: []
  };
  ethnic_group_arr = [
    {
      name: 'White',
      colour: '#2C81BF'
    }, {
      name: 'Black',
      colour: '#7569B3'
    }, {
      name: 'Asian',
      colour: '#29A450'
    }, {
      name: 'Mixed',
      colour: '#E85400'
    }, {
      name: 'Other',
      colour: '#636363'
    }
  ];
  getColour = function(name) {
    switch (name) {
      case 'White':
        return '#2C81BF';
      case 'Black':
        return '#7569B3';
      case 'Asian':
        return '#29A450';
      case 'Mixed':
        return '#E85400';
      case 'Other':
        return '#636363';
    }
  };
  getSubColour = function(name) {
    switch (name) {
      case 'White':
        return '#68ADD8';
      case 'Black':
        return '#9E99CA';
      case 'Asian':
        return '#71C573';
      case 'Mixed':
        return '#FF8D2E';
      case 'Other':
        return '#969696';
    }
  };
  width = (ref = $(container).width()) != null ? ref : 1140;
  height = (ref1 = $(container).height()) != null ? ref1 : 500;
  mobile_portrait_width = 740;
  margin = {
    top: 25,
    right: 0,
    bottom: 25,
    left: 25,
    middle: 15,
    text: 50,
    p: 5
  };
  radius = Math.min(width, (height - margin.bottom - margin.top) / 2);
  format = d3.format('.3s');
  percFormat = d3.format(',.1%');
  partition = d3.layout.partition().sort(null).size([2 * Math.PI, radius * radius]).value(function(d) {
    return d.size;
  });
  arc = d3.svg.arc().startAngle(function(d) {
    return d.x;
  }).endAngle(function(d) {
    return d.x + d.dx;
  }).innerRadius(function(d) {
    return Math.sqrt(d.y);
  }).outerRadius(function(d) {
    return Math.sqrt(d.y + d.dy);
  }).cornerRadius(5);
  y = d3.scale.ordinal().domain(d3.range(ethnic_group_arr.length)).rangeRoundBands([0, height / 3], 0);
  arcTween = function(d) {
    var i;
    i = d3.interpolate({
      x: this.x0,
      dx: this.dx0
    }, d);
    return (function(_this) {
      return function(t) {
        var b;
        b = i(t);
        _this.x0 = b.x;
        _this.dx0 = b.dx;
        return arc(b);
      };
    })(this);
  };
  initTween = function(d) {
    var i;
    i = d3.interpolate({
      x: 0,
      dx: 0
    }, d);
    return (function(_this) {
      return function(t) {
        var b;
        b = i(t);
        return arc(b);
      };
    })(this);
  };
  stash = function(d) {
    this.x0 = d.x;
    this.dx0 = d.dx;
  };
  my = {};
  attachHoverHandlers = function() {
    var center_ethnic_group, center_percent_group, center_total_value_group, svg;
    svg = d3.select('.sunburst-svg');
    center_total_value_group = svg.select('.total-value-group');
    center_ethnic_group = svg.select('.ethnic-group-text');
    center_percent_group = svg.select('.percentage-group');
    return d3.selectAll('.sunburst-path').on('mouseover', function(d) {
      var _d;
      onMouseOver({
        label: d.name,
        value: d.value
      });
      _d = d;
      d3.selectAll('.sunburst-path').attr('opacity', function(d) {
        if (_d !== d) {
          return 0.2;
        }
      });
      center_ethnic_group.select('text').text(d.name);
      center_total_value_group.select('text').text(format(d.value));
      return center_percent_group.select('text').attr('fill', d.depth === 1 ? getColour(d.name) : getColour(d.parent.name)).text(percFormat(d.value / total_item_value));
    }).on('mouseout', function(d) {
      d3.selectAll('.sunburst-path').attr('opacity', 1);
      center_ethnic_group.select('text').text('All ethnic groups');
      center_total_value_group.select('text').text(format(total_item_value));
      return center_percent_group.select('text').text('100%').attr('fill', '#333');
    });
  };
  my.init = function() {
    var center_ethnic_group, center_group, center_percent_group, center_total_value_group, half_height, key_group, key_text_group, main_group, paths, svg;
    svg = d3.select('.sunburst-svg');
    main_group = svg.select('.main-group');
    center_group = svg.select('.center-text-group');
    center_total_value_group = svg.select('.total-value-group');
    center_ethnic_group = svg.select('.ethnic-group-text');
    center_percent_group = svg.select('.percentage-group');
    key_group = svg.select('.key-group');
    key_text_group = svg.select('.key-text-group');
    half_height = height * 0.52;
    main_group.attr('transform', "translate(" + (width / 2) + ", " + half_height + ")");
    center_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + margin.middle - margin.top * 2) + ")");
    center_ethnic_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + margin.text - margin.top * 2) + ")");
    center_percent_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + (margin.text * 2) - margin.top * 2) + ")");
    center_total_value_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + (margin.text * 2.7) - margin.top * 2) + ")");
    key_group.attr('transform', "translate(" + ((width * 0.9) + 20) + ", " + margin.top + ")");
    key_text_group.attr('transform', "translate(" + (width * 0.9) + ", " + (margin.top + 17) + ")");
    paths = main_group.selectAll('path').data(partition.nodes(nested_data)).enter().append('path').attr({
      display: function(d) {
        if (d.depth) {
          return null;
        } else {
          return 'none';
        }
      },
      "class": "sunburst-path"
    }).style('stroke', '#fff').style('fill', function(d) {
      if (d.depth === 1) {
        return getColour((d.children ? d : d.parent).name);
      } else {
        return getSubColour((d.children ? d : d.parent).name);
      }
    }).style('fill-rule', 'evenodd').transition().duration(1500).attrTween('d', initTween).each(stash);
    center_group.append('text').attr('opacity', 0).text(activeValue).attr('text-anchor', 'middle').attr('class', 'active-value-text').transition().duration(1500).attr('opacity', 1);
    center_ethnic_group.append('text').attr('opacity', 0).text('All ethnic groups').attr('text-anchor', 'middle').attr('class', 'ethnicity-text').transition().duration(1500).attr('opacity', 1);
    center_percent_group.append('text').attr('opacity', 0).text('100%').attr('text-anchor', 'middle').attr('class', 'percent-text').transition().duration(1500).attr('opacity', 1);
    center_total_value_group.append('text').attr('opacity', 0).text(format(total_item_value)).attr('text-anchor', 'middle').attr('class', 'total-value-text').transition().duration(1500).attr('opacity', 1);
    key_group.selectAll('rect').data(ethnic_group_arr).enter().append('rect').attr({
      x: 0,
      y: function(d, i) {
        return y(i);
      },
      width: margin.p * 5,
      height: margin.p * 5,
      rx: 3,
      fill: function(d) {
        return d.colour;
      }
    });
    key_text_group.selectAll('text').data(ethnic_group_arr).enter().append('text').text(function(d) {
      return d.name;
    }).attr({
      y: function(d, i) {
        return y(i);
      },
      x: 10,
      'text-anchor': 'end'
    });
    attachHoverHandlers();
    return onInitDone();
  };
  my.update = function() {
    var center_value_text, ethnic_text, main_group, newSegments, percent_text, svg, total_value_text;
    svg = d3.select('.sunburst-svg');
    main_group = svg.select('.main-group');
    center_value_text = svg.select('.active-value-text');
    total_value_text = svg.select('.total-value-text');
    percent_text = svg.select('.percent-text');
    ethnic_text = svg.select('.ethnicity-text');
    center_value_text.transition().duration(500).attr('opacity', 0).transition().duration(1000).delay(500).text(activeValue).attr('opacity', 1);
    total_value_text.transition().duration(500).attr('opacity', 0).transition().duration(1000).delay(500).text(format(total_item_value)).attr('opacity', 1);
    percent_text.transition().duration(500).attr('opacity', 0).transition().duration(1000).delay(500).attr('fill', '#333').text('100%').attr('opacity', 1);
    ethnic_text.transition().duration(500).attr('opacity', 0).transition().duration(1000).delay(500).text('All ethnic groups').attr('opacity', 1);
    total_value_text.transition().duration(500).attr('opacity', 0).transition().duration(1000).delay(500).text(format(total_item.obs_value.value)).attr('opacity', 1);
    newSegments = main_group.selectAll('path.sunburst-path').data(partition.nodes(nested_data)).transition().duration(1500).delay(500).attrTween('d', arcTween);
    attachHoverHandlers();
  };
  my.resize = function() {
    var center_ethnic_group, center_group, center_percent_group, center_total_value_group, half_height, key_group, key_text_group, main_group, paths, svg;
    svg = d3.select('.sunburst-svg');
    main_group = svg.select('.main-group');
    center_group = svg.select('.center-text-group');
    center_total_value_group = svg.select('.total-value-group');
    center_ethnic_group = svg.select('.ethnic-group-text');
    center_percent_group = svg.select('.percentage-group');
    key_group = svg.select('.key-group');
    key_text_group = svg.select('.key-text-group');
    half_height = height * 0.52;
    main_group.attr('transform', "translate(" + (width / 2) + ", " + half_height + ")");
    center_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + margin.middle - margin.top * 2) + ")");
    center_ethnic_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + margin.text - margin.top * 2) + ")");
    center_percent_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + (margin.text * 2) - margin.top * 2) + ")");
    center_total_value_group.attr('transform', "translate(" + (width / 2) + ", " + (half_height + (margin.text * 3) - margin.top * 2) + ")");
    key_group.attr('transform', "translate(" + ((width * 0.9) + 20) + ", " + margin.top + ")");
    key_text_group.attr('transform', "translate(" + (width * 0.9) + ", " + (margin.top + 17) + ")");
    paths = main_group.selectAll('path').data(partition.nodes(nested_data)).attr('d', arc);
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

module.exports = drawSunburst;

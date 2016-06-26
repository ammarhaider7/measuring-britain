// Generated by CoffeeScript 1.10.0
var $, d3, dims, splash;

d3 = void 0;

dims = void 0;

splash = void 0;

$ = void 0;

$ = require('jQuery');

d3 = require('d3');

dims = {
  width: window.innerWidth,
  height: window.innerHeight
};

splash = function() {
  var path, polygon, redraw, svg, vertices, voronoi;
  path = void 0;
  polygon = void 0;
  redraw = void 0;
  svg = void 0;
  vertices = void 0;
  voronoi = void 0;
  redraw = function() {
    path = path.data(voronoi(vertices), polygon);
    path.exit().remove();
    path.enter().append('path').attr({
      'class': function(d, i) {
        return 'q' + i % 3 + '-9';
      },
      'd': polygon
    });
    return path.order();
  };
  polygon = function(d) {
    return 'M' + d.join('L') + 'Z';
  };
  vertices = d3.range(200).map(function(d) {
    return [Math.random() * dims.width, Math.random() * dims.height];
  });
  voronoi = d3.geom.voronoi().clipExtent([[0, 0], [dims.width, dims.height]]);
  svg = d3.select('.cell-background').append('svg').attr({
    'width': dims.width,
    'height': dims.height
  }).on('mousemove', function() {
    vertices[0] = d3.mouse(this);
    return redraw();
  });
  path = svg.append('g').selectAll('path');
  $(window).resize(redraw);
  return redraw();
};

module.exports = splash;

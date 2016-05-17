window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.d3 = require 'd3'
window.$ = require 'jquery'
bootstrap = require '../../bootstrap-sass/javascripts/bootstrap.min.js'
bootstrap_tooltips = require '../../bootstrap-sass/javascripts/bootstrap/tooltip.js'
render = require './redux/index.js' 
EthnicSection = require './ui/demographics/static-components/ethnic-diversity.js'
ReligiousSection = require './ui/demographics/static-components/religious-diversity.js'

# Render presentational (stateless) components manually
ReactDOM.render <EthnicSection/>, document.getElementById 'mb_ethnic_diversity'
ReactDOM.render <ReligiousSection/>, document.getElementById 'mb_religious_diversity'
# Render container components via redux
render()
# Opt-in tooltip functionality
$ ->
	$('[data-toggle="tooltip"]').tooltip()
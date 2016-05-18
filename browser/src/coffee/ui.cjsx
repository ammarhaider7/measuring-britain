window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.d3 = require 'd3'
window.$ = require 'jquery'
bootstrap = require '../../bootstrap-sass/javascripts/bootstrap.min.js'
bootstrap_tooltips = require '../../bootstrap-sass/javascripts/bootstrap/tooltip.js'
EthnicSection = require './ui/demographics/static-components/ethnic-diversity.js'
ReligiousSection = require './ui/demographics/static-components/religious-diversity.js'

# render functions
renderDemographics = ->

	render = require './redux/demographics.js'
	# Render presentational (stateless) components manually
	ReactDOM.render <EthnicSection/>, document.getElementById 'mb_ethnic_diversity'
	ReactDOM.render <ReligiousSection/>, document.getElementById 'mb_religious_diversity'
	# Render container components via redux
	render()

renderHealth = ->

	render = require './redux/health.js'
	# Render presentational (stateless) components manually
	# Render container components via redux
	render()

renderLabour = ->

	render = require './redux/labour.js'
	# Render presentational (stateless) components manually
	# Render container components via redux
	render()

# Establish what page this is
path = location.pathname.split('/')[1]

# Set the right render method
switch path
	when 'demographics' then renderDemographics()
	when 'health' then renderHealth()
	when 'labour' then renderLabour()

# Opt-in tooltip functionality
$ ->
	$('[data-toggle="tooltip"]').tooltip()

# Set the active nav item
$activeNavItem = $(".#{ path }").addClass 'active'
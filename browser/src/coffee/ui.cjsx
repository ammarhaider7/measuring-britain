window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.d3 = require 'd3'
window.$ = require 'jquery'
bootstrap = require '../../bootstrap-sass/javascripts/bootstrap.min.js'
bootstrap_tooltips = require '../../bootstrap-sass/javascripts/bootstrap/tooltip.js'
EthnicSection = require './ui/demographics/static-components/ethnic-diversity.js'
ReligiousSection = require './ui/demographics/static-components/religious-diversity.js'
GeneralHealthSection = require './ui/health/static-components/general-health.js'
DisabilitySection = require './ui/health/static-components/health-disability.js'

# Establish what page this is
path = location.pathname.split('/')[1]
# Set the active nav item
$(".#{ path }").addClass 'active'

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
	ReactDOM.render <GeneralHealthSection/>, document.getElementById 'mb_general_health'
	ReactDOM.render <DisabilitySection/>, document.getElementById 'mb_health_disability'
	# Render container components via redux
	render()

renderLabour = ->

	render = require './redux/labour.js'
	# Render presentational (stateless) components manually

	# Render container components via redux
	render()

# Set the right render method
switch path
	when 'demographics' then renderDemographics()
	when 'health' then renderHealth()
	when 'labour' then renderLabour()

# Opt-in tooltip functionality
$ ->
	$('[data-toggle="tooltip"]').tooltip()
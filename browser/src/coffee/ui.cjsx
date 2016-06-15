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
_path = path
raw_path = location.pathname
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

renderPopulationPyramid = ->

	render = require './redux/renderers/population-pyramid.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	PopulationPyramid = require './ui/demographics/static-components/population-pyramid.js'
	# Render presentational (stateless) components manually
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header={ 'Population Pyramid - Census' }/>, document.getElementById 'mb_page_header'
	ReactDOM.render <PopulationPyramid/>, document.getElementById 'react_container'
	# Render container components via redux
	render()

renderEthnicDiversity = ->

	render = require './redux/renderers/ethnic-diversity.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	EthnicDiversity = require './ui/demographics/static-components/ethnic-diversity.js'
	# Render presentational (stateless) components manually
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header='Ethnic Diversity - Census'/>, document.getElementById 'mb_page_header'
	ReactDOM.render <EthnicDiversity/>, document.getElementById 'react_container'
	# Render container components via redux
	render()

renderReligiousDiversity = ->

	render = require './redux/renderers/religious-diversity.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	ReligiousDiversity = require './ui/demographics/static-components/religious-diversity.js'
	# Render presentational (stateless) components manually
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header='Religious Diversity - Census'/>, document.getElementById 'mb_page_header'
	ReactDOM.render <ReligiousDiversity/>, document.getElementById 'react_container'
	# Render container components via redux
	render()

renderEthnicGenHealth = ->

	render = require './redux/renderers/ethnic-general-health.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	EthnicGenHealth = require './ui/health/static-components/general-health.js'
	# Render presentational (stateless) components manually
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header="Ethnic Disparities in General Health - Census"/>, document.getElementById 'mb_page_header'
	ReactDOM.render <EthnicGenHealth/>, document.getElementById 'react_container'
	# Render container components via redux
	render()

renderHealthDisability = ->

	render = require './redux/renderers/health-disability.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	HealthDisability = require './ui/health/static-components/health-disability.js'
	# Render presentational (stateless) components manually
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header="Long-term illness/disability by ethnicity - Census"/>, document.getElementById 'mb_page_header'
	ReactDOM.render <HealthDisability/>, document.getElementById 'react_container'
	# Render container components via redux
	render()

# Set the right render method
switch raw_path
	when '/demographics' then renderDemographics()
	when '/health' then renderHealth()
	when '/labour' then renderLabour()
	when '/census/population-pyramid' then renderPopulationPyramid()
	when '/census/ethnic-diversity' then renderEthnicDiversity()
	when '/census/religious-diversity' then renderReligiousDiversity()
	when '/census/ethnic-disparities-general-health' then renderEthnicGenHealth()
	when '/census/longterm-illness-disability-by-ethnicity' then renderHealthDisability()

# Opt-in tooltip functionality
$ ->
	$('[data-toggle="tooltip"]').tooltip()
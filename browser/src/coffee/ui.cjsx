React = require 'react'
ReactDOM = require 'react-dom'
$ = require 'jquery'
bootstrap = require '../../bootstrap-sass/javascripts/bootstrap.min.js'
bootstrap_tooltips = require '../../bootstrap-sass/javascripts/bootstrap/tooltip.js'
Footer = require './partials/footer.js'
MobilePortraitRotate = require './partials/mobile-portrait-rotate.js'
# NewsletterSignup = require './partials/newsletter-signup.js'

# Establish what page this is
path = location.pathname.split('/')[1]
_path = path
raw_path = location.pathname
# Set the active nav item
$(".#{ path }").addClass 'active'
# Is the user on mobile portrait?
isMobilePortrait = do ->
	window_width = $(window).width()
	return yes if window_width < 740

renderPopulationPyramid = ->

	render = require './redux/renderers/population-pyramid.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	PopulationPyramid = require './ui/demographics/static-components/population-pyramid.js'
	# Render presentational (stateless) components manually
	if isMobilePortrait is yes
		ReactDOM.render <MobilePortraitRotate/>, document.getElementById 'mobile-portrait-container'

	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header={ 'Population Pyramid - Census' }/>, document.getElementById 'mb_page_header'
	ReactDOM.render <PopulationPyramid/>, document.getElementById 'react_container'
	ReactDOM.render <Footer/>, document.getElementById 'mb_footer'
	# ReactDOM.render <NewsletterSignup/>, document.getElementById 'mb_mc_signupform'
	# Render container components via redux
	render()

renderEthnicDiversity = ->

	render = require './redux/renderers/ethnic-diversity.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	EthnicDiversity = require './ui/demographics/static-components/ethnic-diversity.js'
	# Render presentational (stateless) components manually
	if isMobilePortrait is yes
		ReactDOM.render <MobilePortraitRotate/>, document.getElementById 'mobile-portrait-container'
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header='Ethnic Diversity - Census'/>, document.getElementById 'mb_page_header'
	ReactDOM.render <EthnicDiversity/>, document.getElementById 'react_container'
	ReactDOM.render <Footer/>, document.getElementById 'mb_footer'
	# ReactDOM.render <NewsletterSignup/>, document.getElementById 'mb_mc_signupform'
	# Render container components via redux
	render()

renderReligiousDiversity = ->

	render = require './redux/renderers/religious-diversity.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	ReligiousDiversity = require './ui/demographics/static-components/religious-diversity.js'
	# Render presentational (stateless) components manually
	if isMobilePortrait is yes
		ReactDOM.render <MobilePortraitRotate/>, document.getElementById 'mobile-portrait-container'
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header='Religious Diversity - Census'/>, document.getElementById 'mb_page_header'
	ReactDOM.render <ReligiousDiversity/>, document.getElementById 'react_container'
	ReactDOM.render <Footer/>, document.getElementById 'mb_footer'
	# ReactDOM.render <NewsletterSignup/>, document.getElementById 'mb_mc_signupform'
	# Render container components via redux
	render()

renderEthnicGenHealth = ->

	render = require './redux/renderers/ethnic-general-health.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	EthnicGenHealth = require './ui/health/static-components/general-health.js'
	# Render presentational (stateless) components manually
	if isMobilePortrait is yes
		ReactDOM.render <MobilePortraitRotate/>, document.getElementById 'mobile-portrait-container'
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header="Ethnic Disparities in General Health - Census"/>, document.getElementById 'mb_page_header'
	ReactDOM.render <EthnicGenHealth/>, document.getElementById 'react_container'
	ReactDOM.render <Footer/>, document.getElementById 'mb_footer'
	# ReactDOM.render <NewsletterSignup/>, document.getElementById 'mb_mc_signupform'
	# Render container components via redux
	render()

renderHealthDisability = ->

	render = require './redux/renderers/health-disability.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	HealthDisability = require './ui/health/static-components/health-disability.js'
	# Render presentational (stateless) components manually
	if isMobilePortrait is yes
		ReactDOM.render <MobilePortraitRotate/>, document.getElementById 'mobile-portrait-container'
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header="Long-term illness/disability by ethnicity - Census"/>, document.getElementById 'mb_page_header'
	ReactDOM.render <HealthDisability/>, document.getElementById 'react_container'
	ReactDOM.render <Footer/>, document.getElementById 'mb_footer'
	# ReactDOM.render <NewsletterSignup/>, document.getElementById 'mb_mc_signupform'
	# Render container components via redux
	render()

renderEmploymentStatusByCountry = ->

	render = require './redux/renderers/econ-activity-country.js'
	PageHeader = require './partials/page-header.js'
	Nav = require './partials/nav.js'
	EconByCountry = require './ui/labour/static-components/econ-activity-country.js'
	# Render presentational (stateless) components manually
	if isMobilePortrait is yes
		ReactDOM.render <MobilePortraitRotate/>, document.getElementById 'mobile-portrait-container'
	ReactDOM.render <Nav active={ _path } border='yes'/>, document.getElementById 'react_nav_container'
	ReactDOM.render <PageHeader page_header="Employment status by country of birth - Census"/>, document.getElementById 'mb_page_header'
	ReactDOM.render <EconByCountry/>, document.getElementById 'react_container'
	ReactDOM.render <Footer/>, document.getElementById 'mb_footer'
	# ReactDOM.render <NewsletterSignup/>, document.getElementById 'mb_mc_signupform'
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
	when '/census/employment-status-by-country-of-birth' then renderEmploymentStatusByCountry()

# Opt-in tooltip functionality
$ ->
	$('[data-toggle="tooltip"]').tooltip()
	# Unhide newsletter signup
	$('#mb_mc_signupform').css 'visibility', 'visible'


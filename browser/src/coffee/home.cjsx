window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.d3 = require 'd3'
window.$ = require 'jquery'
bootstrap = require '../../bootstrap-sass/javascripts/bootstrap.min.js'
Nav = require './partials/nav.js'
ThumbnailsComponent = require './home/thumbnails-component.js'
CensusIntro = require './home/census-intro.js'
PageHeader = require './partials/page-header.js'
Footer = require './partials/footer.js'
{ demographics, health, labour } = require './page-data/census-home/thumbnails.js'

# Establish what page this is
path = location.pathname.split('/')[1]

# Render presentational (stateless) components manually
ReactDOM.render <PageHeader page_header={ path }/>, document.getElementById 'mb_page_header'
ReactDOM.render <CensusIntro/>, document.getElementById 'census_intro_row'
ReactDOM.render <Nav active={ path } border="yes"/>, document.getElementById 'react_nav_container'
ReactDOM.render <ThumbnailsComponent section="Demographics" data={demographics}/>, document.getElementById 'demographics_row'
ReactDOM.render <ThumbnailsComponent section="Health" data={health}/>, document.getElementById 'health_row'
ReactDOM.render <ThumbnailsComponent section="Labour Market" data={labour}/>, document.getElementById 'labour_row'
ReactDOM.render <Footer/>, document.getElementById 'mb_footer'
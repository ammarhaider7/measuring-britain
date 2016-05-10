React = require 'react'
ReactDOM = require 'react-dom'
bootstrap = require '../../bootstrap-sass/javascripts/bootstrap.js'
render = require './redux/index.js' 
EthnicSection = require './ui/demographics/static-components/ethnic-diversity.js'
ReligiousSection = require './ui/demographics/static-components/religious-diversity.js'

# Render presentational (stateless) components manually
ReactDOM.render <EthnicSection/>, document.getElementById 'mb_ethnic_diversity'
ReactDOM.render <ReligiousSection/>, document.getElementById 'mb_religious_diversity'
# Render container components via redux
render()
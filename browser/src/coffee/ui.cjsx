React = require 'react'
ReactDOM = require 'react-dom'
bootstrap = require '../../bootstrap-sass/javascripts/bootstrap.js'
render = require './redux/index.js' 
EthnicSection = require './ui/demographics/static-components/ethnic-diversity.js'

# Render presentational (stateless) components manually
ReactDOM.render <EthnicSection/>, document.getElementById 'mb_ethnic_diversity'
# Render container components via redux
render()
ReactDOM = require 'react-dom'
React = require 'react'

EthnicSection = ->

	<div className="row mb-quicksand">
		<div className="hidden-xs col-sm-12">
			<h3 className="mb-section-header">Ethnic Diversity 
				<button className="btn btn-info btn-xs" type="button" data-toggle="collapse" data-target="#ethnicCollapse" aria-expanded="false" aria-controls="ethnicCollapse">
					<span className="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					info
				</button>
			</h3>
			<div>
				<div className="collapse mb-quicksand" id="ethnicCollapse">
					<div className="alert alert-block alert-info mb-section-text">
						<button type="button" className="close">×</button>
						<p><strong>Ethnic Diversity Sunburst</strong></p>
						<p>A <strong>constrictive</strong> pyramid has fewer people in the younger age categories, perhaps as baby boom populations shift to more conservative birth rates. An <strong>expansive</strong> pyramid represents greater numbers of people in the younger age categories and is typical of where birth rates are high and life expectancy is short. A <strong>stationary</strong> pyramid shows roughly equal numbers of people in all age categories, with a tapering towards the older age categories.</p>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>The Ethnic Diversity chart shows the distribution of the population by age group and gender.</p>    
			</div>
		</div>
		<div className="col-sm-12">
			<div id="sunburst-controls"></div>
			<div id="sunburst-component"></div>
		</div>
	</div>

module.exports = EthnicSection
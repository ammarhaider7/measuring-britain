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
						<button type="button" className="close" data-toggle="collapse" data-target="#ethnicCollapse" aria-expanded="false" aria-controls="ethnicCollapse">×</button>
						<p><strong>Overview</strong></p>
						<p>There are two levels of details to the ethnic diversity chart. The inner ring indicates the broader ethnic group while the outer ring offers a more specific breakdown of ethnicity.</p>
						<p><strong>Usage</strong></p>
						<p>Hover over or tap the various segments to reveal % of people within that ethnicity along with the total number of people.</p>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>The Ethnic Diversity chart shows the distribution of the population by ethnic group (broad) and ethnicity (specific).</p>    
			</div>
		</div>
		<div className="col-sm-12">
			<div id="sunburst-controls"></div>
			<div id="sunburst-component"></div>
		</div>
	</div>

module.exports = EthnicSection
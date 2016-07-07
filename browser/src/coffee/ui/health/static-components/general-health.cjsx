React = require 'react'

GeneralHealthSection = ->

	<div className="row mb-quicksand">
		<div className="hidden-xs col-sm-4">
			<h3 className="mb-section-header">Ethnic Disparities in General Health 
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
						<p>A question on self-assessed general health was included in the 2011 Census. The possible responses were 'Very good', 'Good', 'Fair', 'Bad' and 'Very bad'.</p>
						<p>This chart combines the values for 'bad' and 'very bad' and plots these for 18 different ethnicities across six age groups.</p>
						<p><strong>Usage</strong></p>
						<p>Use the gender controls to re-plot the data for a specific gender. Highlight specific ethnicities by using the checkboxes, this will bring the selected ethnicity into focus along with revealing the % value with self-assessed bad/very bad health for each age group.</p>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>The Ethnic Disparities in General Health chart shows the percentage of the population with self-assessed bad or very bad health broken down by age group and ethnicity.</p>    
			</div>
			<div id="general-health-details"></div>
		</div>
		<div className="col-sm-8">
			<div id="general-health-component"></div>
		</div>
	</div>

module.exports = GeneralHealthSection
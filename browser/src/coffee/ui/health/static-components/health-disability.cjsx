DisabilitySection = ->

	<div className="row mb-quicksand">
		<div className="hidden-xs col-sm-12">
			<h3 className="mb-section-header">Long-term illness or disability by ethnicity 
				<button className="btn btn-info btn-xs" type="button" data-toggle="collapse" data-target="#disabilityCollapse" aria-expanded="false" aria-controls="disabilityCollapse">
					<span className="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					info
				</button>
			</h3>
			<div>
				<div className="collapse mb-quicksand" id="disabilityCollapse">
					<div className="alert alert-block alert-info mb-section-text">
						<button type="button" className="close" data-toggle="collapse" data-target="#disabilityCollapse" aria-expanded="false" aria-controls="disabilityCollapse">×</button>
						<p><strong>Overview</strong></p>
						<p>A look at the health of the population of England and Wales in respect to activity limiting health problems or disabilities. This chart shows the proportion of each age group (across 18 different ethnicites) who have indicated that their day-to-day activities are 'limited a lot' by their illness/disability.</p>
						<p><strong>Usage</strong></p>
						<p>Hover over the bars to reveal a tooltip that tells you the % of people with a long-term health problem/disability.</p>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>The ethnic Disparities in long-term illness and disability chart shows the number and percentage of the population with a long-term illness or disability broken down by age group and ethnicity.</p>    
			</div>
		</div>
		<div className="col-sm-12">
			<div id="health-disability-controls"></div>
			<div id="health-disability-component"></div>
		</div>
	</div>

module.exports = DisabilitySection
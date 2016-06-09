DisabilitySection = ->

	<div className="row mb-quicksand">
		<hr/>
		<div className="hidden-xs col-sm-12">
			<h3 className="mb-section-header">Ethnic Disparities in long-term illness and disability 
				<button className="btn btn-info btn-xs" type="button" data-toggle="collapse" data-target="#disabilityCollapse" aria-expanded="false" aria-controls="disabilityCollapse">
					<span className="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					info
				</button>
			</h3>
			<div>
				<div className="collapse mb-quicksand" id="disabilityCollapse">
					<div className="alert alert-block alert-info mb-section-text">
						<button type="button" className="close" data-toggle="collapse" data-target="#disabilityCollapse" aria-expanded="false" aria-controls="disabilityCollapse">×</button>
						<p><strong>Long-term illness or disability by ethnic group and gender</strong></p>
						<p>A <strong>constrictive</strong> pyramid has fewer people in the younger age categories, perhaps as baby boom populations shift to more conservative birth rates. An <strong>expansive</strong> pyramid represents greater numbers of people in the younger age categories and is typical of where birth rates are high and life expectancy is short. A <strong>stationary</strong> pyramid shows roughly equal numbers of people in all age categories, with a tapering towards the older age categories.</p>
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
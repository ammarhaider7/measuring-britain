EconActivityByCountry = ->

	<div className="row mb-quicksand">
		<div className="hidden-xs col-sm-4">
			<h3 className="mb-section-header">Employment Status by country of birth 
				<button className="btn btn-info btn-xs" type="button" data-toggle="collapse" data-target="#econCountry" aria-expanded="false" aria-controls="econCountry">
					<span className="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					info
				</button>
			</h3>
			<div>
				<div className="collapse mb-quicksand" id="econCountry">
					<div className="alert alert-block alert-info mb-section-text">
						<button type="button" className="close" data-toggle="collapse" data-target="#econCountry" aria-expanded="false" aria-controls="econCountry">×</button>
						<p><strong>Employment Status by country of birth </strong></p>
						<p>A <strong>constrictive</strong> pyramid has fewer people in the younger age categories, perhaps as baby boom populations shift to more conservative birth rates. An <strong>expansive</strong> pyramid represents greater numbers of people in the younger age categories and is typical of where birth rates are high and life expectancy is short. A <strong>stationary</strong> pyramid shows roughly equal numbers of people in all age categories, with a tapering towards the older age categories.</p>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>This chart shows the proportion of people in work and out of work. This is further broken down by the type/reason of their employment status.</p>    
			</div>
			<div id="econ-country-details"></div>
		</div>
		<div className="col-sm-8">
			<div id="econ-country-component"></div>
		</div>
	</div>

module.exports = EconActivityByCountry
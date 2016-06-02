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
						<p><strong>General Health by Ethnic Group</strong></p>
						<p>A <strong>constrictive</strong> pyramid has fewer people in the younger age categories, perhaps as baby boom populations shift to more conservative birth rates. An <strong>expansive</strong> pyramid represents greater numbers of people in the younger age categories and is typical of where birth rates are high and life expectancy is short. A <strong>stationary</strong> pyramid shows roughly equal numbers of people in all age categories, with a tapering towards the older age categories.</p>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>The Ethnic Disparities in General Health chart shows the percentage of the population with self-proclaimed bad or very bad health broken down by age group and ethnicity.</p>    
			</div>
			<div className="" id="general-health-details"></div>
		</div>
		<div className="col-sm-8">
			<div id="general-health-controls"></div>
			<div id="general-health-component"></div>
		</div>
	</div>

module.exports = GeneralHealthSection
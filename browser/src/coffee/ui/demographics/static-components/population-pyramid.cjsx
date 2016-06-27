PopulationPyramid = ->

	<div className="row mb-quicksand">
		<div className="hidden-xs col-sm-4">
			<h3 className="mb-section-header">Population Pyramid 
				<button className="btn btn-info btn-xs" type="button" data-toggle="collapse" data-target="#pyrCollapse" aria-expanded="false" aria-controls="pyrCollapse">
					<span className="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					info
				</button>
			</h3>
			<div>
				<div className="collapse mb-quicksand" id="pyrCollapse">
					<div className="alert alert-block alert-info mb-section-text">
						<button type="button" className="close" data-toggle="collapse" data-target="#pyrCollapse" aria-expanded="false" aria-controls="pyrCollapse">×</button>
						<p><strong>Types of Population Pyramids</strong></p>
						<p>A <strong>contracting</strong> pyramid has fewer people in the younger age categories, perhaps as baby boom populations shift to more conservative birth rates.</p>
						<img src="/images/DTM_Pyramids1_contracting.png" className="mb-pyramid-states mb-single-img"></img>
						<p>An <strong>expanding</strong> pyramid represents greater numbers of people in the younger age categories and is typical of where birth rates are high and life expectancy is short.</p>
						<img src="/images/DTM_Pyramids1_expanding.png" className="mb-pyramid-states mb-double-img"></img>
						<p>A <strong>stationary</strong> pyramid shows roughly equal numbers of people in all age categories, with a tapering towards the older age categories.</p>
						<img src="/images/DTM_Pyramids1_stationary.png" className="mb-pyramid-states mb-single-img"></img>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>The Population Pyramid chart shows the distribution of the population by age group and gender.</p>    
			</div>
			<div id="pyramid-table"></div>
			<div id="pyramid-bars"></div>
		</div>
		<div className="col-xs-12 col-sm-8 mt-medium">
			<div id="pyramid-container"></div>
		</div>
	</div>

module.exports = PopulationPyramid
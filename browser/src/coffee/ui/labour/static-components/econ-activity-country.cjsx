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
						<p><strong>Overview</strong></p>
						<p>The top half of the chart shows the composition of the population who are in work while the bottom half shows the same but for people out of work. Instead of displaying individual countries, we have grouped countries into broader geographic areas.</p>
						<p>Regarding employment status, there are two possible values for those in work: <em>Employee</em> and <em>Self-employed</em>. For those out of work, there are six possible values: <em>Unemployed (those actively seeking work)</em>, <em>Retired</em>, <em>Student</em>, <em>Looking after home/family</em>, <em>Long-term sick/disabled</em> and <em>Other</em>.</p>
						<p><strong>Usage</strong></p>
						<p>Each shade of colour represents a specific employment status. Hover over the stacked bars to reveal a tooltip that displays the type of employment status along with the % and number of people that fall within it.</p>
					</div>
				</div>   
			</div>	        
			<div className="mb-oxygen mb-section-text">
				<p>This chart shows the proportion of people in work and out of work by country of birth (countries are grouped by broader geographic area). This is further broken down by the type/reason of their employment status.</p>    
			</div>
			<div id="econ-country-details"></div>
		</div>
		<div className="col-sm-8">
			<div id="econ-country-component"></div>
		</div>
	</div>

module.exports = EconActivityByCountry
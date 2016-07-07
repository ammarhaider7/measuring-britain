React = require 'react'

About = ->

	<div>
		<div className="container col-md-6 col-md-offset-3">
			<div className="row">
				<h3 className="mb-roboto-strong">About Measuring Britain</h3>
				<p>Measuring Britain is a project aimed at making official statistics more accessible, interesting and fun through hand-crafted interactive charts and visualisations. We tackle three main areas of social life: Demographics, Health &amp; the Labour Market.</p>
				<p>The first phase of the project takes a fresh look at data from the 2011 census for England &amp; Wales. We'll be adding more visualisations regularly, focusing on more recent data. Subscribe to our newlsetter to be notified when new ones are added.</p>
			</div>
			<div className="row">
				<div className="col-sm-8 mb-no-padding">
					<h3 className="mb-roboto-strong">The data</h3>
					<p>All data is from the <a href="https://www.ons.gov.uk/" target="_blank">Office for National statistics</a> and is extracted from <a href="https://www.nomisweb.co.uk/" target="_blank">NOMIS</a>, a web-based database of official national statistics. Where "Census" is mentioned in the title of the chart, the data is from the 2011 Census for England & Wales.</p>
				</div>
				<div className="col-sm-4 mb-no-padding">
					<img src="/images/nomis.png" />
					<img src="/images/census-logo.png" />
				</div>
			</div>
			<div className="row">
				<h3 className="mb-roboto-strong">The Census</h3>
				<p>The census is a unique source of detailed socio-demographic statistics that underpins national policymaking with population estimates and projections to help allocate funding and plan investment and services. It is conducted every 10 years and is the richest source of social data we have. <a href="https://www.ons.gov.uk/census/2011census" target="_blank">More info</a></p>
			</div>
			<div className="row">
				<h3 className="mb-roboto-strong">Get in touch</h3>
				<p>For feedback/comments/questions please get in touch via <a href="mailto:contact@measuringbritain.co.uk" target="_blank">contact@measuringbritain.co.uk</a></p>
			</div>
		</div>
	</div>

module.exports = About
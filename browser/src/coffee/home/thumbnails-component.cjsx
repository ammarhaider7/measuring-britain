ThumbnailsComponent = React.createClass 

	render: ->
		<div className="row mb-oxygen">
			<h2 className="col-sm-12">{ @props.section }</h2>
			<div className="col-sm-6 col-md-4">
				<div className="">
					<a href="#" className="thumbnail">
						<img src="./images/mob_screenshot.PNG" alt="..."/>
					</a>
					<div className="caption">
						<h3 className="mt-zero">Chart name</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
						<p><a href="#" className="btn btn-default mb-btn-primary" role="button">Explore</a></p>
					</div>
				</div>
			</div>
			<div className="col-sm-6 col-md-4">
				<div className="">
					<a href="#" className="thumbnail">
						<img src="./images/mob_screenshot.PNG" alt="..."/>
					</a>
					<div className="caption">
						<h3 className="mt-zero">Chart name</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
						<p><a href="#" className="btn btn-default mb-btn-primary" role="button">Explore</a></p>
					</div>
				</div>
			</div>
			<div className="col-sm-6 col-md-4">
				<div className="">
					<a href="#" className="thumbnail">
						<img src="./images/mob_screenshot.PNG" alt="..."/>
					</a>
					<div className="caption">
						<h3 className="mt-zero">Chart name</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
						<p><a href="#" className="btn btn-default mb-btn-primary" role="button">Explore</a></p>
					</div>
				</div>
			</div>
		</div>

module.exports = ThumbnailsComponent
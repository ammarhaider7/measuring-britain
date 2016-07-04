React = require 'react'

ThumbnailsRowComponent = React.createClass 

	render: ->
		<div className="row mb-oxygen">
			<div className="col-sm-6 col-md-4">
				<div className="">
					<a href={ @props.data[0].href } className="thumbnail mb-all-pointer-events">
						<img src={ @props.data[0].img } alt="..."/>
					</a>
					<div className="caption">
						<h3 className="mt-zero">{ @props.data[0].chart_name }</h3>
						<p>{ @props.data[0].description }</p>
						<p><a href={ @props.data[0].href } className="btn btn-default mb-btn-primary mb-all-pointer-events" role="button">Explore</a></p>
					</div>
				</div>
			</div>
			<div className="col-sm-6 col-md-4">
				<div className="">
					<a href={ @props.data[1].href } className="thumbnail mb-all-pointer-events">
						<img src={ @props.data[1].img } alt="..."/>
					</a>
					<div className="caption">
						<h3 className="mt-zero">{ @props.data[1].chart_name }</h3>
						<p>{ @props.data[1].description }</p>
						<p><a href={ @props.data[1].href } className="btn btn-default mb-btn-primary mb-all-pointer-events" role="button">Explore</a></p>
					</div>
				</div>
			</div>
			<div className="col-sm-6 col-md-4">
				<div className="">
					<a href={ @props.data[2].href } className="thumbnail mb-all-pointer-events">
						<img src={ @props.data[2].img } alt="..."/>
					</a>
					<div className="caption">
						<h3 className="mt-zero">{ @props.data[2].chart_name }</h3>
						<p>{ @props.data[2].description }.</p>
						<p><a href={ @props.data[2].href } className="btn btn-default mb-btn-primary mb-all-pointer-events" role="button">Explore</a></p>
					</div>
				</div>
			</div>
		</div>

module.exports = ThumbnailsRowComponent
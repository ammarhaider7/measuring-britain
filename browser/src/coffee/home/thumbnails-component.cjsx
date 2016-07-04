React = require 'react'

ThumbnailsComponent = React.createClass 

	render: ->
		<div className="row mb-oxygen">
			<h2 className="col-sm-12">{ @props.section }</h2>
			{@props.data.map (ob, i) ->

				<div className="col-sm-6 col-md-4" key={i}>
					<div className="">
						<a href={ ob.href } className="thumbnail">
							<img src={ ob.img } alt="..."/>
						</a>
						<div className="caption">
							<h3 className="mt-zero">{ ob.chart_name }</h3>
							<p>{ ob.description }</p>
							<p><a href={ ob.href } className="btn btn-default mb-btn-primary" role="button">Explore</a></p>
						</div>
					</div>
				</div>

			}
		</div>

module.exports = ThumbnailsComponent
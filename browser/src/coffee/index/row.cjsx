ThumbnailsRowComponent = require '../partials/thumbnails-row.js'
thumbnailsData = require '../page-data/index/featured-thumbnails.js'

Row = ->

  <div className="container mb-white-text mb-roboto mb-no-pointer-events">
  	<div className="col-xs-12 mt-zero">
	    <ThumbnailsRowComponent data={thumbnailsData}/>
	</div>
  </div>

module.exports = Row
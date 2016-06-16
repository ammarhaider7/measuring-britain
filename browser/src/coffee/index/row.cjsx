ThumbnailsRowComponent = require '../partials/thumbnails-row.js'
thumbnailsData = require '../page-data/index/featured-thumbnails.js'

Row = ->

  <div className="container mb-white-text mb-roboto mb-no-pointer-events">
    <ThumbnailsRowComponent data={thumbnailsData}/>
  </div>

module.exports = Row
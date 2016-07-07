React = require 'react'

MobileRotate = ->

	<div className="mb-mobile-rotate" style={{ width: '100%', height: $(window).height() }}>
		<div className="text-center mt-60-percent">
			<i className="fa fa-repeat fa-4x" aria-hidden="true"></i>
			<p>Please rotate your mobile phone</p>
		</div>
	</div>

module.exports = MobileRotate
NewsletterSignup = ->

	<div id="mc_embed_signup">
		<div className="container col-sm-6 col-sm-offset-3">
			<form action="//measuringbritain.us13.list-manage.com/subscribe/post?u=a61fbfb347c2874094a4668e8&amp;id=782224cfee" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" className="validate" target="_blank" noValidate>
				<div id="mc_embed_signup_scroll">
					<label htmlFor="mce-EMAIL" className="mb-roboto-strong">Get notified when new charts are added!</label>
					<input type="email" value="" name="EMAIL" className="email" id="mce-EMAIL" placeholder="Email address" required />
					{### real people should not fill this in and expect good things - do not remove this or risk form bot signups ###}
					<div style={{position: 'absolute', left: '-5000px'}} aria-hidden="true">
						<input type="text" name="b_a61fbfb347c2874094a4668e8_782224cfee" tabIndex="-1" value="" />
					</div>
					<div className="clear">
						<input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" className="button" />
					</div>
				</div>
			</form>
		</div>
	</div>

module.exports = NewsletterSignup
var React = require('react');	
var DefaultLayout = require('./layouts/default');

var HelloMessage = React.createClass({

	propTypes: {
		commonJs: React.PropTypes.string,
		jsFile: React.PropTypes.string,
	},

	render() {

		return (
			<DefaultLayout {...this.props}>
				<div id="content"></div>
				<div id="container"></div>
				<script src={ `${this.props.commonJs}` }></script>
				<script src={ `${this.props.jsFile}` }></script>
			</DefaultLayout>
		);
	}

});

module.exports = HelloMessage;
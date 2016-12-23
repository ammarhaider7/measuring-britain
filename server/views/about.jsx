const React = require('react');	
const DefaultLayout = require('./layouts/default');

const About = React.createClass({

	propTypes: {
		commonJs: React.PropTypes.string,
		vendorJs: React.PropTypes.string,
		jsFile: React.PropTypes.string
	},

  render() {
    return (
		<DefaultLayout {...this.props}>
			<div id="body"></div>
			<script src={ `${this.props.commonJs}` }></script>
			<script src={ `${this.props.vendorJs}` }></script>
			<script src={ `${this.props.jsFile}` }></script>
		</DefaultLayout>
    );
  }
  
});

module.exports = About;
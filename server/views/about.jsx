const React = require('react');	
const DefaultLayout = require('./layouts/default');

const About = React.createClass({

  render() {
    return (
		<DefaultLayout {...this.props}>
			<div id="content"></div>
			<script src={ `${this.props.commonJs}` }></script>
			<script src={ `${this.props.jsFile}` }></script>
		</DefaultLayout>
    );
  }
  
});

module.exports = About;
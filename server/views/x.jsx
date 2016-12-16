const React = require('react');	
const DefaultLayout = require('./layouts/default');

const xHelloMessage = React.createClass({

  render() {
    return (
		<DefaultLayout {...this.props}>
			<div>Hello, {this.props.name}</div>
			<div id="content"></div>
			<script src={ `${this.props.commonJs}` }></script>
			<script src={ `${this.props.jsFile}` }></script>
		</DefaultLayout>
    );
  }
  
});

module.exports = xHelloMessage;
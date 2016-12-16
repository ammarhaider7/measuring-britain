var React = require('react');
var DefaultLayout = require('./layouts/default');

var errorMessage = React.createClass({
  render: function() {
    return (
		<DefaultLayout title={this.props.message}>
    		<div>Error</div>
		</DefaultLayout>
    );
  }
});

module.exports = errorMessage;
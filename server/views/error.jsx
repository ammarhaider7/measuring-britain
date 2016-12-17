var React = require('react');
var DefaultLayout = require('./layouts/default');

var errorMessage = React.createClass({
  render: function() {
    return (
		<DefaultLayout title='Measuring Britain | Page not found'>
			<h1>Page Not Found</h1>
			<p>Sorry, but the page you were trying to view does not exist.</p>
		</DefaultLayout>
    );
  }
});

module.exports = errorMessage;
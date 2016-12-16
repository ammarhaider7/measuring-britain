const React = require('react');

const DefaultLayout = React.createClass({

  render() {

    // server change reload
    const dev = this.props.env === 'dev';
    let reloadJs = null;
    if (dev) reloadJs = <script src='/dist/reload-client.js'></script>

    return (
      <html>
        <head>
          <title>{this.props.title}</title>
          <link rel="stylesheet" type="text/css" href={ `${this.props.commonCss}` } />
          <link rel="stylesheet" type="text/css" href={ `${this.props.cssFile}` } />
        </head>
        <body>
        	{this.props.children}
          { reloadJs }
        </body>
      </html>
    );
  }

});

module.exports = DefaultLayout;
const React = require('react');

const DefaultLayout = React.createClass({

  propTypes: {
    env: React.PropTypes.string,
    title: React.PropTypes.string,
    commonCss: React.PropTypes.string,
    cssFile: React.PropTypes.string,
    children: React.PropTypes.object
  },

  render() {

    // server change reload
    const dev = this.props.env === 'dev';
    let reloadJs = null;
    if (dev) reloadJs = <script src='/dist/reload-client.js'></script>

    return (
      <html>
        <head>
          <meta charSet="utf-8" />
          <meta httpEquiv="X-UA-Compatible" content="IE=edge,chrome=1" />
          <meta name="description" content="" />
          <meta name="viewport" content="width=device-width, initial-scale=1" />
          <link rel="apple-touch-icon" href="apple-touch-icon.png" />
          <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css' />
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
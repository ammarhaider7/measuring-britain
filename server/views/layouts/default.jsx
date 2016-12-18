const React = require('react');
import Nav from '../partials/navbar';

const DefaultLayout = React.createClass({

  propTypes: {
    env: React.PropTypes.string,
    title: React.PropTypes.string,
    commonCss: React.PropTypes.string,
    cssFile: React.PropTypes.string,
    children: React.PropTypes.array
  },

  renderHead() {
    return (
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
    );
  },

  render() {

    // server change reload
    const dev = this.props.env === 'dev';
    let reloadJs = null;
    if (dev) reloadJs = <script src='/dist/reload-client.js'></script>
    const ieComment = `
      <!--[if lt IE 9]>
          <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
      <![endif]--> 
    `;

    return (
      <html lang='en'>
        { this.renderHead() }
        <body className="fade in">
          <Nav />
          <div name="browser-upgrade-cc" dangerouslySetInnerHTML={{__html: ieComment}}></div>
          {this.props.children}
          { reloadJs }
        </body>
      </html>
    );
  }

});

module.exports = DefaultLayout;
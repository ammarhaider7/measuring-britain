const React = require('react');	

const Nav = React.createClass({

  render() {
    return (
		<nav className="mb-navbar">
			<div className="navbar-icon hidden-sm-up">
				<span></span>
				<span></span>
				<span></span>
			</div>
		</nav>
    );
  }
  
});

module.exports = Nav;
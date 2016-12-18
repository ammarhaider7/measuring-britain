const React = require('react');	

const Nav = React.createClass({

  render() {
    return (
		<nav className="navbar navbar-light bg-faded">
			<button className="navbar-toggler hidden-sm-up" type="button" data-toggle="collapse" data-target="#nav-content">
			</button>
			<div className="collapse navbar-toggleable-xs" id="nav-content">
				<a className="navbar-brand" href="#">Logo</a>
				<ul className="nav navbar-nav">
					<li className="nav-item">
						<a className="nav-link" href="#">Link 1</a>
					</li>
					<li className="nav-item">
						<a className="nav-link" href="#">Link 2</a>
					</li>
					<li className="nav-item">
						<a className="nav-link" href="#">Link 3</a>
					</li>
					<li className="nav-item dropdown">
						<a className="nav-link dropdown-toggle" href="http://example.com" id="supportedContentDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
						<div className="dropdown-menu" aria-labelledby="supportedContentDropdown">
							<a className="dropdown-item" href="#">Action</a>
							<a className="dropdown-item" href="#">Another action</a>
							<a className="dropdown-item" href="#">Something else here</a>
						</div>
					</li>
				</ul>
			</div>
		</nav>
    );
  }
  
});

module.exports = Nav;
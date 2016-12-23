import React from 'react'
import { render } from 'react-dom';

const NavbarDynamicContent = React.createClass({

	getInitialState() {
		return {
			navOpen: false
		}
	},

	toggleNav() {
		this.setState((prevState) => {
			return {
				navOpen: !prevState.navOpen
			};
		});
	},

	render() {

		return (
			<div>
				<div 
					className={`navbar-icon hidden-sm-up ${this.state.navOpen ? 'icon-open' : ''}`} 
					onClick={this.toggleNav}
				>
					<span></span>
					<span></span>
					<span></span>
				</div>
				<div className={`off-canvas bg-white ${this.state.navOpen ? 'open' : ''}`}>
					<ul>
						<li>Item</li>
						<li>Item</li>
						<li>Item</li>
						<li>Item</li>
						<li>Item</li>
					</ul>
				</div>
			</div>
		)

	}

});

export default const NavbarDynamicContent;

// render(<NavbarDynamicContent />,  document.getElementById('NavContent'));
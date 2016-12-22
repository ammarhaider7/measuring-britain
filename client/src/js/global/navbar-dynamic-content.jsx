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
					className={`navbar-icon hidden-sm-up ${this.navOpen ? 'icon-open' : ''}`} 
					onClick={this.toggleNav}
				>
					<span></span>
					<span></span>
					<span></span>
				</div>
				<div className="off-canvas bg-white">
					<ul className="v-flex-container">
						<li className="v-flex-item">Item</li>
						<li className="v-flex-item">Item</li>
						<li className="v-flex-item">Item</li>
						<li className="v-flex-item">Item</li>
						<li className="v-flex-item">Item</li>
					</ul>
				</div>
			</div>
		)

	}

});

render(<NavbarDynamicContent />,  document.getElementById('NavContent'));
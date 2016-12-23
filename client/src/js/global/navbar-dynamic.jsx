import React from 'react'

const NavbarDynamicComponent = React.createClass({

	propTypes: {
		onToggleNav: React.PropTypes.func.isRequired,
		navVisibility: React.PropTypes.string.isRequired
	},

	toggleNav() {
		const { onToggleNav, navVisibility } = this.props;
		let navState = navVisibility === 'OPEN' ? 'ClOSED' : 'OPEN';
		onToggleNav(navState);
	},

	render() {

		return (
			<div>
				<div 
					className={`navbar-icon hidden-sm-up ${this.props.navVisibility === 'OPEN' ? 'icon-open' : ''}`} 
					onClick={this.toggleNav}
				>
					<span></span>
					<span></span>
					<span></span>
				</div>
				<div className={`off-canvas bg-white ${this.props.navVisibility === 'OPEN' ? 'open' : ''}`}>
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

export default NavbarDynamicComponent;

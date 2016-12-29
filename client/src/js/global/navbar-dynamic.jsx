import React, { Component } from 'react'

class NavbarDynamicComponent extends Component {

	constructor(props) {
		super(props);
	}

	state = {
		expandInnerNav: false
	}

	static propTypes = {
		onToggleNav: React.PropTypes.func.isRequired,
		navVisibility: React.PropTypes.string.isRequired
	}

	toggleNav = () => {
		const { onToggleNav, navVisibility } = this.props;
		let navState = navVisibility === 'OPEN' ? 'ClOSED' : 'OPEN';
		onToggleNav(navState);
	}

	expandInnerNav = () => {
		this.setState((state) => state.expandInnerNav = !state.expandInnerNav);
	}

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
					<div className="v-nav-list">
						<div>
							<div className="v-nav-list-item" onClick={this.expandInnerNav}>
								<span>Item</span>
							</div>
							<div className={`inner-nav-list ${this.state.expandInnerNav ? 'open' : ''}`}>
								<span>Item</span>
								<span>Item</span>
								<span>Item</span>
							</div>
						</div>
						<div className="v-nav-list-item">Item</div>
						<div className="v-nav-list-item">Item</div>
						<div className="v-nav-list-item">Item</div>
						<div className="v-nav-list-item">Item</div>
					</div>
				</div>
			</div>
		)

	}

}

export default NavbarDynamicComponent;

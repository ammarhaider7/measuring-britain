import React, { Component } from 'react'

class NavbarDynamicComponent extends Component {

	constructor(props) {
		super(props);
	}

	static propTypes = {
		onToggleNav: React.PropTypes.func.isRequired,
		navVisibility: React.PropTypes.string.isRequired
	}

	state = {
		expandInnerNav: false
	}

	vNavItems = [
		{
			label: 'Census',
			innerNavItems: [{
				label: 'Census Inner nav item 1',
				img: '/dist/img/radiohead.jpg'
			}, {
				label: 'Census Inner nav item 2',
				img: '/dist/img/radiohead.jpg'
			}, {
				label: 'Census Inner nav item 3',
				img: '/dist/img/radiohead.jpg'
			}]
		}, {
			label: 'About',
			innerNavItems: [{
				label: 'About Inner nav item 1',
				img: '/dist/img/radiohead.jpg'
			}, {
				label: 'About Inner nav item 2',
				img: '/dist/img/radiohead.jpg'
			}, {
				label: 'About Inner nav item 3',
				img: '/dist/img/radiohead.jpg'
			}, {
				label: 'About Inner nav item 4',
				img: '/dist/img/radiohead.jpg'
			}, {
				label: 'About Inner nav item 5',
				img: '/dist/img/radiohead.jpg'
			}]
		}, {
			label: 'Demographics',
			innerNavItems: [{
				label: 'Demographics Inner nav item 1',
				img: '/dist/img/radiohead.jpg'
			}]
		}, {
			label: 'Health',
			innerNavItems: [{
				label: 'Health Inner nav item 1',
				img: '/dist/img/radiohead.jpg'
			}, {
				label: 'Health Inner nav item 2',
				img: '/dist/img/radiohead.jpg'
			}]
		}
	]

	toggleNav = () => {
		const { onToggleNav, navVisibility } = this.props;
		let navState = navVisibility === 'OPEN' ? 'ClOSED' : 'OPEN';
		onToggleNav(navState);
	}

	expandInnerNav = (itemLabel) => {
		this.setState((state) => state.expandInnerNav = !state.expandInnerNav);
	}

	renderVNavItems = () => {
		return this.vNavItems.map((item, index) => {

			return (
				<div key={index}>
					<div className="v-nav-list-item" onClick={() => this.expandInnerNav(item.label)}>
						<span>{item.label}</span>
					</div>
					<div className={`inner-nav-list ${this.state.expandInnerNav ? 'open' : ''}`}>
						{ this.renderInnerNavItems(item.label) }
					</div>
				</div>
			);
			
		})
	}

	renderInnerNavItems = (itemLabel) => {
		let innerNavItems = this.vNavItems.filter(item => item.label === itemLabel)[0].innerNavItems;
		return innerNavItems.map((item, index) => <span key={index}>{item.label}</span>)
	}

	render() {

		return (
			<div>
				<div 
					className={`navbar-icon hidden-lg-up ${this.props.navVisibility === 'OPEN' ? 'icon-open' : ''}`} 
					onClick={this.toggleNav}
				>
					<span></span>
					<span></span>
					<span></span>
				</div>
				<div className={`off-canvas bg-white ${this.props.navVisibility === 'OPEN' ? 'open' : ''}`}>
					<div className="v-nav-list">
						{ this.renderVNavItems() }
					</div>
				</div>
			</div>
		)

	}

}

export default NavbarDynamicComponent;

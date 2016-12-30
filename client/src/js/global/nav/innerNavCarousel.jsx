import React, { Component } from 'react'

export default class NavbarCarousel extends Component {

	constructor(props) {
		super(props);
		const { Swiper } = this.props;
		new Swiper('.swiper-container'), {
			slidesPerView: 3,
			spaceBetween: 10
		}
	}

	static propTypes: {
		Swiper: React.PropTypes.object.isRequired
	}

	render() {

		return (
			<div className="swiper-container">
				<div className="swiper-wrapper">
					<div className="swiper-slide">Slide 1</div>
					<div className="swiper-slide">Slide 2</div>
					<div className="swiper-slide">Slide 3</div>
				</div>
			</div>
		)

	}

}
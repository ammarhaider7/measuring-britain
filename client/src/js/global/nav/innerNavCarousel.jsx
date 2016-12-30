import React, { Component } from 'react'
import Swiper from 'swiper';

export default class NavbarCarousel extends Component {

	constructor(props) {
		super(props);
	}

	static propTypes: {
		Swiper: React.PropTypes.object.isRequired
	}

	componentDidMount() {
		new Swiper('.swiper-container'), {
			slidesPerView: 5,
			spaceBetween: 10
		}
	}

	render() {

		return (
			<div className="swiper-container">
				<div className="swiper-wrapper">
					<div className="swiper-slide">Slide 1</div>
					<div className="swiper-slide">Slide 2</div>
					<div className="swiper-slide">Slide 3</div>
					<div className="swiper-slide">Slide 4</div>
					<div className="swiper-slide">Slide 5</div>
					<div className="swiper-slide">Slide 6</div>
				</div>
			</div>
		)

	}

}
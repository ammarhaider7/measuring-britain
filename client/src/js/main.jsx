// Styles
import '../css/index.scss';

import React, { Component } from 'react'
import ReactDOM from 'react-dom';

class Home extends Component {

	render() {
		return (
				<section className="jumbotron text-xs-center">
				<div className="container">
					<h1 className="jumbotron-heading">Album example</h1>
					<p className="lead text-muted">Something short and leading about the collection below—its contents, the creator, etc. Make it short and sweet, but not too short so folks don't simply skip over it entirely.</p>
					<p>
						<a href="#" className="btn btn-primary">Main call to action</a>
					</p>
				</div>
			</section>
		)
	}

}

ReactDOM.render(<Home />,  document.getElementById('body'));
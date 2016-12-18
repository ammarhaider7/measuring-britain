// Styles
import '../css/index.scss';

import React, { Component } from 'react'
import ReactDOM from 'react-dom';

class About extends Component {

	render() {
		return (
			<div className="container">
				<h1>About</h1>
			</div>
		)
	}

}

ReactDOM.render(<About />,  document.getElementById('body'));
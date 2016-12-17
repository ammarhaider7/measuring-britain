// Styles
import '../css/global.scss';

import React, { Component, PropTypes } from 'react'
import ReactDOM from 'react-dom';

class Home extends Component {

	render() {
		return (
			<h1>Hello world!</h1>
		)
	}

}

ReactDOM.render(<Home />,  document.getElementById('body'));
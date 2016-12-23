// Styles
import '../../css/index.scss';

import React, { Component, PropTypes } from 'react'

class CounterComponent extends Component {

  static propTypes = {
    count: PropTypes.number,
    onIncrement: PropTypes.func,
    onDecrement: PropTypes.func
  }

  render() {

    const { count, onIncrement, onDecrement } = this.props

    return (
      <div>
        <p>
          Clicked: {count} times
          {' '}
          <button onClick={onIncrement.bind(this)}>
            +
          </button>
          {' '}
          <button onClick={onDecrement.bind(this)}>
            -
          </button>
        </p>
      </div>
    )
  }
}

export default CounterComponent

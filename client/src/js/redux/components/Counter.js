import React, { Component, PropTypes } from 'react'
import { get } from 'jquery'
import { Observable } from 'rxjs/Observable'
import 'rxjs/add/observable/from';

class Counter extends Component {

  static propTypes = {
    state: PropTypes.object.isRequired,
    onIncrement: PropTypes.func.isRequired,
    onDecrement: PropTypes.func.isRequired,
    onReceiveComments: PropTypes.func
  }

  getComments() {
    const { onReceiveComments } = this.props;
    const response = Observable.from(get('http://jsonplaceholder.typicode.com/posts/1/comments'));

    response.subscribe(comments => onReceiveComments(comments));

  }

  render() {

    const { state, onIncrement, onDecrement } = this.props
    let disabled = state.list.length > 0;

    return (
      <div>
        <p>
          Clicked: {state.value} times
          {' '}
          <button onClick={onIncrement}>
            +
          </button>
          {' '}
          <button onClick={onDecrement}>
            -
          </button>
        </p>
        <p>
          Number of comments: {state.list.length}
          {' '}
          <button onClick={this.getComments.bind(this)} disabled={disabled}>
            { disabled ? 'Disabled' : 'Get comments' }
          </button>
        </p>
      </div>
    )
  }
}

export default Counter

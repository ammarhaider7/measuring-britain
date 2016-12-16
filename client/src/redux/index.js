import React from 'react'
import ReactDOM from 'react-dom'
import { createStore } from 'redux'
import Counter from './components/Counter'
import counter from './reducers'
import { composeWithDevTools } from 'redux-devtools-extension/developmentOnly';

const store = createStore(counter, composeWithDevTools())
const rootEl = document.getElementById('container')

const render = () => ReactDOM.render(
  <Counter
    state={store.getState()}
    onIncrement={() => store.dispatch({ type: 'INCREMENT' })}
    onDecrement={() => store.dispatch({ type: 'DECREMENT' })}
    onReceiveComments={comments => store.dispatch({ type: 'RECEIVE_COMMENTS', comments: comments })}
  />,
  rootEl
)

export default () => {
	render()
	store.subscribe(render)
}

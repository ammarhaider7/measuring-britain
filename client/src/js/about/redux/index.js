import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import reducer from './reducer'
import Counter from './connector'
import { composeWithDevTools } from 'redux-devtools-extension/developmentOnly';

const store = createStore(reducer, composeWithDevTools());

// export default store;
render(
  <Provider store={store}>
    <Counter />
  </Provider>,
  document.getElementById('body')
)
import { createStore } from 'redux'
import reducer from './reducer'
import { composeWithDevTools } from 'redux-devtools-extension/developmentOnly';

const store = createStore(reducer, composeWithDevTools());

export default store;
const defaultState = {
	value: 0,
	list: []
}

export default (state = defaultState, action) => {
  switch (action.type) {
    case 'INCREMENT':
      return { ...state, value: state.value + 1 }
    case 'DECREMENT':
      return { ...state, value: state.value - 1 }
    case 'RECEIVE_COMMENTS':
			return { ...state, list: action.comments }
    default:
      return state
  }
}

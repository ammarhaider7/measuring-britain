const defaultState = {
	navOpen: false
}

export default (state = defaultState, action) => {
  switch (action.type) {
    case 'NAV_OPEN':
      return { ...state, navOpen: true }
    case 'NAV_CLOSE':
      return { ...state, navOpen: false }
    default:
      return state
  }
}

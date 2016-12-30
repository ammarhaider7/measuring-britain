import * as Actions from './actions'

const initialState = {
	navVisibility: Actions.NavVisibility.CLOSED,
	expandedNavItem: null
}

export default (state = initialState, action) => {
  switch (action.type) {
    case Actions.TOGGLE_NAV:
      return { ...state, navVisibility: action.visibility }
    case Actions.EXPAND_NAV_ITEM:
    	return { ...state, expandedNavItem: action.item }
    default:
      return state
  }
}

// export default function createReducer(asyncReducers) {
//   return combineReducers({
//     users,
//     posts,
//     ...asyncReducers
//   });
// }
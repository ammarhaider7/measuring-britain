import { NavVisibility, TOGGLE_NAV } from './actions'

const initialState = {
	navVisibility: NavVisibility.CLOSED
}

export default (state = initialState, action) => {
  switch (action.type) {
    case TOGGLE_NAV:
      return { ...state, navVisibility: action.visibility }
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
import * as Actions from './actions'

const initialState = {
	navVisibility: Actions.NavVisibility.CLOSED,
	expandedNavItem: null,
	swiperRequested: false
}

export default (state = initialState, action) => {
  switch (action.type) {
    case Actions.TOGGLE_NAV:
      return { 
				...state,
				navVisibility: action.visibility,
				swiperRequested: action.swiperRequested
			}
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
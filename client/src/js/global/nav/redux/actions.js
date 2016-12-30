// Action types

export const TOGGLE_NAV = 'TOGGLE_NAV';
export const EXPAND_NAV_ITEM = 'EXPAND_NAV_ITEM';

// other constants

export const NavVisibility = {
  OPEN: 'OPEN',
  CLOSED: 'CLOSED',
}

// action creators

export const toggleNav = (visibility) => {
  return { 
	type: TOGGLE_NAV, 
	visibility
  }
}

export const expandNavItem = (item) => {
	return {
		type: EXPAND_NAV_ITEM,
		item
	}
}
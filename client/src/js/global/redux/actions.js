// Action types

export const TOGGLE_NAV = 'TOGGLE_NAV'

// other constants

export const NavVisibility = {
  OPEN: 'OPEN',
  CLOSED: 'CLOSED',
}

// action creators

export function toggleNav(visibility) {
  return { 
	type: TOGGLE_NAV, 
	visibility
  }
}
// Action types

export const TOGGLE_NAV = 'TOGGLE_NAV'

// other constants

export const NavVisiblity = {
  OPEN: 'OPEN',
  CLOSED: 'CLOSED',
}

// action creators

export function toggleNav(visibility) {
  return { type: NavVisiblity, visibility }
}
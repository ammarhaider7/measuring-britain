import { connect } from 'react-redux'
import { toggleNav, expandNavItem } from './actions'
import NavbarDynamicComponent from '../navbar-dynamic.jsx'

const mapStateToProps = (state) => {
  return {
    navVisibility: state.navVisibility,
    expandedNavItem: state.expandedNavItem
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
      onToggleNav: (visibility) => dispatch(toggleNav(visibility)),
      onExpandNavItem: (item) => dispatch(expandNavItem(item))
    }
}

const NavbarDynamic = connect(
  mapStateToProps,
  mapDispatchToProps
)(NavbarDynamicComponent)

export default NavbarDynamic;
import { connect } from 'react-redux'
import { toggleNav, expandNavItem } from './actions'
import NavbarDynamicComponent from '../navbar-dynamic.jsx'

const mapStateToProps = (state) => {
  return {
    navVisibility: state.navVisibility,
    expandedNavItem: state.expandedNavItem,
    swiperRequested: state.swiperRequested
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
      onToggleNav: (visibility, swiperRequested) => dispatch(toggleNav(visibility, swiperRequested)),
      onExpandNavItem: (item) => dispatch(expandNavItem(item))
    }
}

const NavbarDynamic = connect(
  mapStateToProps,
  mapDispatchToProps
)(NavbarDynamicComponent)

export default NavbarDynamic;
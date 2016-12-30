import { connect } from 'react-redux'
import { toggleNav } from './actions'
import NavbarDynamicComponent from '../navbar-dynamic.jsx'

const mapStateToProps = (state) => {
  return {
    navVisibility: state.navVisibility
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onToggleNav: (visibility) => {
      dispatch(toggleNav(visibility))
    }
  }
}

const NavbarDynamic = connect(
  mapStateToProps,
  mapDispatchToProps
)(NavbarDynamicComponent)

export default NavbarDynamic;
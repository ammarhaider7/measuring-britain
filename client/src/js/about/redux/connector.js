import { connect } from 'react-redux'
import * as Actions from './actions'
import CounterComponent from '../about'

const mapStateToProps = (state) => {
  return {
    count: state.count
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onIncrement: () => {
      dispatch(Actions.incrementCounter())
    },
    onDecrement: () => {
      dispatch(Actions.decrementCounter())
    }
  }
}

const Counter = connect(
  mapStateToProps,
  mapDispatchToProps
)(CounterComponent)

export default Counter;
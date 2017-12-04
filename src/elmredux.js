import React, { Component, Children } from 'react'
import counter from './modules/Counter'
import PropTypes from 'prop-types'
import hoistStatics from 'hoist-non-react-statics'

export const connect = (mapStateToProps, mapDispatchToProps) => {

  const contextTypes = {
    store: storeShape,
  }

  return function wrapWithComponent(WrappedComponent) {
    class Connect extends Component {
      constructor(props, context) {
        super(props, context)
        this.state = {}
        this.store = props.store || context.store
      }
  
      handleChange(storeState) {
        const prevStoreState = this.state.storeState
  
        if (prevStoreState !== storeState) {
          this.setState({storeState})
        }
        console.log(this.state)
      }
  
      componentDidMount() {
        this.store.subscribe(storeState => this.handleChange(storeState))
        this.handleChange()
      }
      
      render() {
        const props = {
          ...mapStateToProps(this.state, this.props)
        }
        return <WrappedComponent {...props} />
      }
    }

    Connect.contextTypes = contextTypes

    return hoistStatics(Connect, WrappedComponent)
  }
}

export function createReducer(elmProgram) {
  const worker = elmProgram.Reducer.worker()
  return {
    dispatch: (action) => {
      const port = worker.ports[action.type]
      port.send(action.payload)
    },
    subscribe: worker.ports.elmToReact.subscribe
  }
}

export class Provider extends Component {
  getChildContext() {
    return { store: this.store }
  }

  constructor(props, context) {
    super(props, context)
    this.store = props.store
  }

  render () {
    return Children.only(this.props.children)
  }
}

const storeShape = PropTypes.shape({
  subscribe: PropTypes.func.isRequired,
  dispatch: PropTypes.func.isRequired,
})

Provider.childContextTypes = {
  store: storeShape.isRequired,
}

export const store = createReducer(counter)
setTimeout(() => store.dispatch({ type: "increment", payload: 1 }), 1000)
setTimeout(() => store.dispatch({ type: "increment", payload: 2 }), 2000)

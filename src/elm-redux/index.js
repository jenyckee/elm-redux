import React, { Component, Children } from 'react'
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
        this.state = {
          storeState: undefined
        }
        this.store = props.store || context.store
      }
  
      handleChange(storeState) {
        const prevStoreState = this.state.storeState
        
        if (prevStoreState !== storeState) {
          this.setState({storeState})
        }
      }

      componentDidMount() {
        this.store.subscribe(storeState => this.handleChange(storeState[1]))
      }

      render() {
        const props = {
          ...mapStateToProps(this.state.storeState, this.props)
        }
        return <WrappedComponent {...props} />
      }
    }

    Connect.contextTypes = contextTypes

    return hoistStatics(Connect, WrappedComponent)
  }
}

export function createReducer(elmProgram, key) {
  const worker = elmProgram[key].worker()
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


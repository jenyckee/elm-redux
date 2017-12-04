import './main.css';
import registerServiceWorker from './registerServiceWorker';
import { Provider } from 'react-redux'
import { ConnectedRouter } from 'react-router-redux'
import React from 'react'
import ReactDOM from 'react-dom'
import store, { history } from './store'
import {Counter} from './containers/counter'
import {createReducer, connect, Provider as ElmProvider, store as elmStore} from './elmredux'

class Foo extends React.Component {
  constructor (props, context) {
    super(props, context)
  }

  render() {
    return <div>{this.props.value}</div>
  }
}

ReactDOM.render(
  <Provider store={store()}>
    <ConnectedRouter history={history}>
      <Counter />
    </ConnectedRouter>
  </Provider>,
  document.getElementById('root')
);

/* Experimental */

const mapStateToProps = state => {
  const value = state.storeState || false
  return ({
    value: value ? value[1].value : 0
  })
}

const mapDispatchToProps = dispatch => bindActionCreators({
}, dispatch)

const RFoo = connect(mapStateToProps, mapDispatchToProps)(Foo)

ReactDOM.render(
  <ElmProvider store={elmStore}>
    <RFoo/>
  </ElmProvider>,
  document.getElementById('root')
);

registerServiceWorker();

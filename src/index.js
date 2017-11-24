import './main.css';
import registerServiceWorker from './registerServiceWorker';
import { Provider } from 'react-redux'
import { ConnectedRouter } from 'react-router-redux'
import React from 'react'
import ReactDOM from 'react-dom'
import store, { history } from './store'
import {Counter} from './containers/counter'

ReactDOM.render(
  <Provider store={store()}>
    <ConnectedRouter history={history}>
      <Counter />
    </ConnectedRouter>
  </Provider>,
  document.getElementById('root')
);

registerServiceWorker();

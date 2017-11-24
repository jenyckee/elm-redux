import './main.css';
import registerServiceWorker from './registerServiceWorker';
import { Provider } from 'react-redux'
import { ConnectedRouter } from 'react-router-redux'
import App from './components/App'
import React from 'react'
import ReactDOM from 'react-dom'
import store, { history } from './store'
import ReactApp from './components/reactapp'

ReactDOM.render(
  <Provider store={store()}>
    <ConnectedRouter history={history}>
      <div>
        <ReactApp />
      </div>
    </ConnectedRouter>
  </Provider>,
  document.getElementById('root')
);

registerServiceWorker();

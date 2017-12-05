import './main.css';
import registerServiceWorker from './registerServiceWorker';
import React from 'react'
import ReactDOM from 'react-dom'
import { createReducer, connect, Provider } from './elmredux'
import Sitemap from './modules/Sitemap'
import App from './components/App'

const elmStore = createReducer(Sitemap, "Sitemap")
setInterval(() => elmStore.dispatch({ type: "increment", payload: 1 }), 1000)

ReactDOM.render(
  <Provider store={elmStore}>
    <App/>
  </Provider>,
  document.getElementById('root')
);

registerServiceWorker();

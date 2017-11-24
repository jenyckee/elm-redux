import './main.css';
import registerServiceWorker from './registerServiceWorker';
import App from './components/App'
import React from 'react'
import ReactDOM from 'react-dom'

ReactDOM.render(
  <App />,
  document.getElementById('root')
);

registerServiceWorker();

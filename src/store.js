import { createStore, applyMiddleware, compose } from 'redux'
import { routerMiddleware } from 'react-router-redux'
import thunk from 'redux-thunk'
import createHistory from 'history/createBrowserHistory'
import rootReducer from './modules'
import Elm from './modules/Main'
import createElmMiddleware from 'redux-elm-middleware'

export const history = createHistory()

const elmStore = Elm.Reducer.worker()
const { run, elmMiddleware } = createElmMiddleware(elmStore)

const initialState = {}
const enhancers = []
const middleware = [
  thunk,
  routerMiddleware(history),
  elmMiddleware
]

if (process.env.NODE_ENV === 'development') {
  const devToolsExtension = window.devToolsExtension

  if (typeof devToolsExtension === 'function') {
    enhancers.push(devToolsExtension())
  }
}

const composedEnhancers = compose(
  applyMiddleware(...middleware),
  ...enhancers
)

export default () => {
  let store = createStore(
    rootReducer,
    initialState,
    composedEnhancers
  )
  run(store)
  console.log(run.toString())
  return store
}

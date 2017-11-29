import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { reducer as elmReducer } from 'redux-elm-middleware'
import Sitemap from './Sitemap'
import createElmMiddleware from 'redux-elm-middleware'
import counter from './Counter'

console.log(counter)

export default combineReducers({
  router: routerReducer,
  elm: elmReducer,
  counter
})

export const elmMiddleware = createElmMiddleware(Sitemap.Reducer.worker())

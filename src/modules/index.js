import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { reducer as elmReducer } from 'redux-elm-middleware'
import Elm from './Main'
import Sitemap from './Sitemap'
import createElmMiddleware from 'redux-elm-middleware'

export default combineReducers({
  router: routerReducer,
  elm: elmReducer
})

const elmReducers = [
  Sitemap
]

export const elmMiddleware = 
  elmReducers.map(module => createElmMiddleware(module.Reducer.worker()))

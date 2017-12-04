import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { reducer as elmReducer } from 'redux-elm-middleware'
import Sitemap from './Sitemap'
import createElmMiddleware, {createElmReducer} from 'redux-elm-middleware'


export default combineReducers({
  router: routerReducer,
  elm: elmReducer,
})

export const elmMiddleware = createElmMiddleware(Sitemap.Reducer.worker())

import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { reducer as elmReducer } from 'redux-elm-middleware'

export default combineReducers({
  router: routerReducer,
  elm: elmReducer
})

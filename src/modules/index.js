import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import elmReducer from './elmreducer'

export default combineReducers({
  router: routerReducer,
  elmReducer: elmReducer
})

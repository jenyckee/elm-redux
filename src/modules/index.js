import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { reducer as elmReducer } from 'redux-elm-middleware'
import Sitemap from './Sitemap'
import createElmMiddleware, {createElmReducer} from 'redux-elm-middleware'
import counter from './Counter'

function createReducer(elmProgram) {
  const worker = elmProgram.Reducer.worker()
  worker.ports.elmToRedux.subscribe(model => console.log(model))
  return (model, action) => {
    const port = worker.ports[action.type]
    port.send(action.payload)
  }
}

const counterReducer = createReducer(counter)
console.log(counterReducer({ value: 1 }, { type: "increment", payload: 1 }))
setTimeout(() => counterReducer({ value: 1 }, { type: "increment", payload: 1 }), 1000)

export default combineReducers({
  router: routerReducer,
  elm: elmReducer,
})

export const elmMiddleware = createElmMiddleware(Sitemap.Reducer.worker())

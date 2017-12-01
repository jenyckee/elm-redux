import React from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Button } from '../components/button'

function refresh(dispatch) {
  dispatch({type: 'INCREMENT', payload: { x: 0, y:0 }})
}

export const Counter = connect(
  ({elm}) => ({ value: elm.value, siteMap: elm.siteMap })
)
(function({dispatch, siteMap = []}) {
  return (
    <div>
      <button onClick={() => refresh(dispatch)}>REFRESH!</button>
      <ul>{siteMap.map(page => <li key={page.Id}>{page.Id}</li>)}</ul>
    </div>
  );
});
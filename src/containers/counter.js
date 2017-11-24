import React from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Button } from '../components/button'

export const Counter = connect(
  ({elm}) => ({ value: elm.value, siteMap: elm.siteMap })
)
(function({dispatch, siteMap = []}) {
  return (
    <div>
      {siteMap.map(page => <span key={page.Id}>{page.Id}</span>)}
    </div>
  );
});
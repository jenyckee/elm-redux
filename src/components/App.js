import React from 'react'
import ReactDOM from 'react-dom'
import * as R from 'ramda'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'

class App extends React.Component {
  render() {
    return <div/>
  }
}
const mapStateToProps = state => ({
})

const mapDispatchToProps = dispatch => bindActionCreators({
}, dispatch)

export default connect(mapStateToProps, mapDispatchToProps)(App)

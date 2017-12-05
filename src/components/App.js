import React from 'react'
import ReactDOM from 'react-dom'
import {createReducer, connect, Provider as ElmProvider} from '../elm-redux'

class App extends React.Component {
  render() {
    return (
      <ul>
        {this.props.value.map(s => <li key={s.Id}>{s.FriendlyUrl}</li>)}
      </ul>
    )
  }
}

const mapStateToProps = state => {
  if (!state) {
    return {
      value: []
    }
  } else return ({
    value: state.siteMap
  })
}
const mapDispatchToProps = dispatch => bindActionCreators({
}, dispatch)

export default connect(mapStateToProps, mapDispatchToProps)(App)
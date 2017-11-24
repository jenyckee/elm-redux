import React from 'react'
import ReactDOM from 'react-dom'
import Elm from './react-elm'
import { Main } from '../Main.elm';
import * as R from 'ramda'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { update } from '../modules/elmreducer'

class App extends React.Component {

  constructor() {
    super()
    this.flags = "flags"
    this.state = {
      myPort: (x) => null
    }
  }

  setupPorts(ports) {
    this.setState({
      myPort: ports.myPort.send
    })
    ports.reduce.subscribe(function(model) {
      this.props.update(model)
      console.log(model)
    }.bind(this))
  }

  render() {
    return <Elm src={Main} ports={this.setupPorts.bind(this)} flags={this.flags}/>
  }
}
const mapStateToProps = state => ({
})

const mapDispatchToProps = dispatch => bindActionCreators({
  update: update
}, dispatch)

export default connect(mapStateToProps, mapDispatchToProps)(App)

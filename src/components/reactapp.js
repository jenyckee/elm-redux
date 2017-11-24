import React from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'

class ReactApp extends React.Component {
  render() {
    return (
      <div>
        <label>react input</label>
        <input/>
      </div>)
  }
}
const mapStateToProps = ({elm}) => ({
  tickTock: elm.tickTock
})

const mapDispatchToProps = dispatch => bindActionCreators({
}, dispatch)

export default connect(mapStateToProps, mapDispatchToProps)(ReactApp)

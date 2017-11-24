import React from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { update } from '../modules/elmreducer'

class ReactApp extends React.Component {


  render() {
    return (
      <div>
        <label>react input</label>
        <input/>
      </div>)
  }
}
const mapStateToProps = state => ({
})

const mapDispatchToProps = dispatch => bindActionCreators({
  update: update
}, dispatch)

export default connect(mapStateToProps, mapDispatchToProps)(ReactApp)

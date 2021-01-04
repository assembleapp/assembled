import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

fetch("/graphics?key=/us/usc/t5/s8953")
.then(response => response.json())
.then(response => console.log(response))

const Hello = props => (
  <div>Hello {props.name}!</div>
)

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})

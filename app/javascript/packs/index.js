import React from 'react'
import ReactDOM from 'react-dom'
import { autorun, observable } from "mobx"
import { observer } from "mobx-react"
import styled from "styled-components"

const measures = observable([])
const code = observable.box("/us/usc/t26/s122")

fetch(`/graphics?key=${code}`)
.then(response => response.json())
.then(response => measures.replace(response))

autorun(
  () => console.log(measures.length)
)

const Code = observer(({ code, measures }) => (
  <Box>
    <h2>{code}</h2>

    {measures.length}
    {/* {JSON.stringify(measures, null, 2)} */}
    {renderMeasure(measures.filter(m => m.key === code)[0] || {})}
  </Box>
))

const bluish = "#0a2e7d"
const paleblue = "#7cb1f3"

const Box = styled.div`
background: ${bluish};
color: ${paleblue};
height: 80vh;
width: 40vw;
`

const renderMeasure = (m) => (
  <P>
    {m.body}
  </P>
)

const P = styled.p`
padding: 0.2rem;
`

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Code code={code.get()} measures={measures} />,
    document.body.appendChild(document.createElement('div')),
  )
})

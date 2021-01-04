import React from 'react'
import ReactDOM from 'react-dom'
import { autorun, observable } from "mobx"
import { Observer, observer } from "mobx-react"
import styled from "styled-components"

const measures = observable([])
const code = observable.box("/us/usc/t5/s8953")

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

const bluish = "#aea0da"
const paleblue = "#ae80ea"

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

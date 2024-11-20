import React from 'react'

const Alert: React.FC<{message: string}> = ({message}) => {
  return (

    <div className="alert alert-warning" id="info-div" role="alert">{message}</div>
    

  )
}

export default Alert
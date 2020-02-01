const axios = require('axios')

exports.handler = (event, context, callback) => {
  axios.get(`${event.url}`)
    .then(() => {
      console.log('Success (200)')
      callback(null, {
        statusCode: 200,
        url: event.url
      })
    })
})
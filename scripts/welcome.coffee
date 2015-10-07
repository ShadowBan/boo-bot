module.exports = (robot) ->
  robot.hear /hello/i, (res) ->
    res.send "Welcome!"

  robot.hear /.*/i, (res) ->
   # res.send "Echo"

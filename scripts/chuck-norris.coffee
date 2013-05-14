# Description:
#   Chuck Norris awesomeness
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   @bot chuck norris -- random Chuck Norris awesomeness
#
# Author:
#   dlinsin
#
# Retrieved on 2013-05-13 from https://github.com/github/hubot-scripts/blob/master/src/scripts/chuck-norris.coffee

module.exports = (robot) ->

  robot.respond /(chuck norris)(.*)/i, (msg)->
    askChuck msg, "http://api.icndb.com/jokes/random"

  askChuck = (msg, url) ->
    robot.http(url)
      .get() (err, res, body) ->
        if err
          msg.send "Chuck Norris says: #{err}"
        else
          message_from_chuck = JSON.parse(body)
          if message_from_chuck.length == 0
            msg.send "Achievement unlocked: Chuck Norris is quiet!"
          else
            msg.send message_from_chuck.value.joke

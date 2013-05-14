# Description:
#   PHP's functions reference.
#
# Dependencies:
#   "jsdom": ""
#   "jquery": ""
#
# Configuration:
#   None
#
# Commands:
#   @bot phpdoc <function> - Shows PHP function information.
#
# Author:
#   nebiros
#
# Retrieved on 2013-05-13 from https://github.com/github/hubot-scripts/blob/master/src/scripts/phodoc.coffee

jsdom = require("jsdom").jsdom

module.exports = (robot) ->
  robot.respond /phpdoc (.+)$/i, (msg) ->
    robot
      .http("http://www.php.net/manual/en/function." + msg.match[1].replace(/[_-]+/, "-") + ".php")
      .get() (err, res, body) ->
        window = (jsdom body, null,
          features:
            FetchExternalResources: false
            ProcessExternalResources: false
            MutationEvents: false
            QuerySelector: false
        ).createWindow()

        $ = require("jquery").create(window)
        ver = $.trim $(".refnamediv p.verinfo").text()
        desc = $.trim $(".refnamediv span.dc-title").text()
        syn = $.trim $(".methodsynopsis").text().replace(/\s+/g, " ").replace(/(\r\n|\n|\r)/gm, " ")

        if ver and desc and syn
          msg.send "#{ver} - #{desc}"
          msg.send syn
        else
          msg.send "Not found."

# Description:
#   Show your credits, and allow others to add/remove credits from your account.
#
# Dependencies:
#   "underscore": ""
#
# Configuration:
#   None
#
# Commands:
#   @bot show credits - Show your credit balance
#   @bot show credits <username> - Show the user's credit balance
#   @user +1 - Add a credit to a user's account
#   @user -1 - Remove a credit from a user's account
#
# Author:
#   taeram

_ = require 'underscore'

isValidUser = (users, username) ->

    user = _.find users, (user) ->
        if user.mention_name is username
            return true

    if _.isObject user
        return true
    else
        console.log "#{username} is not valid"
        return false

module.exports = (robot) ->
    robot.brain.data.credits ||= {}

    robot.hear /@(.+)\s\+1/, (msg) ->
        username = msg.match[1]
        console.log(username)
        if !isValidUser robot.brain.data.users, username
            return

        if username is msg.message.user.mention_name
            console.log "#{username} cannot modify their own credit level"
            return

        robot.brain.data.credits[username] ||= 0
        robot.brain.data.credits[username]++

        console.log robot.brain.data.credits

    robot.hear /@(.+)\s\-1/, (msg) ->
        username = msg.match[1]
        if !isValidUser robot.brain.data.users, username
            return

        if username is msg.message.user.mention_name
            console.log "#{username} cannot modify their own credit level"
            return

        robot.brain.data.credits[username] ||= 0
        robot.brain.data.credits[username]--

        console.log robot.brain.data.credits

    robot.respond /show credits\s*(.*)/, (msg) ->
        username = msg.match[1]
        if _.isEmpty username
            username = msg.message.user.mention_name

        if !isValidUser robot.brain.data.users, username
            msg.send username + ' not found'
            return

        if _.has robot.brain.data.credits, username
            score = robot.brain.data.credits[username]
        else
            score = 0

        msg.send username + ' has ' + score + ' credits'

        console.log robot.brain.data.credits


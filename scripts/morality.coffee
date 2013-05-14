# Description:
#   Watch your language!
#
# Dependencies:
#   "underscore": ""
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   whitman
#
# Retrieved on 2013-05-13 from https://github.com/github/hubot-scripts/blob/master/src/scripts/demolition-man.coffee

_ = require 'underscore'

module.exports = (robot) ->
    robot.brain.data.credits ||= {}

    words = [
        'arse',
        'ass',
        'asshole',
        'balls',
        'bastard',
        'bitch',
        'bugger',
        'bollocks',
        'bullshit',
        'cock',
        'crap',
        'cunt',
        'damn',
        'damned',
        'damnit',
        'dammit',
        'dick',
        'dicks',
        'douche',
        'fag',
        'fuck',
        'fucker',
        'fucked',
        'fucking',
        'piss',
        'shit',
        'wank'
    ]
    regex = new RegExp('(?:^|\\s)(' + words.join('|') + ')(?:\\s|\\.|\\?|!|$)', 'ig');

    robot.hear regex, (msg) ->
        username = msg.message.user.mention_name

        robot.brain.data.credits[username] ||= 0

        fine = msg.match.length
        if fine > 1
            credits = fine + ' credits'
        else
            credits = 'one credit'

        robot.brain.data.credits[username] -= fine

        msg.send '@' + username + ' You are fined ' + credits + ' for a violation of the Verbal Morality Statute.'

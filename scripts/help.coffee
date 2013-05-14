# Description:
#   Generates help commands for Hubot.
#
# Commands:
#   @bot help - Displays all of the help commands that Hubot knows about.
#   @bot help <query> - Displays all help commands that match <query>.
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

module.exports = (robot) ->
  robot.respond /help\s*(.*)?$/i, (msg) ->
    cmds = robot.helpCommands()

    if msg.match[1]
      cmds = cmds.filter (cmd) ->
        cmd.match new RegExp(msg.match[1], 'i')

      if cmds.length == 0
        msg.send "No available commands match #{msg.match[1]}"
        return
    emit = cmds.join "\n"

    unless robot.name.toLowerCase() is 'hubot'
      emit = emit.replace /hubot/ig, robot.name

    msg.send emit

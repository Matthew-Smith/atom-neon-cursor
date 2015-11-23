module.exports =
  config:
    glowColor:
      title: 'Glow Color'
      description: 'Change the glow color of the selector.'
      type: 'color'
      default: 'rgba(75, 213, 255, 1.0)'

    innerColor:
      title: 'Selector Inner Color'
      description: 'The color of the inner of the selector.'
      type: 'color'
      default: 'rgba(97, 210, 255, 1.0)'

    animationType:
      title: 'Cursor idle animation'
      description: 'Change the animation of the cursor when you are not typing'
      type: 'string'
      default: 'flicker'
      enum: [
          'flicker',
          'phase'
      ]

  activate: (state) ->
    console.log 'activate'
    Config = require './config'
    Config.apply()
    # atom.themes.onDidChangeActiveThemes ->
    #   Config = require './config'
    #   Config.apply()

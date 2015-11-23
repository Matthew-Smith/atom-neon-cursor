style = document.createElement 'style'
console.log 'test'
module.exports =
  apply: ->
    root = document.documentElement
    style.type = 'text/css'
    console.log('applying');
    document.querySelector('head atom-styles').appendChild(style)

    # Glow Color
    setGlowColor = (glowColor) ->
      if Number.isInteger(glowColor)
        root.style.fontSize = glowColor + 'px'
      else if glowColor is 'Auto'
        root.style.fontSize = ''

    atom.config.onDidChange 'neon-cursor.glowColor', ->
      setGlowColor(atom.config.get('neon-cursor.glowColor'))

    setGlowColor(atom.config.get('neon-cursor.glowColor'))


  deactivate: (state) ->
    document.querySelector('head atom-styles').removeChild style

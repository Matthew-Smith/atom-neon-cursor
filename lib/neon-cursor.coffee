module.exports = neonCursor =
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
    atom.workspace.observeTextEditors @init
    atom.config.onDidChange 'neon-cursor.glowColor', @setGlowColor

  setGlowColor: (event) ->
    for textEditor in atom.workspace.getTextEditors()
      neonCursor.setEditor textEditor, event.newValue, event.oldValue

  deactivate: ->


  serialize: ->

  init: (textEditor) ->
    color = atom.config.get 'neon-cursor.glowColor'
    neonCursor.setEditor textEditor, color

  setEditor: (textEditor, newValue, oldValue) ->
    textEditorView = atom.views.getView textEditor

    if textEditorView.shadowRoot
      classList = textEditorView.shadowRoot.querySelector('.editor--private').classList
    else
      classList = textEditorView.classList

    classList.add 'neon-cursor' unless classList.contains 'neon-cursor'
    classList.remove 'neon-cursor-' + oldValue if oldValue
    classList.add 'neon-cursor-' + newValue

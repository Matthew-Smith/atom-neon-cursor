module.exports = neonCursor =
  config:
    glowColor:
      title: 'Glow Color'
      description: 'Change the glow color of the selector.'
      type: 'color'
      default: 'rgba(75,213,255,1.0)'

    innerColor:
      title: 'Selector Inner Color'
      description: 'The color of the inner of the selector.'
      type: 'color'
      default: 'rgba(97,210,255,1.0)'

    animationType:
      title: 'Cursor idle animation'
      description: 'Change the animation of the cursor when you are not typing'
      type: 'string'
      default: 'flicker'
      enum: [
          'flicker',
          'phase'
      ]
      
    cursorType:
      title: 'Cursor Type'
      description: 'Change the cursor between a box and a bar cursor'
      type: 'string'
      default: 'box'
      enum: [
          'box',
          'bar'
      ]

  activate: (state) ->
    atom.workspace.observeTextEditors @init
    atom.config.onDidChange 'neon-cursor.glowColor', @setGlowColor
    atom.config.onDidChange 'neon-cursor.innerColor', @setInnerColor
    atom.config.onDidChange 'neon-cursor.animationType', @setAnimationType
    atom.config.onDidChange 'neon-cursor.cursorType', @setCursorType

  setGlowColor: (event) ->
    newValue = 'glow-color: ' + event.newValue + ';'
    oldValue = 'glow-color: ' + event.oldValue + ';'
    for textEditor in atom.workspace.getTextEditors()
      neonCursor.setEditor textEditor, newValue, oldValue

  setInnerColor: (event) ->
    newValue = 'color: ' + event.newValue + ';'
    oldValue = 'color: ' + event.oldValue + ';'
    for textEditor in atom.workspace.getTextEditors()
      neonCursor.setEditor textEditor, newValue, oldValue

  setAnimationType: (event) ->
    for textEditor in atom.workspace.getTextEditors()
      neonCursor.setEditor textEditor, event.newValue, event.oldValue

  setCursorType: (event) ->
    for textEditor in atom.workspace.getTextEditors()
      neonCursor.setEditor textEditor, event.newValue, event.oldValue

  deactivate: ->

  serialize: ->

  init: (textEditor) ->
    animationType = atom.config.get 'neon-cursor.animationType'
    neonCursor.setEditor textEditor, animationType
    cursorType = atom.config.get 'neon-cursor.cursorType'
    neonCursor.setEditor textEditor, cursorType

  setEditor: (textEditor, newValue, oldValue) ->
    textEditorView = atom.views.getView textEditor

    if textEditorView.shadowRoot
      classList = textEditorView.shadowRoot.querySelector('.editor--private').classList
    else
      classList = textEditorView.classList

    classList.add 'neon-cursor' unless classList.contains 'neon-cursor'
    classList.remove 'neon-cursor-' + oldValue if oldValue
    classList.add 'neon-cursor-' + newValue

class View
  constructor: (config) ->
    @_name = config['cortex-seed.name']

  # During the initialization we set this method to be the onPrepare callback.
  # The Cortex player will call this method whenever it needs this application
  # to render a scene. During the prepare() call the applications are expected
  # to follow the following workflow:
  #
  # prepare:
  #   // At this point you shouldn't make any changes to the DOM, or any other
  #   // changes that might result in visual changes. Instead, it's a good spot
  #   // to make network calls, cache images, do asynchronous work, etc.
  #   makeAPICalls()
  #   then ->
  #     cacheResources()
  #     then ->
  #       offer ->
  #         // When this function gets executed the application is visible
  #         // on screen. Any changes to the DOM will be visible.
  #         makeDOMChanges()
  #         waitSomeTime()
  #         callDone()
  #
  # The key point is to prepare all resource that are going to be used in the
  # scene before you call the 'offer' callback. This is a great way to prevent
  # empty/black screens. For instance, if this view is responsible to display
  # ads, on each prepare call, the application should reach out the ad server.
  # If the ad server returns an ad, the application should download the
  # creative and save it on local disk. Only when everything succeeds, it
  # should submit a view to the player using the 'offer' callback. This way,
  # the player can display some other content or run some other application
  # while this application works on preparing an ad.
  prepare: (offer) =>
    # When this function executes, the application window may or may not be
    # visible. In any case, no DOM changes should happen in this context.
    # Instead, we should prepare all of the resources required by the function
    # that will be passed to the offer().
    container = document.getElementById 'container'

    # Create a "Hello, <name>" text node. The node is not attached to the DOM
    # yet, so it won't be visible even if the application window is visible.
    node = @_createHelloWorldNode()

    # At this point, we have everything we need to display a greeting on
    # screen. We can offer a scene to the player.
    offer (done) =>
      # When the player executes this function, it is guaranteed that the
      # application window is visible. Whatever change you make to the DOM
      # will be visible on screen.

      # Attach the greeting to the DOM. After this call, you'll see the
      # greeting on screen.
      @_render node, container

      # Calling the done() will make the player to move on to the next view.
      # Here we delay to call the done() for 5 seconds. In other words, we
      # want the 'Hello, Cortex' greeting to be on screen for 5 seconds.
      setTimeout done, 5000

  _render: (node, continer) ->
    # Clean up the container before rendering the new scene.
    while continer.firstChild?
      continer.removeChild continer.firstChild

    # Render the new scene.
    continer.appendChild node

  _createHelloWorldNode: ->
    h1 = document.createElement 'h1'
    text = document.createTextNode "Hello, #{@_name}"
    h1.appendChild text

    h1

module.exports = View

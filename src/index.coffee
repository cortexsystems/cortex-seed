View = require './view'

main = ->
  # This is the entry point of the Cortex application.
  # Cortex applications are similar to any other single page web application.
  # The main distinction is when the Cortex player starts an application it
  # injects a Cortex API inside the application.
  #
  # The Cortex API is available to the application after the 'cortex-ready'
  # event. Once the 'cortex-ready' event received, the application can
  # access the Cortex API by 'window.Cortex'.
  #
  # For full documentation see: http://api-doc.cortexpowered.com/ (reach out
  # to Cortex Support for access).
  window.addEventListener 'cortex-ready', ->
    # At this point we can safely use window.Cortex.* calls.
 
    # The following call will fetch the Cortex parameters for this application.
    # Cortex parameters are useful to configure applications without making
    # code changes. You can run the same applications on different locations
    # and make them act differently using the Cortex parameters. For instance,
    # each location might have a different venue id passed. Based on this venue
    # id, the application may decide to show a different advertisement.
    window.Cortex.app.getConfig()
      # config is an object that includes all app parameters set in
      # manifest.json and set by the user using the Cortex Fleet dashboard.
      # For this application, if you don't set any parameters on Fleet,
      # the config will be {name: "Cortex"} based on manifest.json.
      .then (config) ->
        # Here, we create an instance of the View class which is responsible
        # for preparing a scene. It is a good idea to keep a reference to this
        # object globally. This way you can use Cortex dev tools to inspect
        # the state of the View at runtime.
        window.CortexView = new View config

        # Register the onPrepare() handler.
        #
        # Cortex applications don't know about the player or the screen status.
        # Instead, their main duty is to prepare a screen and render it when
        # its asked. This behavior simplifies the applications and reduces
        # developer errors greatly! The Cortex player will periodically call
        # the onPrepare callback of the application. During this call, the
        # application can make network calls, or manipulate the DOM to prepare
        # a scene. Later on, the player will use the output of this call to
        # render the content.
        #
        # For more information see:
        # http://api-doc.cortexpowered.com/class/SchedulerApi.html#onPrepare-dynamic
        window.Cortex.scheduler.onPrepare window.CortexView.prepare
      .catch (e) ->
        console.error 'Failed to initialize the application.', e
        throw e

module.exports = main()

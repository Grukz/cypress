cache   = require("../../cache")
Project = require("../../project")

## global reference to any open projects
openProject = null

module.exports = {
  paths: ->
    cache.getProjectPaths()

  remove: (path) ->
    cache.removeProject(path)

  add: (path) ->
    cache.addProject(path)

  open: (path, options) ->
    ## store the currently open project
    openProject = Project(path)

    openProject
    .open(options)
    .get("settings")

  close: ->
    nullify = ->
      ## null this back out
      openProject = null

      Promise.resolve(null)

    if not openProject
      nullify()
    else
      openProject.close()
      .then(nullify)
}
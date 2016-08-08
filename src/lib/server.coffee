Kue = require 'kue'
Express = require 'express'
BodyParser = require 'body-parser'

{Config, Jobs} = require('docr-common')

log = require('easylog')(module)

log.debug "Configuration", Config

app = Express()
app.use BodyParser.json()
app.use BodyParser.urlencoded(extended:true)
app.use '/kue', Kue.app
app.use '/job', require('./route/job')

log.info "Listening on http://localhost:#{Config.cncPort}"
app.listen Config.cncPort, ->
	[
		'enqueue'
		'start'
		'promotion'
		'progress'
		'failed attempt'
		'failed'
		'complete'
		'remove'
	].map (ev) ->
		log.debug "Mapping stuff"
		Jobs.on "job #{ev}", ->
			log.debug "Queue received #{ev} event", arguments

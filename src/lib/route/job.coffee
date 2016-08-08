module.exports = Router = require('express').Router()
{Config, Jobs} = require('docr-common')

log = require('easylog')(module)

Router.post '/', (req, res, next) ->
	data = req.body
	Jobs
		.create('tesseract', data)
		.priority('critical')
		.attempts(8)
		.backoff(true)
		.removeOnComplete(false)
		.save (err) ->
			if err
				log.error err
				return next err
			log.info "Accepted Job", data
			return res.end()

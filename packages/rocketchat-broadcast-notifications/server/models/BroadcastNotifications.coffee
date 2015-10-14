RocketChat.models.BroadcastNotifications = new class extends RocketChat.models._Base
	constructor: ->
		@_initModel 'broadcast_notifications'

	# FIND ONE
	findOneById: (_id, options) ->
		query =
			_id: _id

		return @findOne query, options

	findLast: (options = {}) ->
		query = {}
		_.extend options, { limit: 1, sort: { ts: -1 } }

		return @find(query, options)?.fetch?()?[0]

	# INSERT
	createWithMessageAndUser: (message, user, extraData) ->
		record =
			ts: new Date
			msg: message
			u:
				_id: user._id
				username: user.username

		_.extend record, extraData
		record._id = @insert record
		return record

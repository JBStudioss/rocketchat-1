Meteor.publish 'broadcast-notifications', ->
	console.log '[publish] broadcast-notifications'.green
	return RocketChat.models.BroadcastNotifications.find {}

Meteor.publish 'broadcast-notifications-last-unread', ->
	console.log '[publish] broadcast-notifications-last-unread'.green

	unless @userId
		return @ready()

	user = RocketChat.models.Users.findOneById @userId
	query = {}

	if user.lastUnreadBroadcastNotification
		query = { ts: { $gt: user.lastUnreadBroadcastNotification } }

	return RocketChat.models.BroadcastNotifications.find query, { limit: 1, sort: { ts: -1 } }

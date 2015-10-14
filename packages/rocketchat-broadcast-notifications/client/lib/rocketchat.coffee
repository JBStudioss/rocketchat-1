RocketChat.BroadcastNotifications.blazeView = {}

RocketChat.BroadcastNotifications.show = (_id) ->
	if RocketChat.BroadcastNotifications.blazeView instanceof Blaze.View
		Blaze.remove RocketChat.BroadcastNotifications.blazeView

	bn = BroadcastNotifications.findOne _id
	RocketChat.BroadcastNotifications.blazeView = Blaze.renderWithData Template.broadcastNotification, bn, document.body

RocketChat.BroadcastNotifications.showLastIfUnread = ->
	if RocketChat.BroadcastNotifications.blazeView instanceof Blaze.View
		Blaze.remove RocketChat.BroadcastNotifications.blazeView

	user = Meteor.user()
	query = {}
	if user?.lastUnreadBroadcastNotification
		query = { ts: { $gt: user.lastUnreadBroadcastNotification } }

	bn = BroadcastNotifications.findOne query, { limit: 1, sort: { ts: -1 } }
	if bn
		RocketChat.BroadcastNotifications.blazeView = Blaze.renderWithData Template.broadcastNotification, bn, document.body

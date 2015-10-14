Meteor.startup ->
	RocketChat.BroadcastNotifications.lastUnreadSubscription = Meteor.subscribe 'broadcast-notifications-last-unread'

	Tracker.autorun (c) ->
		if RocketChat.BroadcastNotifications.lastUnreadSubscription.ready()
			RocketChat.BroadcastNotifications.showLastIfUnread()
			c.stop()

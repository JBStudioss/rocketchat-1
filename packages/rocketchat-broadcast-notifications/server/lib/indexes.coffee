Meteor.startup ->
	Meteor.defer ->
		RocketChat.models.BroadcastNotifications.tryEnsureIndex { 'ts': 1 }, { sparse: 1 }

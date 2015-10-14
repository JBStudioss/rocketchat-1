Package.describe({
	name: 'rocketchat:broadcast-notifications',
	version: '0.0.1',
	summary: 'Broadcast Notifications',
	git: ''
});

Package.onUse(function(api) {
	api.versionsFrom('1.0');

	api.use([
		'coffeescript',
		'less@2.5.0',
		'rocketchat:lib@0.0.1'
	]);

	// Broadcast Notifications
	api.addFiles('lib/rocketchat.coffee', [ 'client', 'server' ]);
	api.addFiles('server/models/BroadcastNotifications.coffee', 'server');

	api.addFiles([
		'client/lib/rocketchat.coffee',
		'client/lib/collection.coffee',
		'client/views/broadcastNotification.html',
		'client/stylesheets/broadcastNotification.less',
		'client/startup.coffee'
	], 'client');

	api.addFiles([
		'server/lib/indexes.coffee',
		'server/lib/rocketchat.coffee',
		'server/lib/publication.coffee'
	], 'server');

	// TAPi18n
	api.use('templating', 'client');
	var _ = Npm.require('underscore');
	var fs = Npm.require('fs');
	tapi18nFiles = _.compact(_.map(fs.readdirSync('packages/rocketchat-broadcast-notifications/i18n'), function(filename) {
		if (fs.statSync('packages/rocketchat-broadcast-notifications/i18n/' + filename).size > 16) {
			return 'i18n/' + filename;
		}
	}));
	api.use('tap:i18n@1.6.1', ['client', 'server']);
	api.imply('tap:i18n');
	api.addFiles(tapi18nFiles, ['client', 'server']);

});

Package.onTest(function(api) {

});

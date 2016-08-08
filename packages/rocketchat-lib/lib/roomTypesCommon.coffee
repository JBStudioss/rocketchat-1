class @roomTypesCommon
	roomTypes: {}
	roomTypesOrder: []
	mainOrder: 1

	### Adds a room type to app
	@param identifier An identifier to the room type. If a real room, MUST BE the same of `db.rocketchat_room.t` field, if not, can be null
	@param order Order number of the type
	@param config
		template: template name to render on sideNav
		icon: icon class
		route:
			name: route name
			action: route action function
	###
	add: (identifier, order, config) ->
		unless identifier?
			identifier = Random.id()

		if @roomTypes[identifier]?
			return false

		if not order?
			order = @mainOrder + 10
			@mainOrder += 10

		# @TODO validate config options
		@roomTypesOrder.push
			identifier: identifier
			order: order
		@roomTypes[identifier] = config

		if config.route?.path? and config.route?.name? and config.route?.action?
			routeConfig =
				name: config.route.name
				action: config.route.action

			if Meteor.isClient
				routeConfig.triggersExit = [ roomExit ]

			FlowRouter.route config.route.path, routeConfig

	###
	@param roomType: room type (e.g.: c (for channels), d (for direct channels))
	@param subData: the user's subscription data
	###
	getRouteLink: (roomType, subData) ->
		unless @roomTypes[roomType]?
			return false

		return FlowRouter.path @roomTypes[roomType].route.name, @roomTypes[roomType].route.link(subData)


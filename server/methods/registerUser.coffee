Meteor.methods
	registerUser: (formData) ->
		if RocketChat.settings.get('Accounts_RegistrationForm') is 'Disabled'
			throw new Meteor.Error 'registration-disabled', 'User registration is disabled'

		else if RocketChat.settings.get('Accounts_RegistrationForm') is 'Secret URL' and (not formData.secretURL or formData.secretURL isnt RocketChat.settings.get('Accounts_RegistrationForm_SecretURL'))
			throw new Meteor.Error 'registration-disabled', 'User registration is only allowed via Secret URL'

		if RocketChat.settings.get('Accounts_NameField') is 'mandatory' and _.isEmpty(_.trim(formData.name))
			throw new Meteor.Error 'mandatory-fields', 'Name_field_is_mandatory'

		if RocketChat.settings.get('Accounts_EmailField') is 'mandatory' and _.isEmpty(_.trim(formData.email))
			throw new Meteor.Error 'mandatory-fields', 'Email_field_is_mandatory'

		userData =
			email: formData.email
			password: formData.pass

		userId = Accounts.createUser userData

		RocketChat.models.Users.setName userId, formData.name

		if userData.email
			Accounts.sendVerificationEmail(userId, userData.email);

		return userId

world menu
menuCommandOn: aBuilder 
	<worldMenu> 
	
	(aBuilder item: #RepoAuthentication)
		with: [
			(aBuilder item: #'ss')
				action: [ self new logInToSqueakSource ].
			(aBuilder item: #'ss3')
				action: [ self new logInToSqueakSource3 ].
			(aBuilder item: #'sthub')
				action: [ self new logInToSmalltalkHub ].
			(aBuilder item: #'Logout of all')
				action: [ self new logOutOfAllRepositories ] ]
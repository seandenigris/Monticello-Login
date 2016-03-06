logging in
logOutOfAllRepositories

	MCHttpRepository allSubInstancesDo: [ :e | e user: ''; password: '' ].
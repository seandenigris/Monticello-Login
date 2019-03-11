Class {
	#name : #MlFrontDesk,
	#superclass : #Object,
	#category : 'MonticelloLogin'
}

{ #category : #'world menu' }
MlFrontDesk class >> menuCommandOn: aBuilder [ 
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
]

{ #category : #'logging in' }
MlFrontDesk >> logInTo: urlRegexString withCredentialsAt: headingString [

	| relevantRepos |
	relevantRepos := MCHttpRepository allSubInstances select: [:each | 
		urlRegexString asRegex matches: each locationWithTrailingSlash ].
	MlConfigurationFile new 
		credentialsFor: headingString
		during: [ :username :password |
			relevantRepos do: [:each | each user: username; password: password ] ]. 
]

{ #category : #'logging in' }
MlFrontDesk >> logInToSmalltalkHub [

	self logInTo: '^http\://w*\.?smalltalkhub.com/.*' withCredentialsAt: 'smalltalkhub'.
]

{ #category : #'logging in' }
MlFrontDesk >> logInToSqueakSource [

	self logInTo: '^http\://w*\.?squeaksource.com.*' withCredentialsAt: 'squeaksource'.
]

{ #category : #'logging in' }
MlFrontDesk >> logInToSqueakSource3 [

	self logInTo: 'http\://ss3.gemstone.com/ss/.*' withCredentialsAt: 'squeaksource3'.
]

{ #category : #'logging in' }
MlFrontDesk >> logOutOfAllRepositories [

	MCHttpRepository allSubInstancesDo: [ :e | e user: ''; password: '' ].
]

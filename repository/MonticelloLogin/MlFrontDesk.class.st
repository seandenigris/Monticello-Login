Class {
	#name : #MlFrontDesk,
	#superclass : #Object,
	#category : #MonticelloLogin
}

{ #category : #'world menu' }
MlFrontDesk class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'MCZ Repos')
		with: [
			(aBuilder item: #'ss3')
				action: [ 
					"Smalltalk tools" WebBrowser openOn: 'http://ss3.gemtalksystems.com/'
					"Per http://forum.world.st/Two-ss3-s-tp5110168p5110170.html, the other URL (http://ss3.gemstone.com/) is obsolete" ].
			(aBuilder item: #'Authentication')
				with: [
					(aBuilder item: #'ss')
						action: [ self new logInToSqueakSource ].
					(aBuilder item: #'ss3')
						action: [ self new logInToSqueakSource3 ].
					(aBuilder item: #'sthub')
						action: [ self new logInToSmalltalkHub ].
					(aBuilder item: #'Logout of all')
						action: [ self new logOutOfAllRepositories ] ] ]
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

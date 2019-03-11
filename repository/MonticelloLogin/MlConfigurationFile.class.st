"
Idea: Install by default with: ""MCSmalltalkhubRepository credentialSource: DpMcConfigurationFile new""
"
Class {
	#name : #MlConfigurationFile,
	#superclass : #Object,
	#classInstVars : [
		'folder'
	],
	#category : 'MonticelloLogin'
}

{ #category : #'as yet unclassified' }
MlConfigurationFile class >> folder [
	^ folder ifNil: [ StartupLoader default preferencesGeneralFolder ]
]

{ #category : #'as yet unclassified' }
MlConfigurationFile class >> folder: aFolder [
	folder := aFolder
]

{ #category : #private }
MlConfigurationFile >> credentialsFor: headingString during: aBlock [

	| heading username password |
	heading := '[', headingString, ']'.
	FileStream fileNamed: self reference fullName do: [ :str |
		[ str nextLine = heading ] whileFalse. "will signal an error if heading is not present"
		username := (str nextLine copyAfter: $=) trimBoth allButFirst allButLast: 2.
		password := (str nextLine copyAfter: $=) trimBoth allButFirst allButLast: 2 ].
	aBlock value: username value: password.
]

{ #category : #'API-mc credentials' }
MlConfigurationFile >> credentialsForSmalltalkHubDuring: aBlock [

	self credentialsFor: 'smalltalkhub' during: aBlock.
]

{ #category : #'API-mc credentials' }
MlConfigurationFile >> credentialsForSqueakSource3During: aBlock [

	self credentialsFor: 'squeaksource3' during: aBlock.
]

{ #category : #'API-mc credentials' }
MlConfigurationFile >> credentialsForSqueakSourceDuring: aBlock [

	self credentialsFor: 'squeaksource' during: aBlock.
]

{ #category : #'API-mc templates' }
MlConfigurationFile >> defaultPasswordFor: repository [

	repository class baseURL asUrl host = 'smalltalkhub.com' ifTrue: [ self credentialsForSmalltalkHubDuring: [ :u :p | ^ p ] ].
	repository class baseURL asUrl host = 'ss3.gemtalksystems.com' ifTrue: [ self credentialsForSqueakSource3During: [ :u :p | ^ p ] ].
	repository class baseURL asUrl host = 'squeaksource.com' ifTrue: [ self credentialsForSqueakSourceDuring: [ :u :p | ^ p ] ].
	^ ''
]

{ #category : #'API-mc templates' }
MlConfigurationFile >> defaultUserFor: repository [

	repository class baseURL asUrl host = 'smalltalkhub.com' ifTrue: [ self credentialsForSmalltalkHubDuring: [ :u :p | ^ u ] ].
	repository class baseURL asUrl host = 'ss3.gemtalksystems.com' ifTrue: [ self credentialsForSqueakSource3During: [ :u :p | ^ u ] ].
	repository class baseURL asUrl host = 'squeaksource.com' ifTrue: [ self credentialsForSqueakSourceDuring: [ :u :p | ^ u ] ].
	^ ''
]

{ #category : #private }
MlConfigurationFile >> folder [
	^ self class folder
]

{ #category : #private }
MlConfigurationFile >> reference [
	^ self folder / '.mcconfig'.
]

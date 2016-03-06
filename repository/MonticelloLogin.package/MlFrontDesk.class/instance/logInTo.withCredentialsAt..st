logging in
logInTo: urlRegexString withCredentialsAt: headingString

	| relevantRepos |
	relevantRepos := MCHttpRepository allSubInstances select: [:each | 
		urlRegexString asRegex matches: each locationWithTrailingSlash ].
	MlConfigurationFile new 
		credentialsFor: headingString
		during: [ :username :password |
			relevantRepos do: [:each | each user: username; password: password ] ]. 
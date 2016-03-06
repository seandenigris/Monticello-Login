private
folder
	^ folder ifNil: [ StartupLoader default preferencesGeneralFolder ]
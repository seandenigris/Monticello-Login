Class {
	#name : #BaselineOfMonticelloLogin,
	#superclass : #BaselineOf,
	#category : 'BaselineOfMonticelloLogin'
}

{ #category : #baseline }
BaselineOfMonticelloLogin >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec package: #MonticelloLogin. ].

]

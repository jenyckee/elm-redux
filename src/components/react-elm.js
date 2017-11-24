import React from 'react';

export default class Elm extends React.Component {
	initialize(node) {
		if (node === null) return;
		var app = this.props.src.embed(node, this.props.flags);

		if (typeof this.props.ports !== 'undefined') {
			this.props.ports(app.ports);
		}
	}

	shouldComponentUpdate(prevProps) {
		return false;
	}

	render () {
		return React.createElement('div', { ref: this.initialize.bind(this) });
	}
}
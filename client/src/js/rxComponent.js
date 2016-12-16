import React, { Component } from 'react';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/observable/dom/ajax'
import 'rxjs/add/operator/map';
import 'rxjs/add/observable/forkJoin';

export default class RxComponent extends Component {

	constructor(props) {
		super(props);
		this.state = {
			users: [],
			todos: []
		}
	}

	componentDidMount() {

		const users = Observable.ajax('https://jsonplaceholder.typicode.com/users').map(res => { return res.response });
		const todos = Observable.ajax('https://jsonplaceholder.typicode.com/todos').map(res => { return res.response });
		
		Observable.forkJoin([users, todos])	
			.subscribe(results => {
				this.setState({
					users: results[0],
					todos: results[1]
				})
			})

	}

	render() {
		return (
			<div>
				<h3>First group</h3>
				<ul className="rxComponent">
					{this.state.users.map(user => <li key={user.id}>{user.name}</li>)}
				</ul>
				<h3>Todos</h3>
				<p>There are {this.state.todos.length} to do's in the list</p>
			</div>
		);
	}
}
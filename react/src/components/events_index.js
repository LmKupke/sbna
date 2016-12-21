import React, { Component } from 'react';
import { connect } from 'react-redux';
import { fetchEventsHome } from '../actions/index';
import { Link } from 'react-router';

class EventsIndex extends Component {
  componentWillMount() {
    this.props.fetchEventsHome();

  }
  renderEvents() {
    return this.props.events.map((event) => {
      return (
        <li className="collection-item" key={event.id}>
          <Link to={"event/" + event.id}>
          <strong>{event.title}</strong>
          </Link>
        </li>
      )
    });
  }

  render() {
    return (
      <div>
        <h3>Upcoming Events</h3>
        <ul className="collection">
          {this.renderEvents()}
        </ul>
      </div>

    );
  }
}

function mapStateToProps(state){
  return { events: state.events.all }
}
export default connect(mapStateToProps, { fetchEventsHome })(EventsIndex);

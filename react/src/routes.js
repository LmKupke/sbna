import React from 'react';
import { Route, IndexRoute } from 'react-router';

import App from './components/app';
import EventsIndex from './components/events_index';

export default (
  <Route path="/" component={App}>
    <IndexRoute component={EventsIndex} />
  </Route>
);

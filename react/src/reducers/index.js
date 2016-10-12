import { combineReducers } from 'redux';
import EventsReducer from './reducer_events';
import { reducer as formReducer } from 'redux-form';

const rootReducer = combineReducers({
  events: EventsReducer,
  form: formReducer
});

export default rootReducer;

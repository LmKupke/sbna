import { FETCH_EVENTS_HOME } from '../actions/index';


const INITIAL_STATE = {all: [], event: null};

export default function(state = INITIAL_STATE, action) {
  switch (action.type) {
  case FETCH_EVENTS_HOME:
    return {...state, all: action.payload.data };
  default:
    return state;
  }
}

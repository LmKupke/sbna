import axios from 'axios';

const ROOT_URL = "http://localhost:3000/api"
export const FETCH_EVENTS_HOME = 'FETCH_EVENTS_HOME';

export function fetchEventsHome() {
  const request = axios.get(`${ROOT_URL}/home`)
  return {
    type: FETCH_EVENTS_HOME,
    payload: request
  };
}

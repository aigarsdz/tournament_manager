import { DIVISIONS } from '../constants';

const token = document.querySelector('meta[name="csrf-token"]').content;

export function createMatches() {
  return fetch(`/matches`, {
    method: 'POST',
    body: JSON.stringify({
      divisions: Object.keys(DIVISIONS)
    }),
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    credentials: 'same-origin'
  }).then(response => {
    if (response.status > 299) {
      throw "Couldn't create matches.";
    }

    return response.json();
  });
}

export function getMatches() {
  return fetch('/matches.json').then(response => {
    if (response.status > 299) {
      throw "Couldn't create matches.";
    }

    return response.json();
  });
}

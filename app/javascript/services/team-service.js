const token = document.querySelector('meta[name="csrf-token"]').content;

export function getTeams() {
  return fetch('/teams', { credentials: 'same-origin' }).then(response => response.json());
}

export function createTeam(teamName) {
  return fetch('/teams', {
    method: 'POST',
    body: JSON.stringify({
      team_name: teamName
    }),
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    credentials: 'same-origin'
  }).then(response => {
    if (response.status > 299) {
      throw "Couldn't add a new team.";
    }

    return response.json();
  });
}

export function destroyTeam(teamId) {
  return fetch(`/teams/${teamId}`, {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    credentials: 'same-origin'
  });
}

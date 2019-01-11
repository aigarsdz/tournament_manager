<template>
  <div class="team-builder-wrapper" :class="{ visible, hidden: !visible}">
    <div class="team-builder">
      <div class="team-form">
        <team-name-field :team-count="teamCount"></team-name-field>
        <team-list :teams="teams"></team-list>
      </div>

      <div class="team-actions">
        <button type="button" class="button-outline" @click="closeTeamBuilder">Close</button>
      </div>
    </div>
  </div>
</template>

<script>
import EventBus from "../event-bus.js";
import TeamList from "./TeamList.vue";
import TeamNameField from "./TeamNameField.vue";
import { getTeams } from "../services/team-service.js";

export default {
  name: "TeamBuilder",
  components: {
    TeamList,
    TeamNameField
  },

  data() {
    return {
      visible: false,
      teams: [],
      removedTeams: []
    };
  },

  computed: {
    teamCount() {
      return this.teams.length;
    }
  },

  mounted() {
    EventBus.$on("manageTeamsClicked", this.openTeamBuilder);
    EventBus.$on("teamRemoved", this.removeTeam);
    EventBus.$on("teamAdded", this.addTeam);
    this.loadTeams();
  },

  methods: {
    openTeamBuilder() {
      this.visible = true;

      this.loadTeams();
    },

    closeTeamBuilder() {
      this.visible = false;
    },

    loadTeams() {
      return getTeams()
        .then(jsonResponse => (this.teams = jsonResponse))
        .then(() => EventBus.$emit("teamCountChanged", this.teams.length));
    },

    addTeam(team) {
      this.teams.unshift(team);
      EventBus.$emit("teamCountChanged", this.teams.length);
    },

    removeTeam(team) {
      if (team.id) {
        this.removedTeams.push(team);
      }

      const teamIndex = this.teams.findIndex(t => t.name == team.name);

      if (teamIndex > -1) {
        this.teams.splice(teamIndex, 1);
      }

      EventBus.$emit("teamCountChanged", this.teams.length);
    }
  }
};
</script>

<style>
.team-builder-wrapper {
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  background-color: rgba(0, 0, 0, 0.8);
}

.hidden {
  display: none;
}

.visible {
  display: flex;
  justify-content: center;
  align-items: center;
}

.team-builder {
  width: 50%;
  height: 80%;
  padding: 20px;
  background-color: white;
  display: flex;
  flex-direction: column;
}

.team-form {
  flex: 1;
  overflow: auto;
}

.team-actions {
  padding: 20px 20px 0;
  background-color: white;
  margin: 0 -20px;
}

.team-name-wrapper {
  position: relative;
}

input.team-name {
  padding-right: calc(1rem * 2 + 14px);
}

.add-team-icon {
  position: absolute;
  top: 0.6rem;
  right: 1rem;
}
</style>


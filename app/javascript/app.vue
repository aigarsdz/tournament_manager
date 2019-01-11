<template>
  <div id="app" class="container">
    <h1 class="app-title">Tournament manager</h1>

    <actions></actions>
    <match-tables></match-tables>
    <p v-show="!allTeamsReady">Add 16 teams to start tournament!</p>
    <p v-show="!matchesLoaded && allTeamsReady">Click "Get tournament results"!</p>
    <team-builder></team-builder>
  </div>
</template>

<script>
import Actions from "./components/Actions.vue";
import TeamBuilder from "./components/TeamBuilder.vue";
import MatchTables from "./components/MatchTables.vue";
import EventBus from "./event-bus";
import { REQUIRED_TEAM_COUNT } from "./constants";

export default {
  components: {
    Actions,
    TeamBuilder,
    MatchTables
  },

  data: function() {
    return {
      allTeamsReady: false,
      matchesLoaded: false
    };
  },

  mounted() {
    EventBus.$on(
      "teamCountChanged",
      count => (this.allTeamsReady = count == REQUIRED_TEAM_COUNT)
    );

    EventBus.$on(
      "matchCountChanges",
      count => (this.matchesLoaded = count > 0)
    );
  }
};
</script>

<style>
.app-title {
  text-align: center;
}
</style>

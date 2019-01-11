<template>
  <div class="match-tables">
    <div v-if="winner">
      <h2>Results</h2>

      <table>
        <tr>
          <td>Winner</td>
          <td>{{this.winner.name}}</td>
        </tr>
      </table>

      <h3>Play-off results</h3>
      <table>
        <tr v-for="match in playOffMatches" :key="`p-${match.first_team}-${match.second_team}`">
          <td>{{match.first_team_name}}</td>
          <td>{{match.first_score}}</td>
          <td>{{match.second_score}}</td>
          <td>{{match.second_team_name}}</td>
        </tr>
      </table>

      <h3>Results for division A</h3>
      <table>
        <tr v-for="match in aDivisionMatches" :key="`a-${match.first_team}-${match.second_team}`">
          <td>{{match.first_team_name}}</td>
          <td>{{match.first_score}}</td>
          <td>{{match.second_score}}</td>
          <td>{{match.second_team_name}}</td>
        </tr>
      </table>

      <h3>Results for division B</h3>
      <table>
        <tr v-for="match in bDivisionMatches" :key="`b-${match.first_team}-${match.second_team}`">
          <td>{{match.first_team_name}}</td>
          <td>{{match.first_score}}</td>
          <td>{{match.second_score}}</td>
          <td>{{match.second_team_name}}</td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import { getMatches } from "../services/match-service";
import { DIVISION_VALUES } from "../constants";
import EventBus from "../event-bus";

export default {
  name: "MatchTables",

  data() {
    return {
      playOffMatches: [],
      aDivisionMatches: [],
      bDivisionMatches: [],
      winner: null
    };
  },

  mounted() {
    getMatches().then(this.updateData);
    EventBus.$on("matchesChanged", this.updateData);
  },

  methods: {
    updateData(data) {
      this.playOffMatches = data.play_off_matches;
      this.aDivisionMatches = data[DIVISION_VALUES.A];
      this.bDivisionMatches = data[DIVISION_VALUES.B];
      this.winner = data.winner;

      EventBus.$emit("matchCountChanges", this.playOffMatches.length);
    }
  }
};
</script>


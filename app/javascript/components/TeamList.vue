<template>
  <table>
    <thead>
      <tr>
        <th>Nr.</th>
        <th>Name</th>
        <th>Division</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(team, index) in teams" :key="team.name">
        <td>{{index + 1}}</td>
        <td>{{team.name}}</td>
        <td>{{DIVISIONS[team.division]}}</td>
        <td>
          <a href="#" @click.prevent="removeTeam(team)">
            <font-awesome-icon icon="times"></font-awesome-icon>
          </a>
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import EventBus from "../event-bus";
import { DIVISIONS } from "../constants.js";
import { destroyTeam } from "../services/team-service";

export default {
  name: "TeamList",
  props: ["teams"],

  data() {
    return {
      DIVISIONS
    };
  },

  methods: {
    removeTeam(team) {
      const token = document.querySelector('meta[name="csrf-token"]').content;

      destroyTeam(team.id).then(() => EventBus.$emit("teamRemoved", team));
    }
  }
};
</script>


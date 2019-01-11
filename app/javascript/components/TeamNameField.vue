<template>
  <div class="team-name-wrapper">
    <input
      type="text"
      v-model="teamName"
      placeholder="Team name"
      autofocus
      class="team-name"
      @keydown.enter="addTeam"
      :disabled="teamCount >= 16"
    >
    <a href="#" @click.prevent="addTeam" class="add-team-icon" v-show="teamName.length > 0">
      <font-awesome-icon icon="save"></font-awesome-icon>
    </a>

    <p v-show="teamCount >= 16" class="team-limit-notice">Only 16 teams are allowed</p>
  </div>
</template>

<script>
import EventBus from "../event-bus";
import { createTeam } from "../services/team-service";

export default {
  name: "TeamNameField",
  props: ["teamCount"],

  data() {
    return {
      teamName: ""
    };
  },

  methods: {
    addTeam() {
      createTeam(this.teamName)
        .then(jsonResponse => {
          EventBus.$emit("teamAdded", jsonResponse);

          this.teamName = "";
        })
        .catch(error => console.error(error));
    }
  }
};
</script>

<style>
.team-limit-notice {
  color: #ff0101;
}
</style>


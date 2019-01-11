<template>
  <div class="actions">
    <action
      :title="a.title"
      :key="a.title"
      @click="a.onClickHandler"
      v-for="a in actions"
      :disabled="a.disabled"
    ></action>
  </div>
</template>

<script>
import Action from "./Action.vue";
import EventBus from "../event-bus";
import { createMatches } from "../services/match-service.js";
import { REQUIRED_TEAM_COUNT } from "../constants";

export default {
  name: "Actions",
  components: {
    Action
  },

  data() {
    return {
      actions: [
        {
          title: "Manage teams",
          onClickHandler: event => {
            EventBus.$emit("manageTeamsClicked");
          }
        },
        {
          title: "Get tournament results",
          disabled: true,
          onClickHandler: event => {
            createMatches().then(jsonResponse =>
              EventBus.$emit("matchesChanged", jsonResponse)
            );
          }
        }
      ]
    };
  },

  mounted() {
    EventBus.$on("teamCountChanged", count => {
      if (count == REQUIRED_TEAM_COUNT) {
        this.actions[1].disabled = false;
      } else {
        this.actions[1].disabled = true;
      }
    });
  }
};
</script>

<template>
  <div>
    <h3>Your Life Achievements</h3>

    <v-layout row wrap>
      <v-flex md12>
        <v-text-field v-model="lifeAchievementName" label="Add Your Achievements"></v-text-field>
      </v-flex>
    </v-layout>

    <v-btn color="success" type="button" @click="addLifeAchievement">Add Life Achievement</v-btn>

    <v-layout row wrap>
      <v-flex md12><h3>Added Life Achievements</h3></v-flex>
      <v-flex md12>
        <v-list>
          <template v-for="(achievement, index) in userData.achievements">
            <v-list-tile
              :key="achievement.name"
            >
              <v-list-tile-content>
                <v-list-tile-title>{{ index + 1 }}. {{ achievement.name }}</v-list-tile-title>
              </v-list-tile-content>

              <v-list-tile-action>
                <v-btn icon ripple @click="deleteLifeAchievement(index)">
                  <v-icon color="grey lighten-1">delete</v-icon>
                </v-btn>
              </v-list-tile-action>
            </v-list-tile>
          </template>
        </v-list>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
  export default {
    name: 'life-achievements',
    props: {
      userData: {
        type: Object,
        required: true
      }
    },
    data () {
      return {
        lifeAchievementName: ''
      }
    },
    methods: {
      addLifeAchievement: function () {
        if (this.lifeAchievementName !== '') {
          this.userData.achievements.push({
            name: this.lifeAchievementName
          });

          this.lifeAchievementName = '';
        }
      },
      deleteLifeAchievement: function (achievementIndex) {
        this.userData.achievements.splice(achievementIndex, 1);
      }
    }
  }
</script>

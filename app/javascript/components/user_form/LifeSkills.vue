<template>
  <div>
    <h3>Your Life Skills</h3>

    <v-layout row wrap>
      <v-flex md12>
        <v-select
          :items="lifeSkills"
          v-model="lifeSkillId"
          item-text="name"
          item-value="id"
          clearable
          label="Add Your Skill / Super Power"
        ></v-select>
      </v-flex>
      <v-flex md12>
        <v-text-field v-model="customLifeSkillName" label="or Add Custom Life Skill"></v-text-field>
      </v-flex>
    </v-layout>

    <v-btn color="success" type="button" @click="addLifeSkill">Add Life Skill</v-btn>

    <v-layout row wrap>
      <v-flex md12><h3>Added Life Skills</h3></v-flex>
      <v-flex md12>
        <v-list>
          <template v-for="(skill, index) in userData.skills">
            <v-list-tile
              :key="skill.name"
            >
              <v-list-tile-content>
                <v-list-tile-title>{{ index + 1 }}. {{ skill.name }}</v-list-tile-title>
              </v-list-tile-content>

              <v-list-tile-action>
                <v-btn icon ripple @click="deleteLifeSkill(index)">
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
    name: 'life-skills',
    props: {
      userData: {
        type: Object,
        required: true
      }
    },
    data () {
      return {
        lifeSkills: [],
        lifeSkillId: null,
        customLifeSkillName: ''
      }
    },
    beforeCreate () {
      this.$axios.get('/life_skills')
        .then((response) => {
          this.lifeSkills = response.data
        });
    },
    methods: {
      addLifeSkill: function () {
        let skillName = '';
        if (this.customLifeSkillName !== '') {
          skillName = this.customLifeSkillName;
        } else {
          const foundSkill = this.lifeSkills.find((e) => e.id === this.lifeSkillId);
          if (foundSkill) {
            skillName = foundSkill.name;
          }
        }

        if (skillName !== '') {
          this.userData.skills.push({
            id: this.lifeSkillId,
            name: skillName
          });

          this.lifeSkillId = null;
          this.customLifeSkillName = '';
        }
      },
      deleteLifeSkill: function (skillIndex) {
        this.userData.skills.splice(skillIndex, 1);
      }
    }
  }
</script>

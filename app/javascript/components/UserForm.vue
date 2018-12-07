<template>
  <v-form @submit.prevent="onSubmit">
    <who-i-am
      :userData="userData"
    ></who-i-am>
    <life-events
      :userData="userData"
    ></life-events>
    <life-skills
      :userData="userData"
    ></life-skills>
    <life-achievements
      :userData="userData"
    ></life-achievements>
    <life-moments
      :userData="userData"
    ></life-moments>

    <v-btn color="success" type="submit">Submit</v-btn>
  </v-form>
</template>

<script>
  import WhoIAm from './user_form/WhoIAm';
  import LifeEvents from './user_form/LifeEvents';
  import LifeSkills from './user_form/LifeSkills';
  import LifeAchievements from './user_form/LifeAchievements';
  import LifeMoments from './user_form/LifeMoments';

  export default {
    components: {
      WhoIAm,
      LifeEvents,
      LifeSkills,
      LifeAchievements,
      LifeMoments
    },
    data () {
      const currentUser = this.$store.getters.currentUser;
      return {
        userData: {
          fullname: currentUser.fullname,
          email: currentUser.email,
          phone: currentUser.phone,
          gender: currentUser.gender,
          city_name: currentUser.city_name,
          looking_for: currentUser.looking_for,
          job_org_name: currentUser.job_org_name,
          job_current_role: currentUser.job_current_role,
          job_about_desc: currentUser.job_about_desc,
          birth_date: currentUser.birth_date || new Date().toISOString().substr(0, 10),
          past_cities: currentUser.past_cities || [],
          events: currentUser.events || [],
          skills: currentUser.skills || [],
          achievements: currentUser.achievements || [],
          answers: currentUser.answers || []
        }
      }
    },
    methods: {
      onSubmit: function () {
        console.log(this.userData);
        this.$axios.patch('/current_user', { user: this.userData })
          .then((response) => {
            console.log(response);
          })
          .catch((error) => {
            console.log(error);
          });
      }
    }
  }
</script>

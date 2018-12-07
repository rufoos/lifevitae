<template>
  <div>
    <h3>Who I am</h3>

    <v-layout row wrap>
      <v-flex md8>
        <v-text-field
          v-model="userData.fullname"
          label="Your Name"
          required
        ></v-text-field>
      </v-flex>
      <v-flex md4>
        <v-select
          :items="genders"
          v-model="userData.gender"
          label="Gender"
        ></v-select>
      </v-flex>
      <v-flex md12>
        <v-text-field
          v-model="userData.email"
          label="E-mail"
          required
        ></v-text-field>
      </v-flex>
    </v-layout>

    <v-menu
      :close-on-content-click="false"
      v-model="datepickerMenu"
      :nudge-right="40"
      lazy
      transition="scale-transition"
      offset-y
      full-width
      min-width="290px"
    >
      <v-text-field
        slot="activator"
        v-model="userData.birth_date"
        label="Birth Date"
        prepend-icon="event"
        readonly
      ></v-text-field>
      <v-date-picker v-model="userData.birth_date" @input="datepickerMenu = false"></v-date-picker>
    </v-menu>

    <v-layout row wrap>
      <v-flex md12>
        <v-text-field v-model="userData.phone" label="Phone Number"></v-text-field>
      </v-flex>
    </v-layout>

    <h3>Other Details</h3>

    <v-layout row wrap>
      <v-flex md6>
        <v-text-field v-model="userData.city_name" label="Current Location"></v-text-field>
      </v-flex>
      <v-flex md12>
        <v-combobox
          v-model="userData.past_cities"
          :items="userData.past_cities"
          label="City you lived in before"
          chips
          clearable
          multiple
        >
          <template slot="selection" slot-scope="data">
            <v-chip
              :selected="data.selected"
              close
              @input="removePastCity(data.item)"
            >
              <strong>{{ data.item }}</strong>
            </v-chip>
          </template>
        </v-combobox>
      </v-flex>
      <v-flex md12>
        <v-text-field v-model="userData.looking_for" label="Looking For"></v-text-field>
      </v-flex>
    </v-layout>

    <h3>Job Details</h3>

    <v-layout row wrap>
      <v-flex md6>
        <v-text-field v-model="userData.job_org_name" label="Organization Name"></v-text-field>
      </v-flex>
      <v-flex md6>
        <v-text-field v-model="userData.job_current_role" label="Current Role"></v-text-field>
      </v-flex>
    </v-layout>

    <v-layout row wrap>
      <v-flex md12>
        <v-textarea v-model="userData.job_about_desc" label="About You"></v-textarea>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
  export default {
    name: 'who-i-am',
    props: {
      userData: {
        type: Object,
        required: true
      }
    },
    data () {
      return {
        datepickerMenu: false,
        genders: [{ value: 'male', text: 'Male' }, { value: 'female', text: 'Female' }]
      }
    },
    methods: {
      removePastCity: function (cityName) {
        this.userData.past_cities.splice(this.userData.past_cities.indexOf(cityName), 1);
        this.userData.past_cities = [...this.userData.past_cities];
      }
    }
  }
</script>

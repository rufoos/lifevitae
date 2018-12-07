<template>
  <div>
    <h3>Your Life Events</h3>

    <v-layout row wrap>
      <v-flex md12>
        <v-select
          :items="lifeEvents"
          v-model="lifeEventId"
          item-text="name"
          item-value="id"
          clearable
          label="Choose Life Event"
        ></v-select>
      </v-flex>
      <v-flex md12>
        <v-text-field v-model="customLifeEventName" label="or Add Custom Life Event"></v-text-field>
      </v-flex>
    </v-layout>

    <v-layout row wrap>
      <v-flex md6>
        <v-select
          :items="lifeEventYears"
          v-model="lifeEventYear"
          clearable
          label="Choose Life Event Year"
        ></v-select>
      </v-flex>
      <v-flex md6>
        <v-radio-group v-model="lifeEventType" row label="Life Event Type">
          <v-radio label="High" value="high"></v-radio>
          <v-radio label="Lows" value="low"></v-radio>
        </v-radio-group>
      </v-flex>
    </v-layout>

    <v-btn color="success" type="button" @click="addLifeEvent">Add Life Event</v-btn>

    <v-layout row wrap>
      <v-flex md12><h3>Added Life Events</h3></v-flex>
      <v-flex md12>
        <v-list two-line>
          <template v-for="(event, index) in userData.events">
            <v-list-tile
              :key="event.name"
            >
              <v-list-tile-content>
                <v-list-tile-title>{{ index + 1 }}. {{ event.name }}</v-list-tile-title>
                <v-list-tile-sub-title>
                  Year: {{ event.year }}, Type: {{ event.event_type }}
                </v-list-tile-sub-title>
              </v-list-tile-content>

              <v-list-tile-action>
                <v-btn icon ripple @click="deleteLifeEvent(index)">
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
    name: 'life-events',
    props: {
      userData: {
        type: Object,
        required: true
      }
    },
    data () {
      const lifeEventYears = [];
      for (let y = new Date().getFullYear(); y >= 1919; y--) {
        lifeEventYears.push(y);
      }
      return {
        lifeEvents: [],
        lifeEventId: null,
        customLifeEventName: '',
        lifeEventYears,
        lifeEventYear: null,
        lifeEventType: 'high'
      }
    },
    beforeCreate () {
      this.$axios.get('/life_events')
        .then((response) => {
          this.lifeEvents = response.data
        });
    },
    methods: {
      addLifeEvent: function () {
        let eventName = '';
        if (this.customLifeEventName !== '') {
          eventName = this.customLifeEventName;
        } else {
          const foundEvent = this.lifeEvents.find((e) => e.id === this.lifeEventId);
          if (foundEvent) {
            eventName = foundEvent.name;
          }
        }

        if (eventName !== '') {
          this.userData.events.push({
            id: this.lifeEventId,
            name: eventName,
            year: this.lifeEventYear,
            event_type: this.lifeEventType
          });

          this.lifeEventId = null;
          this.lifeEventYear = null;
          this.customLifeEventName = '';
          this.lifeEventType = 'high';
        }
      },
      deleteLifeEvent: function (eventIndex) {
        this.userData.events.splice(eventIndex, 1);
      }
    }
  }
</script>

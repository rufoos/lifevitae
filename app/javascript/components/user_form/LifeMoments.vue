<template>
  <div>
    <h3>Your Life Moments</h3>

    <v-item-group>
      <v-container grid-list-md px-0>
        <v-layout wrap>
          <v-flex
            v-for="lifeMoment in lifeMoments"
            :key="lifeMoment.id"
            xs12
            md4
          >
            <v-item>
              <v-card
                :color="chosenLifeMomentIds.indexOf(lifeMoment.id) >= 0 ? 'primary' : ''"
                slot-scope="{}"
                class="d-flex align-center"
                dark
                height="100"
                @click="onClickLifeMoment(lifeMoment.id)"
              >
                <v-scroll-y-transition>
                  <div class="text-xs-center">
                    {{ lifeMoment.main_question }}
                  </div>
                </v-scroll-y-transition>
              </v-card>
            </v-item>
          </v-flex>
        </v-layout>
      </v-container>
    </v-item-group>

    <h3>Answer the questions</h3>

    <v-layout wrap>
      <v-flex
        md12
        v-for="lifeMoment in chosenLifeMoments"
        :key="lifeMoment.id"
      >
        <v-card>
          <v-card-title primary-title>
            <h5 class="headline">{{ lifeMoment.main_question }}</h5>
          </v-card-title>

          <v-card-text>
            <v-textarea
              v-model="findUserAnswer(lifeMoment.id).answer"
              label="Your Answer"
              hint="Describe the moment in 30-40 words"
            ></v-textarea>
          </v-card-text>

          <v-card-actions>
            <v-combobox
              v-model="findUserAnswer(lifeMoment.id).strengths"
              :items="lifeMoment.strengths"
              label="What strengths did you discover in yourself (Choose upto 3 strengths)"
              chips
              clearable
              multiple
            >
              <template slot="selection" slot-scope="data">
                <v-chip
                  :selected="data.selected"
                  close
                  @input="removeAnswerStrength(data.item, lifeMoment.id)"
                >
                  <strong>{{ data.item }}</strong>
                </v-chip>
              </template>
            </v-combobox>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
  export default {
    name: 'life-moments',
    props: {
      userData: {
        type: Object,
        required: true
      }
    },
    data () {
      const chosenLifeMomentIds = this.userData.answers.map((a) => a.life_moment_id);
      return {
        lifeMoments: [],
        chosenLifeMomentIds: chosenLifeMomentIds
      }
    },
    beforeCreate () {
      this.$axios.get('/life_moments')
        .then((response) => {
          this.lifeMoments = response.data
        });
    },
    computed: {
      chosenLifeMoments: function () {
        return this.lifeMoments.filter((m) => this.chosenLifeMomentIds.indexOf(m.id) >= 0);
      },
    },
    methods: {
      onClickLifeMoment: function (lifeMomentId) {
        if (this.chosenLifeMomentIds.indexOf(lifeMomentId) < 0) {
          this.chosenLifeMomentIds.push(lifeMomentId);
          this.userData.answers.push({
            life_moment_id: lifeMomentId,
            answer: '',
            strengths: []
          });
        } else {
          this.chosenLifeMomentIds.splice(this.chosenLifeMomentIds.indexOf(lifeMomentId), 1);
          const userAnswerIndex = this.userData.answers.findIndex((a) => a.life_moment_id === lifeMomentId);
          if (userAnswerIndex) {
            this.userData.answers.splice(userAnswerIndex, 1);
          }
        }
      },
      findUserAnswer: function (lifeMomentId) {
        return this.userData.answers.find((a) => a.life_moment_id === lifeMomentId)
      },
      removeAnswerStrength: function (strengthName, lifeMomentId) {
        this.findUserAnswer(lifeMomentId).strengths.splice(this.userData.past_cities.indexOf(strengthName), 1);
        this.findUserAnswer(lifeMomentId).strengths = [...this.findUserAnswer(lifeMomentId).strengths];
      }
    }
  }
</script>

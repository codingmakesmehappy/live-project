import Vue from 'vue'
import Router from 'vue-router'
import createNews from '@/views/createNews'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: createNews
    }
  ]
})

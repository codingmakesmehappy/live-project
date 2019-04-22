<template>
  <div id="container">
    <el-menu
      background-color="#ffffff00"
      text-color="#ffffff"
      active-text-color="#ffc62a"
      :default-active="activeIndex"
      class="el-menu-demo"
      mode="horizontal"
      style="width: auto; height: 60px; margin-right: 60px; border-bottom: none;"
      @select="handleSelect"
    >
      <el-menu-item index="1" >发布抽奖</el-menu-item>
      <el-menu-item index="2" @click="Go('/')">抽奖资讯</el-menu-item>
      <el-menu-item index="3" disabled>数据分析</el-menu-item>
    </el-menu>
  </div>

</template>

<script>
export default {
  data() {
    return {
      activeIndex: "1",
    };
  },
  methods: {
    Go(str) {
      this.$router.push(`${str}`);
    },

    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    }
  }
};
</script>
<style>
  #container{
    width: 100%; 
    height: 60px;
    display: flex; 
    flex-direction: column; 
    align-items: flex-end; 
  }
</style>

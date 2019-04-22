<template>
  <div style="margin-top:150px; ">
    <el-form ref="form" :model="form" label-width="80px">
      <div class="each">
        <label>关键词</label>
        <el-input v-model="form.words"></el-input>
      </div>
      <div class="each">
        <label>抽奖人数</label>
        <el-input v-model="form.number"></el-input>
      </div>
      <div class="each">
        <label>起止时间</label>
        <el-date-picker
          v-model="form.selecttime"
          type="datetimerange"
          value-format="yyyy-MM-dd HH:mm:ss"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </div>
      <div class="each">
        <label>开奖时间</label>
        <el-date-picker
          v-model="form.publictime"
          value-format="yyyy-MM-dd HH:mm:ss"
          type="datetime"
          placeholder="选择开奖日期时间"
        ></el-date-picker>
      </div>
      <div class="each">
        <label>奖品</label>
        <el-input v-model="form.prizes"></el-input>
      </div>

      <div class="each">
        <label>过滤条件</label>
        <el-radio-group v-model="form.condition" text-color="#ffc62a" fill="#ffc62a">
          <el-radio label="none" style="color:#ffc62a">无过滤</el-radio>
          <el-radio label="normal" style="color:#ffc62a">普通过滤</el-radio>
          <el-radio label="deep" style="color:#ffc62a">深度过滤</el-radio>
        </el-radio-group>
      </div>
      <div class="each">
        <label>活动文案</label>
        <el-input type="textarea" v-model="form.document"></el-input>
      </div>

      <el-form-item>
        <el-button type="warning" @click="onSubmit">立即发布</el-button>
        <el-button type="warning" plain @click="display">中奖名单</el-button>
        <el-dialog title="中奖名单" :visible.sync="dialogTableVisible">
          <el-table stripe :data="gridData">
            <el-table-column property="qq" label="qq"></el-table-column>
            <el-table-column property="nickname" label="昵称"></el-table-column>
            <el-table-column property="prize" label="奖品"></el-table-column>
            <el-table-column property="speakNum" label="有效发言次数"></el-table-column>
          </el-table>
          <el-button type="warning" @click="window.location.href='http://59.77.134.2:9090/uploadFile/getFile'" style="margin-top:30px;">导出文件</el-button>
          <el-button type="warning" @click="window.location.href='http://59.77.134.2:9090/uploadFile/getPoster'" style>导出海报</el-button>
        </el-dialog>
      </el-form-item>
    </el-form>
  </div>
</template>

<style>
.each {
  display: flex;
  margin-bottom: 35px;
}
label {
  margin-right: 30px;
  width: 90px;
  color: #ffc62a;
}
</style>


<script>
import $ from 'jquery'
export default {
  data() {
    return {
      form: {
        words: "",
        number: "",
        selecttime: [],
        publictime: "",
        prizes: "",
        condition: "",
        document: ""
      },
      gridData: [],
      dialogTableVisible: false
    };
  },
  methods: {
    onSubmit() {
      console.log(this.form);
      $.ajax({
        type:'post',
        url:'http://59.77.134.2:9090/option/luckyDraw',
        data:{
          words:this.form.words,
          start:this.form.selecttime[0],
          end:this.form.selecttime[1],
          open:this.form.publictime,
          prize:this.form.prize,
          times:this.form.times,
          condition: this.form.condition,
        },
        crossDomain: true,
        success: function(data){
          if(data.status=="success"){
            alert("发布成功");
          }
          else{
            alert("发布失败");
          }
        },
        fail: function(){
          console.log("function fail");
        }
      })
    },
    display(){
      $.ajax({
        type: 'get',
        url: 'http://59.77.134.2:9090/option/getAwardInfo',
        data:{},
        success:function(data){
          console.log(data);
          if(data.status=="success"){
            this.gridData=data.list;
            this.dialogTableVisible=true;
          }
          else{
            alert("获取失败");
          }
        },
        fail:function(){
          console.log("function fail");
        }
      })



    },

  }
};
</script>
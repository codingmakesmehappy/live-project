
<template>
<div class="create-news">
    <div class="s1">
        <nav-menu/>
    </div>
    <former class="former"></former>
</div>    
</template>

<style>
.create-news
{
    width: 100%;
    padding: 0px 10%;
    box-sizing: border-box;
    background: url("../assets/createbac.png") no-repeat;
    background-size: cover;
}

.s1
{
    width: 100%;
    border-bottom: rgba(0,0,0,0.1) solid thin;
    box-sizing: border-box;
}
.former
{
    width: 50%;
}
</style>

<script>
import navMenu from '@/components/navMenu'
import former from "../components/Form"
export default {
    components:{
        navMenu,
        former
    }
}
</script>


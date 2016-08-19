/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
'use strict'
import React, { Component } from 'react'
import { AppRegistry,StyleSheet,Navigator} from 'react-native'
import HomePage from './jscore/HomePage'

class SimpleWeather extends Component {
	constructor (props) {
    super(props)
  }
	
  render () {
    return (
    	<Navigator style = {styles.container}
    		// 定义启动时加载的路由
    		initialRoute={{
    			component: HomePage
    		}}
    		// 用来渲染navigator栈顶的route里的component页面
    		renderScene={(route, navigator)=>{
    			// route={component: xxx, name: xxx, ...}， navigator.......route 用来在对应界面获取其他键值
    			// {...route.passProps}即就是把passProps里的键值对全部以给属性赋值的方式展开 如：test={10}
    			return <route.component navigator={navigator} {...route} {...route.passProps}/>
    		}}/>
    )
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1
  }
})

AppRegistry.registerComponent('SimpleWeather', () => SimpleWeather);

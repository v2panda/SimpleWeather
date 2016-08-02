
/*
标记js的 严格模式
其一：如果在语法检测时发现语法问题，则整个代码块失效，并导致一个语法异常。
其二：如果在运行期出现了违反严格模式的代码，则抛出执行异常。
*/ 
'use strict'
import React, { Component } from 'react'
import { View, Animated, Image, TouchableHighlight, Text, StyleSheet } from 'react-native'

class HomePage extends Component {
   constructor (...args) {
    super(...args)
    this.state = ({
      isError: false,
      isLoading: true,
      isPlaying: true,
      fadeAnimLogo: new Animated.Value(0), // 设置动画初始值，生成Value对象
      fadeAnimText0: new Animated.Value(0),
      fadeAnimText1: new Animated.Value(0),
      fadeAnimLayout: new Animated.Value(1)
    })
  }
  // render方法之后执行
  async componentDidMount () {
  	// 网络请求
  	try {

  	} catch(error) {

  	}
  }


  render () {

  }

}

var styles = StyleSheet.create({

})

module.exports = HomePage
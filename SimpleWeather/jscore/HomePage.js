
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
      isLoading: false,
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
  	let content
  	if (this.state.isLoading) {
  		content = (<View style={styles.loadingContent}/>)
  	} else {
  		content = (
  		<View style={styles.content}>
  			<Text style={styles.toVideo}>--> 去看视频～</Text>
  		</View>)
  	}
  	return (
  	<View style={styles.content} needsOffscreenAlphaCompositing renderToHardwareTextureAndroid >
        {content}
      </View>
  	)
  }

}

var styles = StyleSheet.create({
	loadingContent: {
		backgroundColor:'black', 
		flex: 1
	},
	content: {
		backgroundColor: '#434243',
    flex: 1
	},
	toVideo: {
		fontSize: 14,
    color: 'white',
    position: 'absolute',
    bottom: 8,
    right: 15
	}
})

module.exports = HomePage
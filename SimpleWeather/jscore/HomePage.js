
/*
标记js的 严格模式
其一：如果在语法检测时发现语法问题，则整个代码块失效，并导致一个语法异常。
其二：如果在运行期出现了违反严格模式的代码，则抛出执行异常。
*/ 
'use strict'
import React, { Component } from 'react'
import { View, ScrollView,Alert, Animated, Image, TouchableHighlight, Text, StyleSheet } from 'react-native'

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
        <View style={styles.topcontent}>
          <TouchableHighlight style={styles.buttonStyle}
            underlayColor={'#333333'}
            onPress={() => Alert.alert(
            'Alert Title',
            'alertMessage',
          )}>
            <Text style={styles.toHistory}>查看</Text>
          </TouchableHighlight>
          <TouchableHighlight style={styles.buttonStyle1}
            underlayColor={'#333333'}
            onPress={() => Alert.alert(
            'Alert Title',
            'alertMessage',
          )}>
            <Text style={styles.toHistory}>查看</Text>
          </TouchableHighlight>
          <TouchableHighlight style={styles.buttonStyle1}
            underlayColor={'#333333'}
            onPress={() => Alert.alert(
            'Alert Title',
            'alertMessage',
          )}>
            <Text style={styles.toHistory}>查看</Text>
          </TouchableHighlight>
          <TouchableHighlight style={styles.buttonStyle1}
            underlayColor={'#333333'}
            onPress={() => Alert.alert(
            'Alert Title',
            'alertMessage',
          )}>
            <Text style={styles.toHistory}>查看</Text>
          </TouchableHighlight>
        </View>
  			<ScrollView contentContainerStyle={styles.scrollView}
          automaticallyAdjustContentInsets={false}>
          <Text style={styles.toVideo}>--> 去看视频～</Text>
          <Text style={styles.toVideo1}>--> 去看视频～</Text>
          <Text style={styles.toVideo2}>--> 去看视频～</Text>
          <Text style={styles.toVideo3}>--> 去看视频～</Text>
          <Text style={styles.toVideo3}>--> 去看视频～</Text>
          <Text style={styles.toVideo3}>--> 去看视频～</Text>
          <Text style={styles.toVideo3}>--> 去看视频～</Text>
        </ScrollView>
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
    flex: 1,
	},
  topcontent: {
    backgroundColor: '#F0FFFF',
    // flex: 1,
    marginTop: 50,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
    marginBottom: 10,
  },
  scrollView: {
    backgroundColor: '#4682B4',
    // flex: 1,
    // justifyContent: 'space-between',
    // justifyContent: 'center',
    alignItems: 'center',
    marginTop: 10
  },
  buttonStyle: {
    backgroundColor: '#87CEEB',
    // alignItems: 'center',
    // justifyContent: 'center',
    // flex: 1,
    height:30,
    width:30,
    // marginTop: 50,
    // marginLeft: 10,
    // marginBottom: 17
  },
  buttonStyle1: {
    backgroundColor: '#87CEEB',
    height:30,
    width:30,
    // marginTop: 50,
    marginLeft: 50,
    // marginBottom: 17
  },
  toHistory: {
    fontSize: 10,
    color: 'white'
  },
	toVideo: {
		fontSize: 36,
    color: 'white',
    // marginTop: 50
    // position: 'absolute',
    // bottom: 80,
    // right: 150
	},
  toVideo1: {
    fontSize: 24,
    color: 'white',
    marginTop: 50
    // position: 'absolute',
    // bottom: 80,
    // right: 105
  },
  toVideo2: {
    fontSize: 14,
    color: 'white',
    marginTop: 50
    // position: 'absolute',
    // bottom: 8,
    // right: 15
  },
  toVideo3: {
    fontSize: 20,
    color: 'white',
    marginTop: 100
    // position: 'absolute',
    // bottom: 100,
    // right: 135
  }
})

module.exports = HomePage
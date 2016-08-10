
/*
标记js的 严格模式
其一：如果在语法检测时发现语法问题，则整个代码块失效，并导致一个语法异常。
其二：如果在运行期出现了违反严格模式的代码，则抛出执行异常。
*/ 
'use strict'
import React, { Component } from 'react'
import { View, ScrollView,Alert, Animated, Image, TouchableHighlight, Text, StyleSheet } from 'react-native'
import Setting from './Setting'
import RequestUtils from './util/RequestUtils'
import Api from './util/Api'


class HomePage extends Component {
   constructor (...args) {
    super(...args)
    this.state = ({

    })
  }
  // render方法之后执行
  async componentDidMount () {

  	// 网络请求
  	try {
      console.log('start')
    //   var url = 'http://v.juhe.cn/weather/index?cityname=' + '1' + '&key=b211c7e3ca3d1da2a71af0a2f73bf7a5';
    //   RequestUtils.get(url, function(data){
    //   that.setState({
    //     data: data
    //   });
    // }, function(err){
    //     alert(err);
    // });

      RequestUtils.getCity('1',function(data){
        console.log('success')
      }, function(err){
        alert(err);
      });

  	} catch(error) {
      console.log(error)
  	}
  }


  render () {
  	let content
  		content = (
  		<View style={styles.content}>
        <View style={styles.topcontent}>
          <TouchableHighlight style={styles.leftbutton}
            underlayColor={'#333333'}
            onPress={() => {
              this.props.navigator.push({// 活动跳转，以Navigator为容器管理活动页面
                component: Setting,
                title: '233',
              })
            }}>
            <Image source={require('./images/gank_launcher.png')} style={styles.btnimage}/>
          </TouchableHighlight>
          <TouchableHighlight style={styles.rightbutton}
            underlayColor={'#333333'}
            onPress={() => Alert.alert(
            'Alert Title',
            'alertMessage',
          )}>
            <Image source={require('./images/gank_launcher.png')} style={styles.btnimage}/>
          </TouchableHighlight>
        </View>
        <TouchableHighlight style={{flex: 1}}
            underlayColor={'#333333'}
            onPress={() => Alert.alert(
            'Alert Title',
            'alertMessage',
          )}>
  			<ScrollView contentContainerStyle={styles.scrollView}
          automaticallyAdjustContentInsets={false}>
          <Text style={styles.city}>city</Text>
          <Text style={styles.weather}>weather</Text>
          <Text style={styles.temperature}>temperature</Text>
          <Text style={styles.drying}>drying</Text>
          <Text style={styles.wind}>wind</Text>
        </ScrollView>
        </TouchableHighlight>
  		</View>)
  	return (
  	<View style={styles.content} needsOffscreenAlphaCompositing renderToHardwareTextureAndroid >
        {content}
      </View>
  	)
  }

}


var styles = StyleSheet.create({
	content: {
		backgroundColor: '#434243',
    flex: 1,
	},
  topcontent: {
    backgroundColor: '#F0FFFF',
    marginTop: 50,
    alignItems: 'center',
    justifyContent: 'space-between',
    flexDirection: 'row',
  },
  scrollView: {
    backgroundColor: '#4682B4',
    flex: 1,
    // justifyContent: 'space-between',
    // justifyContent: 'center',
    alignItems: 'center',
    marginTop: 10
  },
  leftbutton: {
    backgroundColor: '#87CEEB',
    height:30,
    width:30,
    marginLeft: 10,
  },
  rightbutton: {
    backgroundColor: '#87CEEB',
    height:30,
    width:30,
    marginRight: 10,
  },
  btnimage: {
    height:30,
    width:30,
    alignSelf: 'stretch'
  },
	city: {
		fontSize: 40,
    color: 'white',
    marginTop: 50
	},
  weather: {
    fontSize: 30,
    color: 'white',
    marginTop: 40
  },
  temperature: {
    fontSize: 45,
    color: 'white',
    marginTop: 80
  },
  drying: {
    fontSize: 30,
    color: 'white',
    marginTop: 80
  },
  wind: {
    fontSize: 30,
    color: 'white',
    marginTop: 40
  }
})

module.exports = HomePage
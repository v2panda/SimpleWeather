
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
    	isLoading: true,
    	data: null
    })
  }
  // render方法之后执行
  componentDidMount () {

  	// 网络请求
  	try {

    	var that = this;
      RequestUtils.getCity('1',function(data){
        console.log('success')
        console.log(data.reason + '+' + data.result.today.city)
        that.weatherData = data
        that.setState({
        	isLoading: false,
        	data : data
      	});
      }, function(err){
      	console.log(err)
        // alert(err);
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
            	console.log('onPress'+this.weatherData.reason)
              this.props.navigator.push({// 活动跳转，以Navigator为容器管理活动页面
                component: Setting,
                title: '233',
                passProps: this.weatherData,
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
          	{
          		this.state.data ?
          		<View style={styles.inView}>
          		<Text style={styles.city}>{this.state.data.result.today.city}</Text>
          		<Text style={styles.weather}>{this.state.data.result.today.weather}</Text>
          		<Text style={styles.temperature}>{this.state.data.result.today.temperature}</Text>
          		<Text style={styles.drying}>{this.state.data.result.today.dressing_index}</Text>
         	 		<Text style={styles.wind}>{this.state.data.result.today.wind}</Text>
         	 		</View>
         	 		: RequestUtils.midLoading
          	}
        </ScrollView>
        </TouchableHighlight>
  		</View>)

  		if (this.state.isLoading) {
  			return (<View style={styles.content}>
  				{RequestUtils.toploading}
      		</View>)
  		} else {
  			return (
  				<View style={styles.content}>
  				{content}
      		</View>
  			)
  		}
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
    alignItems: 'center',
    marginTop: 10
  },
  inView: {
  	flex: 1,
    alignItems: 'center',
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
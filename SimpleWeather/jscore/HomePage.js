
/*
标记js的 严格模式
其一：如果在语法检测时发现语法问题，则整个代码块失效，并导致一个语法异常。
其二：如果在运行期出现了违反严格模式的代码，则抛出执行异常。
*/ 
'use strict'
import React, { Component } from 'react'
import { View, ScrollView,Alert, RefreshControl, Image, TouchableOpacity, Text, StyleSheet } from 'react-native'
import Setting from './Setting'
import RequestUtils from './util/RequestUtils'
import Api from './util/Api'


class HomePage extends Component {
   constructor (...args) {
    super(...args)
    this.state = ({
    	isLoading: true,
    	isRefreshing: false,
    	isSevenDay: false,
    	isChange: false,
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
        var array = [];
  			for(var key in data.result.future)
				{
					let week = data.result.future[key].week;
					let weather = data.result.future[key].weather;
					let temperature = data.result.future[key].temperature;
					let space = '  ';
					let string = week + space + weather + space + space + temperature;
 					array.push(string);
				}
				console.log(array);
				that.array = array;
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
  	var scrollViewStyle = {
    	backgroundColor: this.state.isChange ? '#4682B4' : '#434243' ,
    	flex: 1,
    	alignItems: 'center',
  		};
  	var contentStyle = {
			backgroundColor: this.state.isChange ? '#4682B4' : '#434243' ,
   	 	flex: 1,
			};
  	var topcontentStyle = {
    	backgroundColor: this.state.isChange ? '#4682B4' : '#434243' ,
    	marginTop: 50,
   		alignItems: 'center',
   	 	justifyContent: 'space-between',
    	flexDirection: 'row',
  		};
  			content = (
  		<View style={contentStyle}>
        <View style={topcontentStyle}>
          <TouchableOpacity style={styles.leftbutton}
            onPress={() => (this.setState({isChange: !this.state.isChange})) }>
            <Image source={require('./images/btn_color.png')} style={styles.btnimage}/>
          </TouchableOpacity>
          <TouchableOpacity style={styles.rightbutton}
            onPress={() => (this.setState({isSevenDay: !this.state.isSevenDay}))}>
            <Image source={require('./images/btn_seven.png')} style={styles.btnimage}/>
          </TouchableOpacity>
        </View>
 
  			<ScrollView 
  				contentContainerStyle={scrollViewStyle}
          automaticallyAdjustContentInsets={false}
          refreshControl={
          <RefreshControl
            refreshing={this.state.isRefreshing}
            onRefresh={this._refresh.bind(this)}
            tintColor='#F8F8FF'
            title='Loading...'
            progressBackgroundColor='#F8F8FF'/>
        	}>
          	{
          		this.state.data ?
          		<View style={styles.inView}>
          			{
          				this.state.isSevenDay ?
          				<View style={styles.inView}>
          				<Text style={styles.city}>{this.state.data.result.today.city}</Text>
          				<Text style={styles.sevenDay}>{this.array[0]}</Text>
          				<Text style={styles.sevenDay}>{this.array[1]}</Text>
          				<Text style={styles.sevenDay}>{this.array[2]}</Text>
         	 				<Text style={styles.sevenDay}>{this.array[3]}</Text>
         	 				<Text style={styles.sevenDay}>{this.array[4]}</Text>
         	 				<Text style={styles.sevenDay}>{this.array[5]}</Text>
         	 				<Text style={styles.sevenDay}>{this.array[6]}</Text>
          				</View>
          			:
          				<View style={styles.inView}>
          				<Text style={styles.city}>{this.state.data.result.today.city}</Text>
          				<Text style={styles.weather}>{this.state.data.result.today.weather}</Text>
          				<Text style={styles.temperature}>{this.state.data.result.today.temperature}</Text>
          				<Text style={styles.drying}>{this.state.data.result.today.dressing_index}</Text>
         	 				<Text style={styles.wind}>{this.state.data.result.today.wind}</Text>
          				</View>
          			}
         	 		</View>
         	 		: null
          	}
        </ScrollView>

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

  async _refresh () {
  	if (this.state.isRefreshing) {
      return
    }
    this.setState({isRefreshing: true})

  	// 网络请求
  	try {
    	var that = this;
      RequestUtils.getCity('1',function(data){
        console.log('success')
        console.log(data.reason + '+' + data.result.today.city)
        that.setState({
        	isLoading: false,
        	data : data,
        	isRefreshing: false
      	})
      }, function(err){
      	console.log(err)
      });

  	} catch(error) {
      console.log(error)
      this.setState({
        isRefreshing: false
      })
  	}
  }


}


var styles = StyleSheet.create({
	content: {
		backgroundColor: '#434243',
    flex: 1,
	},
  topcontent: {
    backgroundColor: '#4682B4',
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
    // backgroundColor: '#87CEEB',
    height:30,
    width:30,
    marginLeft: 10,
  },
  rightbutton: {
    // backgroundColor: '#87CEEB',
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
  },
  sevenDay: {
    fontSize: 20,
    color: 'white',
    marginTop: 40
  }
})

module.exports = HomePage
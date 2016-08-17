
/*
标记js的 严格模式
其一：如果在语法检测时发现语法问题，则整个代码块失效，并导致一个语法异常。
其二：如果在运行期出现了违反严格模式的代码，则抛出执行异常。
*/ 
'use strict'
import React, { Component } from 'react'
import { View, ScrollView, Alert, RefreshControl, Image, PickerIOS, TouchableOpacity, Text, StyleSheet } from 'react-native'
import AboutPage from './AboutPage'
import RequestUtils from './util/RequestUtils'
import Storage from './util/Storage'


class HomePage extends Component {
   constructor (...args) {
    super(...args)
    this.dateArray = ['#4682B4','#434243','#E03333','#22B573']
    this.state = ({
      isLoading: true,
      isRefreshing: false,
      isSevenDay: false,
      isChange: false,
      colorCount: 0,
      bgColor: this.dateArray[0],
      longitude: 'unknown',
      latitude: 'unknown',
      data: null
    })
  }
  // render方法之后执行
  componentDidMount () {
  	var that = this;

    console.log('componentDidMount' + this.getColorCount())
    // 网络请求


    try {
    	// this.getlocate();
    }catch(error){
    	console.log(error)
    }

    try {
      
      var that = this;
      RequestUtils.getCity('14',function(data){
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
      });

    } catch(error) {
      console.log(error)
    }
  }


  render () {
    let content
    console.log('xixi' + this.dateArray[this.state.colorCount] +'xixi'+ this.state.bgColor);
    var scrollViewStyle = {
      backgroundColor: this.dateArray[this.state.colorCount],
      flex: 1,
      alignItems: 'center',
      };
    var contentStyle = {
      backgroundColor: this.dateArray[this.state.colorCount],
      flex: 1,
      };
    var topcontentStyle = {
      backgroundColor: this.dateArray[this.state.colorCount],
      marginTop: 50,
      alignItems: 'center',
      justifyContent: 'space-between',
      flexDirection: 'row',
      };
        content = (
      <View style={contentStyle}>
        <View style={topcontentStyle}>
        	<TouchableOpacity style={styles.morebutton}
            onPress={() => {
            	this.props.navigator.push({
              component: AboutPage
           		})
            } }>
            <Image source={require('./images/btn_more.png')} style={styles.btnimage}/>
          </TouchableOpacity>
          <TouchableOpacity style={styles.colorbutton}
            onPress={() => (this.changeColor()) }>
            <Image source={require('./images/btn_color.png')} style={styles.btnimage}/>
          </TouchableOpacity>
          <TouchableOpacity style={styles.sevenbutton}
            onPress={() => (this.setState({isSevenDay: !this.state.isSevenDay}))}>
            <Image source={require('./images/btn_seven.png')} style={styles.btnimage}/>
          </TouchableOpacity>
          <TouchableOpacity style={styles.locationbutton}
            onPress={() => (this.getlocate())}>
            <Image source={require('./images/btn_location.png')} style={styles.btnimage}/>
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

  getlocate () {
  	var that = this;
  	navigator.geolocation.getCurrentPosition(
      (position) => {
        var initialPosition = JSON.parse(JSON.stringify(position));//JSON.stringify(position);
        var longitude = initialPosition.coords.longitude;
        var latitude = initialPosition.coords.latitude;
        this.setState({longitude,latitude});
        console.log('getCurrentPosition' + longitude +'-----' +latitude)
        RequestUtils.getGeo(this.state.longitude,this.state.latitude,function(data){
        	console.log('getGeo')
        	console.log(data.reason + 'getGeo' + data.result.today.city)

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
    	  });

      },
      (error) => alert(error.message),
      {enableHighAccuracy: true, timeout: 20000, maximumAge: 1000}
    );
  }

  async _refresh () {
    if (this.state.isRefreshing) {
      return
    }
    this.setState({isRefreshing: true})

    // 网络请求
    try {
      var that = this;
      RequestUtils.getCity('12',function(data){
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

  changeColor () {
    this.state.colorCount = (this.state.colorCount + 1) % this.dateArray.length;
    console.log('哈哈' + this.state.colorCount);
    console.log('hehe' + this.dateArray[this.state.colorCount]);

    this.setState({bgcolor: this.dateArray[this.state.colorCount]});
    this.saveColorCount(this.state.colorCount);
    
  }

  saveColorCount (count) {
    global.storage.save({
      key: 'colorCount',
      rawData: {
        colorCount: count,
      },
      expires: null,
    })
  }

  getColorCount () {
    global.storage.load({
      key: 'colorCount',
     }).then(ret => {
        console.log(ret.colorCount);
        this.setState({
          colorCount: ret.colorCount
        })
      }).catch(err => {
        console.warn(err);
        this.setState({
          colorCount: 0
        })
    })
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
  morebutton: {
    height:30,
    width:30,
    marginLeft: 10,
  },
  colorbutton: {
    height:30,
    width:30,
    marginLeft: -100,
  },
  sevenbutton: {
    height:30,
    width:30,
    marginRight: -100,
  },
  locationbutton: {
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
'use strict'
import React, { Component } from 'react'
import { View, ScrollView,Alert, Animated, Image, TouchableHighlight, Text, StyleSheet } from 'react-native'

class Setting extends Component {
   constructor (...args) {
    super(...args)
    this.data = this.props.weatherData
    this.state = ({

    })
  }


  async componentDidMount () {
    
  	// 网络请求
  	try {
      console.log(this.props.weatherData.reason)
  	} catch(error) {

  	}
  }

  render () {

  	return (
  	 <View style={styles.container}>

     </View>
  	)
  }
}

	var styles = StyleSheet.create({
		container: {
    	flex: 1,
    	backgroundColor: '#252528'
  	}
	})

	module.exports = Setting

import React, { Component } from 'react'
import { ActivityIndicatorIOS } from 'react-native'

const RequestUtils = {

	  /**
   * 基于fetch的get方法
   * @method post
   * @param {string} url
   * @param {function} callback 请求成功回调
   */
  get: function(url, successCallback, failCallback){
    fetch(url)
      .then((response) => response.text())
      .then((responseText) => {
        console.log(responseText);
        successCallback(JSON.parse(responseText));
      })
      .catch(function(err){
        failCallback(err);
      });
  },


  getCity: function(city, successCallback, failCallback){

  	let url = 'http://v.juhe.cn/weather/index?cityname=' + city + '&key=b211c7e3ca3d1da2a71af0a2f73bf7a5';

    fetch(url)
      .then((response) => response.text())
      .then((responseText) => {
        console.log(responseText);
        successCallback(JSON.parse(responseText));
      })
      .catch(function(err){
        failCallback(err);
      });
  },



  /*loading效果*/
  loading: <ActivityIndicatorIOS color="#3E00FF" style={{marginTop:40}}/>

}

module.exports = RequestUtils
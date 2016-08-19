
import React, { Component } from 'react'
import { ActivityIndicator } from 'react-native'

const RequestUtils = {

	  /**
   * 基于fetch的get方法
   * @param {string} city
   * @param {function} callback 请求成功回调
   */
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

  getGeo: function(lon, lat, successCallback, failCallback){

    let url = 'http://v.juhe.cn/weather/geo?format=2' + '&key=b211c7e3ca3d1da2a71af0a2f73bf7a5' +'&lon=' + lon.toString() + '&lat=' + lat.toString();

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
  toploading: <ActivityIndicator color="#3E00FF" style={{marginTop:40}}/>,

  midloading: <ActivityIndicator color="#3E00FF" style={{marginTop:200}}/>

}

module.exports = RequestUtils
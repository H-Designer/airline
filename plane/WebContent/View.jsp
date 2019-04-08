<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="js/echarts.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.js"></script>
<script type="text/javascript">
	$(function() {
		$("#b1").click(
				function() {
					$.ajax({
						//几个参数需要注意一下
						type : "POST",//方法类型
						dataType : "json",//预期服务器返回的数据类型
						url : "${pageContext.request.contextPath }/Cservlet",//url
						success : function(date) {
						var arr1 = new Array();//names
						var arr2 = new Array();
						for (var i = 0; i < date.length; i++) {
						arr1.push(date[i].split(",")[1]);
						arr2.push(date[i].split(",")[0]);
					}
							var myChart = echarts.init(document.getElementById('main'));
							//指定图表的配置项和数据
							option = {
								xAxis : {
									type : 'category',
									data : arr1
								},
								yAxis : {
									type : 'value'
								},
								series : [ {
									data : arr2,
									type : 'line'
								} ]
							};
							// 使用刚指定的配置项和数据显示图表。
							myChart.setOption(option);
							
							//***********************************
							//          柱状图
							var myChart2 = echarts.init(document.getElementById('zhu'));
							var dataAxis = arr1;
							var data = arr2;
							var yMax = arr2[9]*1.2;
							var dataShadow = [];
							for (var i = 0; i < data.length; i++) {
							    dataShadow.push(yMax);
							}
							option2 = {
							    title: {
							        text: '柱状图',
							       // subtext: 'Feature Sample: Gradient Color, Shadow, Click Zoom'
							    },
							    xAxis: {
							        data: dataAxis,
							        axisLabel: {
							            inside: true,
							            textStyle: {
							                color: '#fff'
							            }
							        },
							        axisTick: {
							            show: false
							        },
							        axisLine: {
							            show: false
							        },
							        z: 10
							    },
							    yAxis: {
							        axisLine: {
							            show: false
							        },
							        axisTick: {
							            show: false
							        },
							        axisLabel: {
							            textStyle: {
							                color: '#999'
							            }
							        }
							    },
							    dataZoom: [
							        {
							            type: 'inside'
							        }
							    ],
							    series: [
							        { // For shadow
							            type: 'bar',
							            itemStyle: {
							                normal: {color: 'rgba(0,0,0,0.05)'}
							            },
							            barGap:'-100%',
							            barCategoryGap:'40%',
							            data: dataShadow,
							            animation: false
							        },
							        {
							            type: 'bar',
							            itemStyle: {
							                normal: {
							                    color: new echarts.graphic.LinearGradient(
							                        0, 0, 0, 1,
							                        [
							                            {offset: 0, color: '#83bff6'},
							                            {offset: 0.5, color: '#188df0'},
							                            {offset: 1, color: '#188df0'}
							                        ]
							                    )
							                },
							                emphasis: {
							                    color: new echarts.graphic.LinearGradient(
							                        0, 0, 0, 1,
							                        [
							                            {offset: 0, color: '#2378f7'},
							                            {offset: 0.7, color: '#2378f7'},
							                            {offset: 1, color: '#83bff6'}
							                        ]
							                    )
							                }
							            },
							            data: data
							        }
							    ]
							};
							// Enable data zoom when user click bar.
							var zoomSize = 6;
							myChart.on('click', function (params) {
							    console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
							    myChart.dispatchAction({
							        type: 'dataZoom',
							        startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
							        endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
							    });
							});
							// 使用刚指定的配置项和数据显示图表。
							myChart2.setOption(option2);
							//*********************************
							//           柱状图jieshu
							//*********************************
							//           饼状图开始
							var myChart3 = echarts.init(document
									.getElementById('bing'));
							option3 = {
								    backgroundColor: '#2c343c',

								    title: {
								        text: 'Customized Pie',
								        left: 'center',
								        top: 20,
								        textStyle: {
								            color: '#ccc'
								        }
								    },

								    tooltip : {
								        trigger: 'item',
								        formatter: "{a} <br/>{b} : {c} ({d}%)"
								    },

								    visualMap: {
								        show: false,
								        min: 80,
								        max: 600,
								        inRange: {
								            colorLightness: [0, 1]
								        }
								    },
								    series : [
								        {
								            name:'访问来源',
								            type:'pie',
								            radius : '55%',
								            center: ['50%', '50%'],
								            data:[
								                {value:arr2[0], name:arr1[0]},
								                {value:arr2[1], name:arr1[1]},
								                {value:arr2[2], name:arr1[2]},
								                {value:arr2[3], name:arr1[3]},
								                {value:arr2[4], name:arr1[4]},
								                {value:arr2[5], name:arr1[5]},
								                {value:arr2[6], name:arr1[6]},
								                {value:arr2[7], name:arr1[7]},
								                {value:arr2[8], name:arr1[8]},
								                {value:arr2[9], name:arr1[9]}
								            ].sort(function (a, b) { return a.value - b.value; }),
								            roseType: 'radius',
								            label: {
								                normal: {
								                    textStyle: {
								                        color: 'rgba(255, 255, 255, 0.3)'
								                    }
								                }
								            },
								            labelLine: {
								                normal: {
								                    lineStyle: {
								                        color: 'rgba(255, 255, 255, 0.3)'
								                    },
								                    smooth: 0.2,
								                    length: 10,
								                    length2: 20
								                }
								            },
								            itemStyle: {
								                normal: {
								                    color: '#c23531',
								                    shadowBlur: 200,
								                    shadowColor: 'rgba(0, 0, 0, 0.5)'
								                }
								            },

								            animationType: 'scale',
								            animationEasing: 'elasticOut',
								            animationDelay: function (idx) {
								                return Math.random() * 200;
								            }
								        }
								    ]
								};
							// 使用刚指定的配置项和数据显示图表。
							myChart3.setOption(option3);
							//************************************
							//                      饼状图结束
						},
						error : function() {
							alert("异常！");
						}
					});
				})
				$("#b2").click(
				function() {
					$.ajax({
						//几个参数需要注意一下
						type : "POST",//方法类型
						dataType : "json",//预期服务器返回的数据类型
						url : "${pageContext.request.contextPath }/OServlet",//url
						success : function(date) {
							var arr1 = new Array();//names
							var arr2 = new Array();
							for (var i = 0; i < date.length; i++) {
								arr1.push(date[i].split(",")[1]);
								arr2.push(date[i].split(",")[0]);
							}
							var myChart = echarts.init(document
									.getElementById('main'));
							//指定图表的配置项和数据
							option = {
								xAxis : {
									type : 'category',
									data : arr1
								},
								yAxis : {
									type : 'value'
								},
								series : [ {
									data : arr2,
									type : 'line'
								} ]
							};
							// 使用刚指定的配置项和数据显示图表。
							myChart.setOption(option);
							
							//***********************************
							//          柱状图
							var myChart2 = echarts.init(document
									.getElementById('zhu'));
							var dataAxis = arr1;
							var data = arr2;
							var yMax = arr2[9]*1.2;
							var dataShadow = [];

							for (var i = 0; i < data.length; i++) {
							    dataShadow.push(yMax);
							}

							option2 = {
							    title: {
							        text: '柱状图',
							       // subtext: 'Feature Sample: Gradient Color, Shadow, Click Zoom'
							    },
							    xAxis: {
							        data: dataAxis,
							        axisLabel: {
							            inside: true,
							            textStyle: {
							                color: '#fff'
							            }
							        },
							        axisTick: {
							            show: false
							        },
							        axisLine: {
							            show: false
							        },
							        z: 10
							    },
							    yAxis: {
							        axisLine: {
							            show: false
							        },
							        axisTick: {
							            show: false
							        },
							        axisLabel: {
							            textStyle: {
							                color: '#999'
							            }
							        }
							    },
							    dataZoom: [
							        {
							            type: 'inside'
							        }
							    ],
							    series: [
							        { // For shadow
							            type: 'bar',
							            itemStyle: {
							                normal: {color: 'rgba(0,0,0,0.05)'}
							            },
							            barGap:'-100%',
							            barCategoryGap:'40%',
							            data: dataShadow,
							            animation: false
							        },
							        {
							            type: 'bar',
							            itemStyle: {
							                normal: {
							                    color: new echarts.graphic.LinearGradient(
							                        0, 0, 0, 1,
							                        [
							                            {offset: 0, color: '#83bff6'},
							                            {offset: 0.5, color: '#188df0'},
							                            {offset: 1, color: '#188df0'}
							                        ]
							                    )
							                },
							                emphasis: {
							                    color: new echarts.graphic.LinearGradient(
							                        0, 0, 0, 1,
							                        [
							                            {offset: 0, color: '#2378f7'},
							                            {offset: 0.7, color: '#2378f7'},
							                            {offset: 1, color: '#83bff6'}
							                        ]
							                    )
							                }
							            },
							            data: data
							        }
							    ]
							};
							// Enable data zoom when user click bar.
							var zoomSize = 6;
							myChart.on('click', function (params) {
							    console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
							    myChart.dispatchAction({
							        type: 'dataZoom',
							        startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
							        endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
							    });
							});
							// 使用刚指定的配置项和数据显示图表。
							myChart2.setOption(option2);
							//*******************************
							//    柱状图结束
							//*********************************
							//           饼状图开始
							var myChart3 = echarts.init(document
									.getElementById('bing'));
							option3 = {
								    backgroundColor: '#2c343c',

								    title: {
								        text: 'Customized Pie',
								        left: 'center',
								        top: 20,
								        textStyle: {
								            color: '#ccc'
								        }
								    },

								    tooltip : {
								        trigger: 'item',
								        formatter: "{a} <br/>{b} : {c} ({d}%)"
								    },

								    visualMap: {
								        show: false,
								        min: 80,
								        max: 600,
								        inRange: {
								            colorLightness: [0, 1]
								        }
								    },
								    series : [
								        {
								            name:'访问来源',
								            type:'pie',
								            radius : '55%',
								            center: ['50%', '50%'],
								            data:[{value:arr2[0], name:arr1[0]},
								                {value:arr2[1], name:arr1[1]},
								                {value:arr2[2], name:arr1[2]},
								                {value:arr2[3], name:arr1[3]},
								                {value:arr2[4], name:arr1[4]},
								                {value:arr2[5], name:arr1[5]},
								                {value:arr2[6], name:arr1[6]},
								                {value:arr2[7], name:arr1[7]},
								                {value:arr2[8], name:arr1[8]},
								                {value:arr2[9], name:arr1[9]}
								                ].sort(function (a, b) { return a.value - b.value; }),
								            roseType: 'radius',
								            label: {
								                normal: {
								                    textStyle: {
								                        color: 'rgba(255, 255, 255, 0.3)'
								                    }
								                }
								            },
								            labelLine: {
								                normal: {
								                    lineStyle: {
								                        color: 'rgba(255, 255, 255, 0.3)'
								                    },
								                    smooth: 0.2,
								                    length: 10,
								                    length2: 20
								                }
								            },
								            itemStyle: {
								                normal: {
								                    color: '#c23531',
								                    shadowBlur: 200,
								                    shadowColor: 'rgba(0, 0, 0, 0.5)'
								                }
								            },

								            animationType: 'scale',
								            animationEasing: 'elasticOut',
								            animationDelay: function (idx) {
								                return Math.random() * 200;
								            }
								        }
								    ]
								};
							// 使用刚指定的配置项和数据显示图表。
							myChart3.setOption(option3);
							//************************************
							//                      饼状图结束
						},
						error : function() {
							alert("异常！");
						}
					});
				})
				
				$("#b3").click(
				function() {
					$.ajax({
						//几个参数需要注意一下
						type : "POST",//方法类型
						dataType : "json",//预期服务器返回的数据类型
						url : "${pageContext.request.contextPath }/TServlet",//url
						success : function(date) {
							var arr1 = new Array();//names
							var arr2 = new Array();
							for (var i = 0; i < date.length; i++) {
								arr1.push(date[i].split(",")[1]);
								arr2.push(date[i].split(",")[0]);
							}
							var myChart = echarts.init(document
									.getElementById('main'));
							//指定图表的配置项和数据
							option = {
								xAxis : {
									type : 'category',
									data : arr1
								},
								yAxis : {
									type : 'value'
								},
								series : [ {
									data : arr2,
									type : 'line'
								} ]
							};
							// 使用刚指定的配置项和数据显示图表。
							myChart.setOption(option);
							//***********************************
							//          柱状图
							var myChart2 = echarts.init(document
									.getElementById('zhu'));
							var dataAxis = arr1;
							var data = arr2;
							var yMax = arr2[9]*1.2;
							var dataShadow = [];

							for (var i = 0; i < data.length; i++) {
							    dataShadow.push(yMax);
							}

							option2 = {
							    title: {
							        text: '柱状图',
							       // subtext: 'Feature Sample: Gradient Color, Shadow, Click Zoom'
							    },
							    xAxis: {
							        data: dataAxis,
							        axisLabel: {
							            inside: true,
							            textStyle: {
							                color: '#fff'
							            }
							        },
							        axisTick: {
							            show: false
							        },
							        axisLine: {
							            show: false
							        },
							        z: 10
							    },
							    yAxis: {
							        axisLine: {
							            show: false
							        },
							        axisTick: {
							            show: false
							        },
							        axisLabel: {
							            textStyle: {
							                color: '#999'
							            }
							        }
							    },
							    dataZoom: [
							        {
							            type: 'inside'
							        }
							    ],
							    series: [
							        { // For shadow
							            type: 'bar',
							            itemStyle: {
							                normal: {color: 'rgba(0,0,0,0.05)'}
							            },
							            barGap:'-100%',
							            barCategoryGap:'40%',
							            data: dataShadow,
							            animation: false
							        },
							        {
							            type: 'bar',
							            itemStyle: {
							                normal: {
							                    color: new echarts.graphic.LinearGradient(
							                        0, 0, 0, 1,
							                        [
							                            {offset: 0, color: '#83bff6'},
							                            {offset: 0.5, color: '#188df0'},
							                            {offset: 1, color: '#188df0'}
							                        ]
							                    )
							                },
							                emphasis: {
							                    color: new echarts.graphic.LinearGradient(
							                        0, 0, 0, 1,
							                        [
							                            {offset: 0, color: '#2378f7'},
							                            {offset: 0.7, color: '#2378f7'},
							                            {offset: 1, color: '#83bff6'}
							                        ]
							                    )
							                }
							            },
							            data: data
							        }
							    ]
							};
							// Enable data zoom when user click bar.
							var zoomSize = 6;
							myChart.on('click', function (params) {
							    console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
							    myChart.dispatchAction({
							        type: 'dataZoom',
							        startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
							        endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
							    });
							});
							// 使用刚指定的配置项和数据显示图表。
							myChart2.setOption(option2);
							//********************************
							//        柱状图结束
							//*********************************
							//           饼状图开始
							var myChart3 = echarts.init(document
									.getElementById('bing'));
							option3 = {
								    backgroundColor: '#2c343c',

								    title: {
								        text: 'Customized Pie',
								        left: 'center',
								        top: 20,
								        textStyle: {
								            color: '#ccc'
								        }
								    },

								    tooltip : {
								        trigger: 'item',
								        formatter: "{a} <br/>{b} : {c} ({d}%)"
								    },

								    visualMap: {
								        show: false,
								        min: 80,
								        max: 600,
								        inRange: {
								            colorLightness: [0, 1]
								        }
								    },
								    series : [
								        {
								            name:'访问来源',
								            type:'pie',
								            radius : '55%',
								            center: ['50%', '50%'],
								            data:[{value:arr2[0], name:arr1[0]},
								                {value:arr2[1], name:arr1[1]},
								                {value:arr2[2], name:arr1[2]},
								                {value:arr2[3], name:arr1[3]},
								                {value:arr2[4], name:arr1[4]},
								                {value:arr2[5], name:arr1[5]},
								                {value:arr2[6], name:arr1[6]},
								                {value:arr2[7], name:arr1[7]},
								                {value:arr2[8], name:arr1[8]},
								                {value:arr2[9], name:arr1[9]}
								                ].sort(function (a, b) { return a.value - b.value; }),
								            roseType: 'radius',
								            label: {
								                normal: {
								                    textStyle: {
								                        color: 'rgba(255, 255, 255, 0.3)'
								                    }
								                }
								            },
								            labelLine: {
								                normal: {
								                    lineStyle: {
								                        color: 'rgba(255, 255, 255, 0.3)'
								                    },
								                    smooth: 0.2,
								                    length: 10,
								                    length2: 20
								                }
								            },
								            itemStyle: {
								                normal: {
								                    color: '#c23531',
								                    shadowBlur: 200,
								                    shadowColor: 'rgba(0, 0, 0, 0.5)'
								                }
								            },

								            animationType: 'scale',
								            animationEasing: 'elasticOut',
								            animationDelay: function (idx) {
								                return Math.random() * 200;
								            }
								        }
								    ]
								};
							// 使用刚指定的配置项和数据显示图表。
							myChart3.setOption(option3);
							//************************************
							//                      饼状图结束
						},
						error : function() {
							alert("异常！");
						}
					});
				})
	})
</script>
<title>Insert title here</title>
</head>
<body>
	<button id="b1">机场</button>
	<button id="b2">代理人</button>
	<button id="b3">一天数据</button>
	<div id="main" style="width: 100%; height: 600px;"></div>
	<div id="zhu" style="width: 100%; height: 600px;"></div>
	<div id="bing" style="width: 100%; height: 600px;"></div>
</body>
</html>
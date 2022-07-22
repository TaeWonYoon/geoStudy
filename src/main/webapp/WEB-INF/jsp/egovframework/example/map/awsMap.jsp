<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css" type="text/css">
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script>
<style>

	.__float-tbl{border: 1px solid #2a5dc5;border-radius: 5px;background-color: #2a5dc5;font-size: 15px;color: white;text-align: center;position: absolute;top: 30px;left: -50px;width:130px;}
	.__float-tbl2{border-radius: 5px;font-size: 15px;text-align: center;width:200px;position:fixed;right:0;top:170px;z-index:10000;bottom:30;}
	.__float-tbl2 table {width: 200px;border: 5px solid #fff5e6;}
	.__float-tbl2 table tr:nth-child(2n) {background: #ffe0b3;}
	.__float-tbl2 table tr:nth-child(2n+1) {background: #fff5e6;}  
	.__float-tbl2 table .title {background: #ff9900;font-weight: bold;}

</style>
	<h1 style="text-align:center;">농업기상관측</h1>
    <div>
        <div id="vMap" class="vMap" style="width:100%;height:700px;margin: 0 auto;"></div>
    </div>
    <div id="popup">
    	<div id="popup-content"></div>
    </div>
    <div id="popup2">
    	<div id="popup-content2"></div>
    </div>
 <!-- 지도가 그려지는 영역 조정 -->
<a href="./map.do">기상관측</a>
<script type="text/javascript">

var container = document.getElementById('popup'); //팝업이 담길 컨테이너 요소
var container2 = document.getElementById('popup2'); //팝업이 담길 컨테이너 요소
var content1 = document.getElementById('popup-content'); //팝업 내용 요소
var content2 = document.getElementById('popup-content2'); //팝업 내용 요소
var map; //맵 변수 선언 : 지도 객체
var mapLayer; //맵 레이어 선언 : 지도 그림(타일) 설정
var mapOverlay; //맵 오버레이 선언 : 지도 위에 팝업 옵션을 사용할 때
var mapView; //맵 뷰 선언 : 보여지는 지도 부분 설정
var hover=null; //마우스 이벤트에 사용될 변수
var x;
var y;

function init(){
	mapLayer = new ol.layer.Tile({ //타일 생성
			title : 'Vworld Map', //이름
			visible : true, //보여짐 여부
			type : 'base', //지도 종류(일반(base)) ---(야간(midnight), 흑색(gray), 하이브리드(Hybrid) 등)
			source : new ol.source.XYZ({ //vworld api 사용
				url : 'http://api.vworld.kr/req/wmts/1.0.0/6773424E-5A7E-3A67-8742-CE4575044858/Base/{z}/{y}/{x}.png'
			})
	      });

	mapOverlay = new ol.Overlay(({ element: container, container2 } )); //Overlay 생성, 요소는 컨테이너
	
	mapView =  new ol.View({ //뷰 생성
			projection : 'EPSG:3857', //좌표계 설정 (EPSG:3857은 구글에서 사용하는 좌표계) 
			center : new ol.geom.Point([ 128.5, 36.1 ]) //처음 중앙에 보여질 경도, 위도 
					.transform('EPSG:4326', 'EPSG:3857') //GPS 좌표계 -> 구글 좌표계
					.getCoordinates(), //포인트의 좌표를 리턴함
			zoom : 7.7 //초기지도 zoom의 정도값
	     });
	map = new ol.Map({ //맵 생성	
		target : 'vMap', //html 요소 id 값
		layers : [mapLayer], //레이어
		overlays: [mapOverlay], //오버레이
		view : mapView //뷰
	});
	
	map.on('pointermove', function(evt) { //마우스 올렸을 때
       var coordinate = evt.coordinate; //마우스가 올려진 좌표값

       //마커가 있는 곳에 마우스가 올려지면 커서의 스타일을 pointer로 설정
       map.getTargetElement().style.cursor = map.hasFeatureAtPixel(evt.pixel) ? 'pointer': '';

       //마우스를 다른 곳으로 옮길 때를 위해 스위치역할
       if(hover != null) {
       	hover = null;
       }

       //마우스가 올려진 곳의 마커를 가져와 hover에 저장
       map.forEachFeatureAtPixel(evt.pixel, function(f) {
    	   console.log(f)
           hover = f;
           return true;
       });

       //마커가 있을 경우
       if(hover){
            var content = "<div class='__float-tbl'>"
        	 		    + hover.get('name') //이름 값 뽑기
	           		    + "</div>";
         	
			var contentUp ="<div class='__float-tbl2'>"
							+ "<table border='1'>"
								+ "<tr>"
									+ "<td colspan='2' class='title'>관측정보</td>"
								+ "</tr>"
								+ "<tr>"
									+ "<td>지점번호</td>"
									+ "<td>" + hover.get('station_id') + "</td>"//이름 값 뽑기
								+ "</tr>"
								+ "<tr>"
									+ "<td>지점명</td>"
									+ "<td>" + hover.get('name') + "</td>"//이름 값 뽑기
								+ "</tr>"
								+ "<tr>"
									+ "<td>관측날짜</td>"
									+ "<td>" + hover.get('tm') + "</td>"//이름 값 뽑기
								+ "</tr>"
								+ "<tr>"
									+ "<td>기온(150CM)최저</td>"
									+ "<td>" + hover.get('minta') + "</td>"//이름 값 뽑기
								+ "</tr>"
								+ "<tr>"
									+ "<td>기온(150CM)최고</td>"
									+ "<td>" + hover.get('maxta') + "</td>"//이름 값 뽑기
								+ "</tr>"
							+	"</table>"
			             + "</div>";
			             
           //popup-content 부분에 content를 넣어줌
           content1.innerHTML = content;
          content2.innerHTML = contentUp;
           
           //오버레이의 좌표를 정해줌
           mapOverlay.setPosition(coordinate);
        } else {
       	content1.innerHTML = '';
       	content2.innerHTML = '';
   	 }
   });

	map.on('singleclick', function(evt){ //클릭 했을 때
		var ff = map.hasFeatureAtPixel(evt.pixel); //클릭한 pixel에 마커가 있으면 true, 없으면 false
		
		if(ff == true){ //있으면 openPopup() 실행
			/*
			var contentUp ="<div class='__float-tbl2'>"
				+ "<table border='1'>"
					+ "<tr>"
						+ "<td colspan='2' class='title'>관측정보</td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>지점번호</td>"
						+ "<td>" + hover.get('station_id') + "</td>"//이름 값 뽑기
					+ "</tr>"
					+ "<tr>"
						+ "<td>지점명</td>"
						+ "<td>" + hover.get('name') + "</td>"//이름 값 뽑기
					+ "</tr>"
					+ "<tr>"
						+ "<td>관측날짜</td>"
						+ "<td>" + hover.get('tm') + "</td>"//이름 값 뽑기
					+ "</tr>"
					+ "<tr>"
						+ "<td>최저기온</td>"
						+ "<td>" + hover.get('minta') + "</td>"//이름 값 뽑기
					+ "</tr>"
					+ "<tr>"
						+ "<td>최고기온</td>"
						+ "<td>" + hover.get('maxta') + "</td>"//이름 값 뽑기
					+ "</tr>"
				+	"</table>"
             + "</div>";
             
			//popup-content 부분에 content를 넣어줌
			content2.innerHTML = contentUp;
			*/
		 	//openPopup();
		} else {
			content2.innerHTML = '';
		}
 	});
	
}
	
function openPopup(){ //팝업창 오픈
	window.open('/detail/popup.do', '팝업창', 'left=200,top=200,width=600,height=600,scrollbars=yes,resizable=yes');
}
	
function addMarker(lon, lat, name, station_id, tm, minta, maxta){ //경도 위도 이름값(마커들을 구분하기위해)
	// 마커 feature 설정
    var feature = new ol.Feature({ //나중에 데이터 가져오기 위해
        geometry: new ol.geom.Point(ol.proj.fromLonLat([lon, lat])), //경도 위도에 포인트 설정
        name: name,
        station_id: station_id,
        tm: tm,
        minta: minta,
        maxta: maxta,
        
    });

    // 마커 스타일 설정
    var markerStyle = new ol.style.Style({
        image: new ol.style.Icon({ //마커 이미지
        	opacity: 1, //투명도 1=100% 
        	scale: 1.2, //크기 1=100%
            src: 'http://map.vworld.kr/images/ol3/marker_blue.png'
        }),
        zoom : 7.7
    });

    // 마커 레이어에 들어갈 소스 생성
    var markerSource = new ol.source.Vector({
        features: [feature] //feature의 집합
    });

    // 마커 레이어 생성
    var markerLayer = new ol.layer.Vector({
        source: markerSource, //마커 feacture들
        style: markerStyle //마커 스타일
    });
    
    // 지도에 마커가 그려진 레이어 추가
    map.addLayer(markerLayer);
    
}

$(document).ready(function() {
	initAjax();
	
	
});

function initAjax() {
	
	var param = {
			ty : "aws"
	};
	
	var callback = function(data) {
		if(data.result == "SUCCESS") {
			init();
			var obj = data.list;
			console.log(obj);
			for (var key in obj) {
				y = obj[key].instl_lo;
				x = obj[key].instl_la;
				var stationName = obj[key].obsr_spot_nm;
				var station_id = obj[key].obsr_spot_code;
				var tm = obj[key].date_time;
		        var minta = obj[key].tmprt_150lwet;
		        var maxta = obj[key].tmprt_150top;
				addMarker(y,x, stationName,station_id,tm,minta,maxta);
			}
		} else {
			alert(data.resultMsg);
		}
	}
	
	callAjax(param, "./mapList.do", callback, true, "p"); // 데이터, url, 콜백, 신크
}

</script>
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
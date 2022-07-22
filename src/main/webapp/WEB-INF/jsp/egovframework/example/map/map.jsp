<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css" type="text/css">
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script>
<style>

	.__float-tbl{border: 1px solid #2a5dc5;border-radius: 5px;background-color: #2a5dc5;font-size: 15px;color: black;text-align: center;position: absolute;top: 35px;left: 20px;top:-55px;width:130px;}
	.__float-tbl table {width: 200px;border: 5px solid #fff5e6; z-index:10000;}
	.__float-tbl table tr:nth-child(2n) {background: #ffe0b3;}
	.__float-tbl table tr:nth-child(2n+1) {background: #fff5e6;}  
	.__float-tbl table .title {background: #ff9900;font-weight: bold;}
	
	.__float-tbl2{border-radius: 5px;font-size: 15px;text-align: center;width:650px;position:fixed;right:30px;top:150px;z-index:10000;bottom:30;}
	.__float-tbl2 table {width: 650px;border: 5px solid #fff5e6;}
	.__float-tbl2 table tr:nth-child(2n) {background: #ffe0b3;}
	.__float-tbl2 table tr:nth-child(2n+1) {background: #fff5e6;}  
	.__float-tbl2 table .title {background: #ff9900;font-weight: bold;}
	.__float-tbl2 table td { font-size: 17px; font-weight:700; border-right: 1px solid #ffcccc; height: 40px;}
	.a_css {text-decoration: none; font-size: 17px; color: black; margin-right: 10px;}
	.a_css:hover {font-size:22px;font-weight:bold;}	
	
</style>

<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>
	
<div class="col-6 m-2" style="height:1000px;">
	
	<div style="margin-top: 1%;"></div> <!--  마진 태그 -->
	
	<div style="text-align:center;">
		<span style="font-size: 20px;font-weight:bold;">기상관측지점</span>
		<br>
		<a href="javascript:void(0);" onclick="viewTy('Base','','0')" class="a_css">Base</a>
		<a href="javascript:void(0);;" onclick="viewTy('midnight','','1')" class="a_css">midnight</a>
		<a href="javascript:void(0);" onclick="viewTy('gray','','2')" class="a_css">gray</a>
		<a href="javascript:void(0);" onclick="viewTy('Hybrid','','3')" class="a_css">Hybrid</a>
		<a href="javascript:void(0);" onclick="viewTy('Satellite','jpeg','4')" class="a_css">Satellite</a>
	</div>
	
	<br>
	
    <div style="margin-left: 50px;">
        <div id="vMap" class="vMap" style="width:1200px;height:720px;margin: 0 auto;"></div>
    </div>
    <div id="popup">
    	<div id="popup-content"></div>
    </div>
    <div id="popup2">
    	<div id="popup-content2"></div>
    </div>
    
</div>

<script type="text/javascript">

var container = document.getElementById('popup'); //팝업이 담길 컨테이너 요소
var container2 = document.getElementById('popup2'); //팝업이 담길 컨테이너 요소
var content1 = document.getElementById('popup-content'); //팝업 내용 요소
var content2 = document.getElementById('popup-content2'); //팝업 내용 요소
var map; //맵 변수 선언 : 지도 객체
var mapLayer; //맵 레이어 선언 : 지도 그림(타일) 설정
var mapOverlay; //맵 오버레이 선언 : 지도 위에 팝업 옵션을 사용할 때
var mapView; //맵 뷰 선언 : 보여지는 지도 부분 설정
var markerLayer; // 마커레이어 전역변수 
var hover=null; //마우스 이벤트에 사용될 변수
var markerClick=null; //클릭 이벤트에 사용될 변수
var x;
var y;
var defaultUrl = 'http://map.vworld.kr/images/ol3/marker_blue.png'; //기본 마커이미지
var afterUrl = 'http://map.vworld.kr/images/ol3/marker.png'; //클릭시 마커이미지
$(document).ready(function() {
	initAjax();
	$(".a_css").eq(0).css("fontSize","24px");
	$(".a_css").eq(0).css("color","#4da6ff");
});


function initAjax(ty,ext) {
	
	var param = {
			ty : "asos"
	};
	
	var callback = function(data) {
		if(data.result == "SUCCESS") {
			init(ty, ext);
			var obj = data.list;
			for (var key in obj) {
				y = obj[key].lon;
				x = obj[key].lat;
				var stationName = obj[key].station_name;
				var station_id = obj[key].station_id;
				var tm = obj[key].tm;
		        var minta = obj[key].minta;
		        var maxta = obj[key].maxta;
		        var avgta = obj[key].avgta;
		        var avgrhm = obj[key].avgrhm;
		        var station_address = obj[key].station_address;
				addMarker(y,x, stationName,station_id,tm,minta,maxta, avgta, avgrhm, station_address);
			}
		} else {
			alert(data.resultMsg);
		}
	}
	
	callAjax(param, "./mapList.do", callback, false, "p"); // 데이터, url, 콜백, 신크
}

function init(ty, ext){
	
	content1.innerHTML = '';
   	content2.innerHTML = '';
	
	mapLayerTy(ty, ext);
	
	mapOverlay = new ol.Overlay(({ element: container, container2 } )); //Overlay 생성, 요소는 컨테이너
	
	mapView =  new ol.View({ //뷰 생성
			projection : 'EPSG:3857', //좌표계 설정 (EPSG:3857은 구글에서 사용하는 좌표계) 
			center : new ol.geom.Point([ 128.5, 36.1 ]) //처음 중앙에 보여질 경도, 위도 
					.transform('EPSG:4326', 'EPSG:3857') //GPS 좌표계 -> 구글 좌표계
					.getCoordinates(), //포인트의 좌표를 리턴함
			zoom : 7.4 //초기지도 zoom의 정도값
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
           hover = f;
           return true;
       });
       
       //마커가 있을 경우
       if(hover){
    	   //hover.image_.iconImage_.src_ = '';
            var content = "<div class='__float-tbl'>"
            				+ "<table border='1'>"
	            				+ "<tr>"
	     							+ "<td colspan='2' class='title'>관측정보</td>"
	     						+ "</tr>"
	     						+ "<tr>"
		     						+ "<td>지점번호</td>"
		     						+ "<td>" + hover.get('station_id') + "</td>"
		     					+ "</tr>"
	     						+ "<tr>"
		     						+ "<td>지점명</td>"
		     						+ "<td>" + hover.get('name') + "</td>"
		     					+ "</tr>"
		     					+ "<tr>"
		     						+ "<td>평균기온</td>"
		     						+ "<td>" + hover.get('avgta') + " °C </td>"
	     						+ "</tr>"
		     					+ "<tr>"
	     							+ "<td>최저기온</td>"
		     						+ "<td>" + hover.get('minta') + " °C </td>"
		     					+ "</tr>"
		     					+ "<tr>"
		     						+ "<td>최고기온</td>"
		     						+ "<td>" + hover.get('maxta') + " °C </td>"
		     					+ "</tr>"
    						+ "</table>"
	           		    + "</div>";
           content1.innerHTML = content;
			  /*
           content2.innerHTML = contentUp;
           */
           //오버레이의 좌표를 정해줌
           mapOverlay.setPosition(coordinate);
        } else {
       	content1.innerHTML = '';
   	 }
   });

	map.on('singleclick', function(evt){ //클릭 했을 때
		
		var ff = map.hasFeatureAtPixel(evt.pixel); //클릭한 pixel에 마커가 있으면 true, 없으면 false
		//마우스가 올려진 곳의 마커를 가져와 hover에 저장
       map.forEachFeatureAtPixel(evt.pixel, function(f) {
    	   		
	           if(markerClick != null) {
	        	   markerClick.setStyle(markerStyle(defaultUrl));
	        	   markerClick = null;
	           }
    	   		markerClick = f;
	           
	           markerClick.setStyle(markerStyle(afterUrl));
	           
	           return true;
       });
		if(ff == true){ //있으면 실행
			
			var contentUp ="<div class='__float-tbl2'>"
				+ "<table border='1' >"
					+ "<tr>"
						+ "<td colspan='2' class='title'>관측정보</td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>지점번호</td>"
						+ "<td>" + hover.get('station_id') + "</td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>지점명</td>"
						+ "<td>" + hover.get('name') + "</td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>기상관측  <br> 지점주소</td>"
						+ "<td>" + hover.get('station_address') + "</td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>관측날짜</td>"
						+ "<td>" + hover.get('tm') + "</td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>평균기온</td>"
						+ "<td>" + hover.get('avgta') + " °C </td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>최저기온</td>"
						+ "<td>" + hover.get('minta') + " °C </td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>최고기온</td>"
						+ "<td>" + hover.get('maxta') + " °C </td>"
					+ "</tr>"
					+ "<tr>"
						+ "<td>평균상대습도</td>"
						+ "<td>" + hover.get('avgrhm') + " % </td>"
					+ "</tr>"
				+	"</table>"
             + "</div>";
             
			//popup-content 부분에 content를 넣어줌
			content2.innerHTML = contentUp;
			
		 	//openPopup(); 파업 호출 함수
		} else {
			content2.innerHTML = '';
		}
 	});
	
}
	
function openPopup(){ //팝업창 오픈
	window.open('/detail/popup.do', '팝업창', 'left=200,top=200,width=600,height=600,scrollbars=yes,resizable=yes');
}

//마커 스타일 설정
function markerStyle(markerSrc) {
    return (new ol.style.Style({
		        image: new ol.style.Icon({ //마커 이미지
		        	opacity: 1, //투명도 1=100% 
		        	scale: 1.2, //크기 1=100%
		            src: markerSrc,
		        }),
		        zoom : 7.4
		    })
	    )
};

function addMarker(lon, lat, name, station_id, tm, minta, maxta, avgta, avgrhm, station_address){ //경도 위도 이름값(마커들을 구분하기위해)
	// 마커 feature 설정
    var feature = new ol.Feature({ //나중에 데이터 가져오기 위해
        geometry: new ol.geom.Point(ol.proj.fromLonLat([lon, lat])), //경도 위도에 포인트 설정
        name: name,
        station_id: station_id,
        tm: tm,
        minta: minta,
        maxta: maxta,
        avgta: avgta,
        avgrhm: avgrhm,
        station_address: station_address,
    });
    
    // 마커 레이어에 들어갈 소스 생성
    var markerSource = new ol.source.Vector({
        features: [feature] //feature의 집합
    });

    // 마커 레이어 생성
    markerLayer = new ol.layer.Vector({
        source: markerSource, //마커 feacture들
        style: markerStyle(defaultUrl) //마커 스타일
    });
    markerLayer.setZIndex(10);
    // 지도에 마커가 그려진 레이어 추가
    map.addLayer(markerLayer);
    
}

function viewTy(ty,ext,sort) { //지도 타입 선택시 구분주기
	
	$(".a_css").css("fontSize","17px");
	$(".a_css").css("color","black");
	$(".a_css").eq(sort).css("fontSize","24px");
	$(".a_css").eq(sort).css("color","#4da6ff");
	
	map.removeLayer(mapLayer);
	map.addLayer(mapLayerTy(ty,ext));
	
		
}


function mapLayerTy(ty, ext) { //레이어 지도 타입 지정
	
	ty = ty || 'Base';
	ext = ext || 'png';
	
	mapLayer = new ol.layer.Tile({ //타일 생성
			title : 'Vworld Map', //이름
			visible : true, //보여짐 여부
			type : 'base', //지도 종류(일반(base)) ---(야간(midnight), 흑색(gray), 하이브리드(Hybrid) 등)
			source : new ol.source.XYZ({ //vworld api 사용
				url : 'http://api.vworld.kr/req/wmts/1.0.0/6773424E-5A7E-3A67-8742-CE4575044858/'+ty+'/{z}/{y}/{x}.'+ext
			})
	      });
	
	return mapLayer;
	
}

</script>
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
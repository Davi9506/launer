<%--
  Created by IntelliJ IDEA.
  User: p__mp4
  Date: 2022/06/17
  Time: 5:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layouts/delivery" %>
<t:wrapper>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <script type="text/javascript">

        function mapDraw(element, aaa, bbb) {
            let clearMap = document.getElementById('deliveryList').getElementsByClassName('detail-map on');
            for(let i = 0; i < clearMap.length; i++) {
                clearMap[i].classList.remove('on');
            }


            let mapCon = element.parentNode.getElementsByClassName('detail-map')[0];
            mapCon.classList.toggle('on');

            var mapContainer = mapCon, // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(aaa, bbb), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };
            // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다

            console.log(mapContainer);
            var map = new kakao.maps.Map(mapContainer, mapOption);
        }
    </script>
    <div class="fixed-margin-top"></div>
    <div id="deliveryList">
        <div class="title-part">
            <h1 id="title">
                <strong>${deliveryName }</strong>
                님의 현재 ${groupNo == 1 ? "수거목록" : groupNo == 2 ? "배송목록" : "유효한 값이 아님"}
            </h1>
            <p>총 ${countList}건</p>
        </div>
        <div class="list-part">
            <c:if test="${empty list}">
                <h3 style="text-align: center">항목이 없습니다.</h3>
            </c:if>
            <c:if test="${!empty list}">
                <c:forEach var="vo" items="${list }">
                    <c:set var="title" value=""/>
                    <c:set var="titleCnt" value="0"/>
                    <c:forEach var="titleMap" items="${vo.orderDetails}">
                        <c:if test="${titleCnt == 0}">
                            <c:set var="title" value="${titleMap.CATEGORY_NAME}"/>
                        </c:if>
                        <c:if test="${titleCnt != 0}">
                            <c:set var="title" value="${title}, ${titleMap.CATEGORY_NAME}"/>
                        </c:if>
                        <c:set var="titleCnt" value="${titleCnt + 1}"/>
                    </c:forEach>
                    <div class="list-box">
                        <h3>${title}</h3>
                        <div class="text-box" onclick="mapDraw(this, 37.572713983772275, 126.96683255214562)">
                            <div class="left">
                                <div class="text-list">
                                    <p>신청자 <strong>${vo.orderOfficeView['NAME']}</strong></p>
                                    <p>수량 <strong>${vo.orderOfficeView['SUM']}</strong></p>
                                    <p>수당 <strong>${vo.orderOfficeView['NAME']} 원</strong></p>
                                </div>
                                <div class="text-list">
                                    <p>위치 <strong>서울시 금천구 시흥대로213길 123</strong></p>
                                </div>
                            </div>
                        </div>
                        <div class="detail-map"></div>
                        <div class="btn-box">
                            <button>취소</button>
                            <button>완료</button>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <%--<div class="list-box">
                <h3>상품명</h3>
                <div class="text-box" onclick="mapDraw(this, 37.572713983772275, 126.96683255214562)">
                    <div class="left">
                        <div class="text-list">
                            <p>신청자 <strong>홍길동</strong></p>
                            <p>위치 <strong>지역주소</strong></p>
                            <p>수당 <strong> 원</strong></p>
                        </div>
                        <div class="text-list">
                            <p>위치 <strong>서울시 금천구 시흥대로213길 123</strong></p>
                        </div>
                    </div>
                </div>
                <div class="detail-map"></div>
                <div class="btn-box">
                    <button>취소</button>
                    <button>완료</button>
                </div>
            </div>--%>
        </div>

    </div>
</t:wrapper>
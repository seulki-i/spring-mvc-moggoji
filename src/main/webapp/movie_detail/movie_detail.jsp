<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/movie/css/style.css" rel="Stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
  var like_count = ${like_count};
  $('#like_count').html(like_count);
});

function like_func(movieCd){
  
  $.ajax({     
    url: "/movie/movie/like.do",  
    type: "GET", 
    cache: false,
    dataType: "json", 
    data: "movieCd="+movieCd, 
    
    success: function(data) { 
      if(data.like_check == 0){
        like_img="/movie/images/like.png";
      }else{
        like_img="/movie/images/like_on.png";
      }
      $('#like_img').attr('src', like_img);
      $('#like_count').html(data.like_count);
      //$("#like_state").html(msg);
     },
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}
 </script>
 <style type="text/css">
 *{
font-family: 'Jeju Gothic', serif;
}
</style>

 <div style="float: left;  margin-left: 30px; margin-right: 30px;">
 <c:choose>
        <c:when test="${movieVO.movieImg ne '' }">
         <img src="/movie/movie/storage/${movieVO.movieImg }"  style="width: 250px; height: 350px;">
        </c:when>
        <c:otherwise>
          <img src="/movie/movie/images/grid_movie.png" style="width: 250px; height: 350px;" >
        </c:otherwise>
      </c:choose>
 </div>
 
 <div style="float: left; width: 70%; margin-bottom: 20px;">
 <br><br>
  <h2>${movieVO.movieNm }
<c:choose>
      <c:when test="${memberno ne null && like_check eq 0}">
        <a href="javascript:like_func(${movieVO.movieCd })"><img id='like_img' src="/movie/images/like.png" title="보고싶어요"> </a>
      </c:when>
      <c:when test="${memberno ne null && like_check eq 1}"> 
        <a href="javascript:like_func(${movieVO.movieCd })"><img id='like_img' src="/movie/images/like_on.png" title="보고싶어요"> </a>
      </c:when>
      <c:otherwise>

      </c:otherwise>
    </c:choose>

  
 </h2> 
  <hr style="border:  dotted 0.5px #AAAAAA"><!-- 영화영어제목, 개봉일, 나라, 장르, 관람가, 시간 -->
  ${movieVO.movieNmEn }, ${movieVO.openDt }, ${movieVO.repNationNm }, ${movieVO.genre }, ${movieVO.watchGradeNm }, ${movieVO.showTm }분<br>
  <c:choose>
    <c:when test="${avg_grade ne 0 && avg_grade ne null}">
      <img src="/movie/images/star_on.png" style="width: 16px;"> <span>${avg_grade} (${mcc}명 참여)</span>
    </c:when>
    <c:otherwise>
      <img src="/movie/images/star_on.png" style="width: 16px;"> <span> (0명 참여)</span>
    </c:otherwise>
  </c:choose>
  <br><br><br><br><br><br><br><br>
  <img src="/movie/images/heart.png" style="width: 16px;">&nbsp;<span id="like_count"></span> &nbsp;&nbsp; <!-- 보고싶어요 카운트 -->
  <img src="/movie/images/comment.png" style="width: 16px;">&nbsp;<span>${mcc}</span> <!-- 댓글 카운트 -->
 </div>
 
  <hr style="border:  dotted 0.5px #AAAAAA; width: 100%;">
  
<div style="width: 100%; "> 
 <div style="width: 65%; float: left; margin-left: 20px; margin-right: 30px; ">
  <h3>줄거리</h3>
  <p>${movieVO.plot }</p>
 <hr style="border:  dotted 0.5px #AAAAAA; width: 100%; margin-top: 50px;">
 
 <span style="float: left;"><strong>Comment (${mcc})</strong></span>  <br><!-- 영화별 댓글 갯수 -->
 <jsp:include page ="/mcomment/list.jsp" flush="false"/> <!-- 댓글 영역  -->
 </div>
 
  <div style="width: 28%; float: left; text-align: center;">

    <h3>예고편</h3>
    <div style="width: 100%;">${movieVO.vodclass }</div>

    <div>
    <h3>감독</h3>
    <p>${movieVO.director }</p>
    </div>
    
    <div>
    <h3>배우</h3>  

<c:choose >
 <c:when test="${movieVO.actors !='' }">
    <c:forEach var="actor" items="${actor }">
      <p>${actor}</p>
    </c:forEach>
        </c:when>
        <c:otherwise>
      <%-- <p>${movieVO.actors}</p> --%>
        </c:otherwise>
</c:choose>
    
   
    </div>
 </div>
 
</div>





 
<!-- </DIV> content END -->

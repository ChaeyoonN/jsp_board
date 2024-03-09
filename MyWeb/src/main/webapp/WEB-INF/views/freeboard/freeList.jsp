<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    
    <%@ include file="../include/header.jsp" %>

<style>
a#listHome:visited, a#listHome:active{
    color: black;
}
a#listHome:link{
    text-decoration: none;
}
a#listHome:hover{
    color: #337ab7;
}
</style>  

    <!-- <c:set var="pageCount" value="${pc.articleTotalCount / 10}" /> -->
    <section>
        <div class="container-fluid">
            <div class="row">
                <!--lg에서 9그리드, xs에서 전체그리드-->   
                <div class="col-lg-9 col-xs-12 board-table">
                    <div class="titlebox">
                        <p><a id="listHome" href="${pageContext.request.contextPath}/freeboard/freeList">자유게시판</a></p>                 
                    </div>
                    <hr>
                    
                    <!--form select를 가져온다 -->
            <form action="${pageContext.request.contextPath}/freeboard/freeList">
		    		<div class="search-wrap">

                       <button type="submit" class="btn btn-info search-btn">검색</button>
                       <input type="text" name="keyword" class="form-control search-input" value="${pc.page.keyword}">

                       <select name="condition" class="form-control search-select">
                            <option value="title" ${pc.page.condition == 'title' ? 'selected':''}>제목</option>
                            <option value="content" ${pc.page.condition == 'content' ? 'selected':''}>내용</option>
                            <option value="writer" ${pc.page.condition == 'writer' ? 'selected':''}>작성자</option>
                            <option value="titleContent" ${pc.page.condition == 'titleContent' ? 'selected':''}>제목+내용</option>
                       </select>

                    </div>

                    <div class="search-wrap countDiv" var="vo" items="${boardList}" varStatus="status">
                        <div>게시글 수: <span>${totalCount}</span>건</div>
                    </div>
		    </form>
                   
                    <table class="table table-bordered">
                        <colgroup>
                            <col style="width:10%;">
                            <col style="width:55%;">
                            <col style="width:15%;">
                            <col style="width:20%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th class="board-title">제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                            <c:if test="${msg eq 'showList'}">
                            <c:set var="num" value="${totalCount - ((pc.page.pageNo-1) * 10)}"/>
                        	<c:forEach var="vo" items="${boardList}" varStatus="status">
	                            <tr>
                                    <td>${num}</td>
                                    <!-- <td>${boardList.size() - status.index}</td> -->
	                                <td style="display: none;">${vo.bno}</td>
	                                <td>
                                        <c:choose>
                                            <c:when test="${vo.writer != null}">
                                            <a href="${pageContext.request.contextPath}/freeboard/content?bno=${vo.bno}&pageNo=${pc.page.pageNo}&amount=${pc.page.amount}&keyword=${pc.page.keyword}&condition=${pc.page.condition}"
                                            >
                                            <c:if test="${vo.step > 0}">
                                                <c:forEach var="i" begin="1" end="${vo.step}">
                                                    &nbsp;&nbsp;
                                                </c:forEach>
                                                <img style="display: inline-block;" src="${pageContext.request.contextPath}/img/reply-solid.png" />
                                            </c:if>
                                            <span>
                                                <c:out value="${vo.title}" escapeXml="true" />
                                                (<c:out value="${vo.commentCount}" escapeXml="true" />)
                                            </span>
                                            </a>
                                            </c:when>
                                            
                                            <c:otherwise>
                                            <span>
                                                <c:if test="${vo.step > 0}">
                                                    <c:forEach var="i" begin="1" end="${vo.step}">
                                                        &nbsp;&nbsp;
                                                    </c:forEach>
                                                    <img style="display: inline-block;" src="${pageContext.request.contextPath}/img/reply-solid.png" />
                                                </c:if>
                                                <span>
                                                    <c:out value="${vo.title}" escapeXml="true" />
                                                    (<c:out value="${vo.commentCount}" escapeXml="true" />)
                                                </span>
                                            </span>
                                        </c:otherwise>
                                            
                                        </c:choose>
                                    </td>
	                                <td><c:out value="${vo.writer}" escapeXml="true" /></td>
	                                <td>${vo.date}</td>
	                            </tr>
                                <c:set var="num" value="${num-1}"></c:set>
                            </c:forEach>
                            </c:if>

                            <c:if test="${msg eq 'searchFail'}">
                                <div>
                                    <h2><img width="58px" margin-right="5px"
                                        src="${pageContext.request.contextPath}/img/alert.png"
                                      />검색 결과가 없습니다.</h2>
                                </div>
                            </c:if>

                            <c:if test="${msg eq 'zeroBoard'}">
                                <div>
                                    <h2><img width="58px" margin-right="5px"
                                        src="${pageContext.request.contextPath}/img/alert.png"
                                      />현재 게시글이 존재하지 않습니다.</h2> 
                                      
                                </div>
                            </c:if>

                        </tbody>
                        
                    </table>

                    

                    <!--페이지 네이션을 가져옴-->
		    <form action="${pageContext.request.contextPath}/freeboard/freeList" name="pageForm">
                    <div class="text-center">
	                    <hr>
	                    <ul id="pagination" class="pagination pagination-sm">
	                        <c:if test="${pc.prev}">
                                <li><a href="#" data-pagenum="1">처음</a></li>
	                        	<li><a href="#" data-pagenum="${pc.begin-1}">이전</a></li>
	                        </c:if>
	                        
	                        <c:forEach var="num" begin="${pc.begin}" end="${pc.end}">
	                        	<li class="${pc.page.pageNo == num ? 'active':''}"><a href="#" data-pagenum="${num}">${num}</a></li>
	                        </c:forEach>
	                        
	                        <c:if test="${pc.next}">
	                        	<li><a href="#" data-pagenum="${pc.end+1}">다음</a></li>
                                
                                <li><a href="#" data-pagenum="">끝</a></li>
	                        </c:if>
	                    </ul>
                        <div style="display: flex; justify-content: flex-end;">
                        <button type="button" style="margin-right: 7px;" class="btn btn-info list-btn" onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList'">목록</button>
                        
	                    <button type="button" class="btn btn-info" onclick="location.href='${pageContext.request.contextPath}/freeboard/freeRegist'">글쓰기</button>
                        </div>
                    </div>

                    <input type="hidden" name="pageNo" value="${pc.page.pageNo}">
                    <input type="hidden" name="amount" value="${pc.page.amount}">
                    <input type="hidden" name="keyword" value="${pc.page.keyword}">
                    <input type="hidden" name="condition" value="${pc.page.condition}">

		    </form>

                </div>
            </div>
        </div>
	</section>
	
	<%@ include file="../include/footer.jsp" %>

 
    <script>
       
        //브라우저 창이 로딩이 완료된 후에 실행할 것을 보장하는 이벤트.
        window.onload = function() {
            
            console.log('msg: ', '${msg}');

            var totalItemCount = parseInt(document.querySelector('.countDiv>div>span').textContent, 10);
            var itemsPerPage = parseInt(document.pageForm.amount.value, 10);
            var totalPageCount = Math.ceil(totalItemCount / itemsPerPage);

            // '끝' 링크에 총 페이지 수를 설정합니다.
            var lastPageLink = document.querySelector('a[data-pagenum=""]');
            if (lastPageLink) {
                lastPageLink.setAttribute('data-pagenum', totalPageCount);
            }

            //사용자가 페이지 관련 버튼을 클릭했을 때 (이전, 다음, 1, 2, 3...)
            //a태그의 href에다가 각각 다른 url을 작성해서 요청을 보내기가 귀찮다.
            //클릭한 버튼이 무엇인지를 확인해서 그 버튼에 맞는 페이지 정보를 
            //자바스크립트로 끌고 와서 요청을 보내주겠다.
            document.getElementById('pagination').addEventListener('click', e => {
               if(!e.target.matches('a')){
                    return;
               } 

               e.preventDefault(); // a태그의 고유 기능 중지

               //현재 이벤트가 발생한 요소(버튼)의 
               //data-pagenum의 값을 얻어서 변수에 저장.
               //date-으로 시작하는 속성값을 dataset 프로퍼티로 쉽게 끌고 올 수 있습니다.
               const value = e.target.dataset.pagenum;
            
               //페이지 버튼들을 감싸고 잇는 form태그를 지목하여
               //그 안에 숨겨져 있는 input태그의 value에
               //위에서 얻은 data-pagenum의 값을 삽입한 후 submit
               document.pageForm.pageNo.value = value;
               document.pageForm.submit();

            });

            const msg = '${msg}';
            if(msg === 'searchFail'){
            	
                // alert('검색 결과가 없었습니다.');
            }
            if(msg === 'zeroBoard'){
            	
                // alert('검색 결과가 없었습니다.');
            }


        }

    </script>


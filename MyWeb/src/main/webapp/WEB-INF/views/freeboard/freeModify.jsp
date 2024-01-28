<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="../include/header.jsp" %> <%@ taglib
prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section>
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-md-9 write-wrap">
        <div class="titlebox">
          <p>수정하기</p>
        </div>

        <form
          action="${pageContext.request.contextPath}/freeboard/modify"
          method="post"
          name="updateForm"
        >
          <table class="table">
            <tbody class="t-control">
              <tr>
                <td class="t-title">NAME</td>
                <td>
                  <input
                    class="form-control real-writer"
                    name="writer"
                    value=""
                    placeholder="10자 이내로 적어주세요."
                    width="200px"
                  />
                  <div>
                    <span id="writer-count" style="color: blue">0</span>/10
                  </div>
                  <!-- <div><span id="writer-count" style="color: blue;">0</span>/30</div> -->
                </td>
              </tr>
              <tr>
                <td class="t-title">PASSWORD</td>
                <td>
                  <input
                    type="password"
                    class="form-control real-password"
                    name="password"
                    value=""
                    placeholder="형식에 맞게 적어주세요."
                    width="200px"
                  />
                  <small class="password-instruction">
                    비밀번호는 영문 대/소문자, 특수문자, 숫자 조합 4~10자리
                    이내여야 합니다.
                  </small>
                  <small class="password-check">
                    <!-- <c:if test="">비밀번호가 형식에 맞지 않습니다.</c:if> -->
                  </small>
                </td>
              </tr>

              <tr>
                <td class="t-title">TITLE</td>
                <td>
                  <input
                    class="form-control cursor-control real-title"
                    name="title"
                    placeholder="제목은 40자 이내로 적어주세요."
                  />
                  <div>
                    <span id="title-count" style="color: blue">0</span>/40
                  </div>
                </td>
              </tr>
              <tr>
                <td class="t-title">CONTENT</td>
                <td>
                  <textarea
                    id="content"
                    class="form-control cursor-control"
                    rows="20"
                    name="content"
                    placeholder="내용은 1000자 이내로 적어주세요."
                  ></textarea>
                  <div>
                    <span id="content-count" style="color: blue">0</span>/1000
                  </div>
                </td>
              </tr>
            </tbody>
          </table>

          <!-- <div class="form-group">
            <label>번호</label>
            <input
              class="form-control"
              name="bno"
              value="${board.bno}"
              readonly
            />
          </div>
          <div class="form-group">
            <label>작성자</label>
            <input
              class="form-control"
              name="writer"
              value="${board.writer}"
              readonly
            />
          </div>
          <div class="form-group">
            <label>제목</label>
            <input class="form-control" name="title" value="${board.title}" />
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" rows="20" name="content" placeholder="내용은 1000자 이내로 적어주세요.">
${fn:escapeXml(board.content)}</textarea
            >
          </div> -->

          <button id="list-btn" type="button" class="btn btn-dark">목록</button>
          <button id="update-btn" type="button" class="btn btn-primary">
            변경
          </button>
        </form>
      </div>
    </div>
  </div>
</section>

<%@ include file="../include/footer.jsp" %>

<script>
  //목록 이동 처리
  document.getElementById("list-btn").onclick = function () {
    location.href = "${pageContext.request.contextPath}/freeboard/freeList";
  };

  //폼 태그는 메서드 없이 form 태그의 name으로 요소를 바로 취득할 수 있습니다.
  const $form = document.updateForm;
  //수정 버튼 이벤트
  document.getElementById("update-btn").onclick = function () {
    //form 내부의 요소를 지목할 땐 name 속성으로 바로 지목이 가능합니다. 폼태그.이름.값
    if ($form.title.value.replaceAll(" ", "").length <= 0) {
      alert("제목은 필수 항목입니다.");
      return;
    } else if ($form.content.value.replaceAll(" ", "").length <= 0) {
      alert("내용을 뭐라도 작성해 주세요!");
      return;
    }

    //문제가 없다면 form을 submit
    $form.submit();
  };

  // //삭제 버튼 이벤트 처리
  // document.getElementById('del-btn').onclick = () => {
  //     if(confirm('정말 삭제하시겠습니까?')){ //확인(누르면 true 리턴)과 취소(누르면 false 리턴)가 있는 알림창
  //         $form.setAttribute('action', 'myweb/freeboard/delete');//폼태그의 속성 바꾸기: setAttribute(바꾸고자하는속성이름, 내용)
  //         // jQuery로는 attr이라는 메서드 쓴다.

  //         $form.submit();
  //     }
  // }
</script>

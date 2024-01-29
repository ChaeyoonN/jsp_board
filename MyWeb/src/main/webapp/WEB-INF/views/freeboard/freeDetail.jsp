<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="../include/header.jsp" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
  small.password-check {
    display: block; /* 블록 레벨 요소로 만들어 줍니다 (새 줄에서 시작) */
    font-size: 0.8em; /* 작은 글씨 크기 */
    color: red;
    margin-top: 5px; /* 입력란과의 간격 */
  }
  input.input-sm::placeholder {
    /* color: red; */
    font-size: 0.8em;
    /* font-style: italic; */
  }
  textarea#content-line {
    height: auto;
  }
  .passwordDiv {
    display: flex; /* Flexbox를 사용하여 자식 요소들을 한 줄에 배치합니다. */
    /* justify-content: space-between; 자식 요소들 사이에 공간을 최대한 배분하여, 확인 버튼이 오른쪽에 위치하도록 합니다. */
  }

  .confirm-btn {
    margin-left: 5px; /* 확인 버튼과 입력창 사이에 간격을 만듭니다. */
  }
</style>

<section>
  <div class="container">
    <div class="row">
      <!-- 구분 -->
      <div class="col-xs-12 col-md-9 write-wrap">
        <div class="titlebox">
          <p>상세보기</p>
        </div>

        <form
          name="boardDetailForm"
          action="${pageContext.request.contextPath}/freeboard/realDelete"
          method="post"
        >
          <div>
            <label>날짜</label>
            <p>${board.date}</p>
          </div>
          <div class="form-group" style="display: none">
            <label>번호</label>
            <input
              class="form-control"
              value="${board.bno}"
              name="bno"
              readonly
            />
          </div>
          <div class="form-group">
            <label>작성자</label>
            <input
              class="form-control"
              name="writer"
              id="writer"
              value="${fn:escapeXml(board.writer)}"
              readonly
            />
          </div>
          <div class="form-group" style="display: none">
            <label>비밀번호</label>
            <input
              class="form-control"
              name="password"
              value="${board.password}"
              readonly
            />
          </div>
          <div class="form-group">
            <label>제목</label>
            <input
              class="form-control"
              name="title"
              id="title"
              value="${fn:escapeXml(board.title)}"
              readonly
            />
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" name="content" id="content" readonly>
${fn:escapeXml(board.content)}</textarea
            >
          </div>

          <button type="button" id="modifyBtn" class="btn btn-primary">
            수정
          </button>
          <button type="button" id="deleteBtn" class="btn btn-primary">
            삭제
          </button>

          <button
            type="button"
            class="btn btn-dark"
            onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList?pageNo=${p.pageNo}&amount=${p.amount}&keyword=${p.keyword}&condition=${p.condition}'"
          >
            목록
          </button>
          <div class="passwordDiv form-group">
            <input
              id="pwInput"
              class="form-control input-sm"
              type="password"
              name="inputPw"
              placeholder="비밀번호를 치고 수정 또는 삭제 버튼을 누르세요"
            />
          </div>
          <button
            type="button"
            class="btn btn-primary btn-sm confirm-btn"
            id="pwConfirm"
            style="
              --bs-btn-padding-y: 0.25rem;
              --bs-btn-padding-x: 0.5rem;
              --bs-btn-font-size: 0.75rem;
              float: right;
            "
          >
            확인
          </button>
          <small class="password-check"></small>
        </form>
      </div>
    </div>
  </div>
</section>

<!-- 댓글 -->
<!-- <section style="margin-top: 80px">
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-md-9 write-wrap">
        <form class="reply-wrap">
          <div class="reply-image">
            <img src="${pageContext.request.contextPath}/img/profile.png" />
          </div>
          
          <div class="reply-content">
            <textarea class="form-control" rows="3" id="reply"></textarea>
            <div class="reply-group">
              <div class="reply-input">
                <input
                  type="text"
                  class="form-control"
                  id="replyId"
                  placeholder="이름"
                />
                <input
                  type="password"
                  class="form-control"
                  id="replyPw"
                  placeholder="비밀번호"
                />
              </div>

              <button type="button" id="replyRegist" class="right btn btn-info">
                등록하기
              </button>
            </div>
          </div>
        </form> -->

<!-- <div id="replyList"> -->
<!--자바스크립트를 활용하여 반복문을 이용해서 댓글의 개수만큼 반복 표현
                            <div class='reply-wrap'>
                                <div class='reply-image'>
                                    <img src='${pageContext.request.contextPath}/img/profile.png'>
                                </div>
                                <div class='reply-content'>
                                    <div class='reply-group'>
                                        <strong class='left'>honggildong</strong> 
                                        <small class='left'>2019/12/10</small>
                                        <a href='#' class='right'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                                        <a href='#' class='right'><span class='glyphicon glyphicon-remove'></span>삭제</a>
                                    </div>
                                    <p class='clearfix'>여기는 댓글영역</p>
                                </div>
                            </div>
                            -->
<!-- </div>
        <button
          type="button"
          class="form-control"
          id="moreList"
          style="display: none"
        >
          더보기(페이징)
        </button>
      </div>
    </div>
  </div>
</section> -->

<!-- 모달 -->
<!-- <div class="modal fade" id="replyModal" role="dialog">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button
          type="button"
          class="btn btn-default pull-right"
          data-dismiss="modal"
        >
          닫기
        </button>
        <h4 class="modal-title">댓글 수정</h4>
      </div>
      <div class="modal-body"> -->
<!-- 수정폼 id값을 확인하세요-->
<!-- <div class="reply-content">
          <textarea
            class="form-control"
            rows="4"
            id="modalReply"
            placeholder="내용입력"
          ></textarea>
          <div class="reply-group">
            <div class="reply-input">
              <input type="hidden" id="modalRno" />
              <input
                type="password"
                class="form-control"
                placeholder="비밀번호"
                id="modalPw"
              />
            </div>
            <button class="right btn btn-info" id="modalModBtn">
              수정하기
            </button>
            <button class="right btn btn-info" id="modalDelBtn">
              삭제하기
            </button>
          </div>
        </div> -->
<!-- 수정폼끝 -->
<!-- </div>
    </div>
  </div>
</div>  -->

<%@ include file="../include/footer.jsp" %>

<script>
  var passwordDiv = document.querySelector(".passwordDiv");

  var passwordInput = passwordDiv.querySelector("input");
  var pwCheckBtn = document.getElementById("pwConfirm");
  var pwCheckText = document.querySelector("small.password-check");

  var password = document.getElementById("pwIntput");

  var regex = /^.*(?=^.{4,10}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
  var englishPattern = /[A-Za-z]/gi;
  var specialPattern = /[`~!@#$%^&*|\\\'\";:\/?-]/gi;
  var numberPattern = /[0-9]/gi;
  var blankPattern = /^\s/;
  var anyBlank = /\s/gi;

  const $title = document.getElementById("title");
  $title.style.height = "1px";
  $title.style.height = 12 + $title.scrollHeight + "px";

  const $writer = document.getElementById("writer");
  $writer.style.height = "1px";
  $writer.style.height = 12 + $writer.scrollHeight + "px";

  const $content = document.getElementById("content");
  $content.style.height = "1px";
  $content.style.height = 12 + $content.scrollHeight + "px";

  let message;
  let bno = document.boardDetailForm.bno.value;

  // 수정 버튼 클릭 시
  document.getElementById("modifyBtn").onclick = function (e) {
    // togglePasswordInput(e);

    //키다운 이벤트
    passwordInput.onkeydown = function (e) {
      if (e.key === " ") {
        e.preventDefault();
        alert("비밀번호에 공백을 사용할 수 없습니다.");
        return;
      }
      if (e.key === "Enter") {
        e.preventDefault();
        if (passwordInput.value === "" || passwordInput.value.includes(" ")) {
          alert("비밀번호를 입력하세요. 공백은 사용할 수 없습니다.");
          // document.getElementById("password").value = "";
          // document.getElementById("password").focus();
          return;
        }
        // 비범 정규식 조합 검증
        // if (!englishPattern.test(password)) {
        //   pwCheckText.style.borderColor = "red";
        //   pwCheckText.style.color = "red";
        //   document.querySelector(".password-check").innerHTML =
        //     "적절한 형식의 비밀번호가 아닙니다.";
        //   alert("비밀번호는 영문을 포함해야 합니다.");

        //   document.getElementById("password").value = "";
        //   document.getElementById("password").focus();
        //   return;
        // }

        // if (!numberPattern.test(password)) {
        //   pwCheckText.style.borderColor = "red";
        //   pwCheckText.style.color = "red";
        //   document.querySelector(".password-check").innerHTML =
        //     "적절한 형식의 비밀번호가 아닙니다.";
        //   alert("비밀번호는 숫자를 포함해야 합니다.");

        //   document.getElementById("password").value = "";
        //   document.getElementById("password").focus();
        //   return;
        // }

        // if (!specialPattern.test(password)) {
        //   pwCheckText.style.borderColor = "red";
        //   pwCheckText.style.color = "red";
        //   document.querySelector(".password-check").innerHTML =
        //     "적절한 형식의 비밀번호가 아닙니다.";
        //   alert("비밀번호는 특수문자를 포함해야 합니다.");
        //   document.getElementById("password").value = "";
        //   document.getElementById("password").focus();
        //   return;
        // }

        if (passwordInput.value.length < 4 || passwordInput.value.length > 10) {
          passwordInput.style.borderColor = "red";
          passwordInput.style.color = "red";
          document.querySelector(".password-check").innerHTML =
            "적절한 자릿수의 비밀번호가 아닙니다.";
          // alert("비밀번호 자릿수를 맞춰 주세요.");
          document.getElementById("pwInput").value = "";
          document.getElementById("pwInput").focus();
          return;
        }

        pwCheck("modPage");
      }
    }; // 키다운이벤트 끝
    // 블러 이벤트
    passwordInput.addEventListener("blur", pwCheck("modPage"));

    if (message === "pwCorrect") {
      document.querySelector("small.password-check").style.color = "green";
      document.querySelector("small.password-check").innerHTML =
        "비밀번호가 일치합니다.";
      // if(pwCheckBtn.){ // 확인 클릭하면 }
      pwCheckBtn.onclick = location.href = // 수정페이지 이동
        "${pageContext.request.contextPath}/freeboard/freeModify?bno=" + bno;
    } else {
      document.querySelector("small.password-check").innerHTML =
        "비밀번호가 일치하지 않습니다.";
    }
  };

  document.getElementById("deleteBtn").onclick = function (e) {
    togglePasswordInput(e);
    pwCheck("delete");
    if (message === "pwCorrect") {
      document.boardDetailForm.submit(); // 삭제 요청
    }
  };

  function togglePasswordInput(e) {
    var passwordDiv = document.querySelector(".passwordDiv");
    if (passwordDiv.style.display === "none") {
      passwordDiv.style.display = "block";
      var passwordInput = passwordDiv.querySelector("input");
      passwordInput.focus();
    } else {
      passwordDiv.style.display = "none";
      passwordDiv.querySelector("input").onkeydown = null;
    }
  }

  // passwordInput.onblur = (e) => {
  //   // 비밀번호 검증 요청
  //   pwCheck("modPage");
  // }; // onblur 이벤트 끝

  // pwCheckBtn.onclick = (e) => {
  //   // 비밀번호 검증 요청
  //   if (e.key === " ") {
  //     e.preventDefault();
  //     alert("비밀번호에 공백을 사용할 수 없습니다.");
  //     return;
  //   }
  //   if (e.key === "Enter") {
  //     e.preventDefault();
  //     if (passwordInput.value === "" || passwordInput.value.includes(" ")) {
  //       alert("비밀번호를 입력하세요. 공백은 사용할 수 없습니다.");
  //       return;
  //     }

  //     // 비범 정규식 조합 검증

  //     pwCheck("modPage");
  //   } // 확인버튼 클릭 이벤트 끝
  // };

  function pwCheck(path) {
    let bno = document.boardDetailForm.bno.value;
    let writer = document.boardDetailForm.writer.value;
    let password = document.boardDetailForm.password.value;
    let title = document.boardDetailForm.title.value;
    let content = document.boardDetailForm.content.value;
    let inputPw = passwordInput.value;

    let data =
      "bno=" +
      encodeURIComponent(bno) +
      "&writer=" +
      encodeURIComponent(writer) +
      "&password=" +
      encodeURIComponent(password) +
      "&title=" +
      encodeURIComponent(title) +
      "&content=" +
      encodeURIComponent(content) +
      "&inputPw=" +
      encodeURIComponent(inputPw);

    var request = new XMLHttpRequest();
    request.open(
      "POST",
      "${pageContext.request.contextPath}/freeboard/" + path,
      true
    );
    request.setRequestHeader(
      "Content-Type",
      "application/x-www-form-urlencoded"
    );

    request.onreadystatechange = function () {
      if (request.readyState === 4 && request.status === 200) {
        message = request.responseText;
        console.log(message);

        if (message === "pwWrong") {
          // document.querySelector("small.password-check").innerHTML =
          //   "비밀번호가 일치하지 않습니다.";
          // alert("비밀번호가 일치하지 않습니다.");
        } else if (message === "pwCorrect") {
          // document.querySelector("small.password-check").style.color = "green";
          // document.querySelector("small.password-check").innerHTML =
          //   "비밀번호가 일치합니다.";
        } // 비번 일치하는 경우 끝
      } // 요청-응답 정상일때
    };

    request.send(data);
  } // 서버에 요청해 비번 체크 함수 끝

  // // 수정 버튼 이벤트 처리
  // function togglePasswordInput(path) {
  //   var passwordDiv = document.querySelector(".passwordDiv");

  //   var passwordInput = passwordDiv.querySelector("input");
  //   passwordInput.focus();

  //   passwordInput.onkeydown = function (e) {
  //     if (e.key === " ") {
  //       e.preventDefault();
  //       alert("비밀번호에 공백을 사용할 수 없습니다.");
  //       return;
  //     }
  //     if (e.key === "Enter") {
  //       e.preventDefault();
  //       if (passwordInput.value === "" || passwordInput.value.includes(" ")) {
  //         alert("비밀번호를 입력하세요. 공백은 사용할 수 없습니다.");
  //         return;
  //       } else if (
  //         path === "modPage" &&
  //         !confirm("수정 페이지로 이동하시겠습니까?")
  //       ) {
  //         return;
  //       } else if (path === "delete" && !confirm("정말로 삭제하시겠습니까?")) {
  //         return;
  //       }

  //       let bno = document.boardDetailForm.bno.value;
  //       let writer = document.boardDetailForm.writer.value;
  //       let password = document.boardDetailForm.password.value;
  //       let title = document.boardDetailForm.title.value;
  //       let content = document.boardDetailForm.content.value;
  //       let inputPw = passwordInput.value;

  //       let data =
  //         "bno=" +
  //         encodeURIComponent(bno) +
  //         "&writer=" +
  //         encodeURIComponent(writer) +
  //         "&password=" +
  //         encodeURIComponent(password) +
  //         "&title=" +
  //         encodeURIComponent(title) +
  //         "&content=" +
  //         encodeURIComponent(content) +
  //         "&inputPw=" +
  //         encodeURIComponent(inputPw);

  //       var request = new XMLHttpRequest();
  //       request.open(
  //         "POST",
  //         "${pageContext.request.contextPath}/freeboard/" + path,
  //         true
  //       );
  //       request.setRequestHeader(
  //         "Content-Type",
  //         "application/x-www-form-urlencoded"
  //       );

  //       request.onreadystatechange = function () {
  //         if (request.readyState === 4 && request.status === 200) {
  //           var message = request.responseText;
  //           console.log(message);
  //           if (message === "pwWrong") {
  //             document.querySelector("small.password-check").innerHTML =
  //               "비밀번호가 일치하지 않습니다.";
  //             // alert("비밀번호가 일치하지 않습니다.");
  //           } else if (message === "pwCorrect") {
  //             document.querySelector("small.password-check").style.color =
  //               "green";
  //             document.querySelector("small.password-check").innerHTML =
  //               "비밀번호가 일치합니다.";

  //             if (path === "modPage") {
  //               // "/freeboard/freeModify.jsp" 페이지로 이동합니다.
  //               location.href =
  //                 "${pageContext.request.contextPath}/freeboard/freeModify?bno=" +
  //                 bno;
  //             } else if (path === "delete") {
  //               // 삭제 요청 처리 코드
  //               document.boardDetailForm.submit();
  //             }

  //             //
  //           } // 비번 일치하는 경우 끝
  //         } // 요청-응답 정상일때
  //       };

  //       request.send(data);
  //     }
  //   };
  // }

  //삭제 버튼 이벤트 처리
  // document.getElementById("del-btn").onclick = () => {
  //   if (confirm("정말 삭제하시겠습니까?")) {
  //     //확인(누르면 true 리턴)과 취소(누르면 false 리턴)가 있는 알림창
  //     document.boardDetailForm.setAttribute(
  //       "action",
  //       "${pageContext.request.contextPath}/freeboard/delete"
  //     ); //폼태그의 속성 바꾸기: setAttribute(바꾸고자하는속성이름, 내용)
  //     // jQuery로는 attr이라는 메서드 쓴다.

  //     document.boardDetailForm.submit();
  //   }
  // };
</script>

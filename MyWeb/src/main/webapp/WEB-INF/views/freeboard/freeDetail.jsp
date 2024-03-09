<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="../include/header.jsp" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
  small.password-check {
    display: block; /* 블록 레벨 요소로 만들어 줍니다 (새 줄에서 시작) */
    font-size: 0.8em; /* 작은 글씨 크기 */
    margin-top: 2px; /* 입력란과의 간격 */
    margin-bottom: 20px; /* 입력란과의 간격 */
  }
  input.input-sm::placeholder {
    /* color: red; */
    font-size: 0.8em;
    /* font-style: italic; */
  }
  textarea#content-line {
    height: auto;
  }
  .btn-lines {
    display: flex;
    flex-direction: row;
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

          <div class="btn-lines">
            <div class="passwordDiv form-group">
              <input
                id="modifyPwInput"
                class="form-control input-sm"
                type="password"
                name="inputPw"
                placeholder="비밀번호 입력 후 버튼 클릭"
              />

              <span style="display: none">
                <button
                  type="button"
                  class="btn btn-primary btn-sm confirm-btn"
                  id="pwConfirm"
                  style="
                    --bs-btn-padding-y: 0.25rem;
                    --bs-btn-padding-x: 0.5rem;
                    --bs-btn-font-size: 0.75rem;
                    height: 30px;
                    margin-top: 5px;
                  "
                >
                  확인
                </button>
              </span>
            </div>

            <button
              type="button"
              id="modifyBtn"
              class="btn btn-primary"
              style="height: 30px; margin-left: 3px; margin-top: 5px"
            >
              수정
            </button>
            <button
              type="button"
              id="deleteBtn"
              class="btn btn-primary"
              style="height: 30px; margin-left: 3px; margin-top: 5px"
            >
              삭제
            </button>
          </div>
          <small class="password-check"></small>

          <button
            type="button"
            class="btn btn-dark"
            onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList?pageNo=${p.pageNo}&amount=${p.amount}&keyword=${p.keyword}&condition=${p.condition}'"
          >
            목록
          </button>
          <button type="button" id="ansBtn" class="btn btn-dark">
            답변하기
          </button>

          <input type="hidden" name="refNo" value="${board.refNo}" />
          <input type="hidden" name="step" value="${board.step}" />
          <input type="hidden" name="refOrder" value="${board.refOrder}" />
          <input type="hidden" name="answerNo" value="${board.answerNo}" />
          <input type="hidden" name="parentNo" value="${board.parentNo}" />
        </form>
      </div>
    </div>
  </div>
</section>

<!-- 댓글 -->
<section style="margin-top: 50px">
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-md-9 write-wrap">
        <!-- 댓글 수 -->

        <div>
          <div>댓글수: <span id="replyCount">0</span></div>
        </div>

        <!-- 댓글 수 끝 -->
        <form class="reply-wrap">
          <div class="reply-image">
            <img src="${pageContext.request.contextPath}/img/profile.png" />
          </div>

          <div class="reply-content">
            <textarea
              class="form-control"
              rows="3"
              id="reply"
              placeholder="댓글은 300자 이내로 입력해주세요."
              style="margin-bottom: 0"
            ></textarea>
            <div style="display: flex; margin-top: 0">
              <span
                id="content-count"
                style="color: blue; margin: auto 0 0 auto"
                >0</span
              >/300
            </div>
            <div class="reply-group" style="display: flex">
              <div class="reply-input">
                <input
                  type="text"
                  class="form-control"
                  id="replyId"
                  placeholder="이름(10자 이내)"
                />
                <input
                  type="password"
                  class="form-control"
                  id="replyPw"
                  placeholder="비밀번호"
                />
                <small class="password-check"></small>
              </div>

              <button
                type="button"
                id="replyRegist"
                class="right btn btn-info"
                style="margin: auto 0 0 auto"
              >
                등록하기
              </button>
            </div>
          </div>
        </form>

        <div id="replyList">
          <!-- 자바스크립트를 활용하여 반복문을 이용해서 댓글의 개수만큼 반복 표현 -->
          <div class="reply-wrap">
            <div class="reply-image">
              <img src="${pageContext.request.contextPath}/img/profile.png" />
            </div>
            <div class="reply-content">
              <div class="reply-group">
                <strong class="left">honggildong</strong>
                <small class="left">2019/12/10</small>
                <a href="#" class="right"
                  ><span class="glyphicon glyphicon-pencil"></span>수정</a
                >
                <a href="#" class="right"
                  ><span class="glyphicon glyphicon-remove"></span>삭제</a
                >
              </div>
              <p class="clearfix">여기는 댓글영역</p>
            </div>
          </div>
        </div>

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
</section>

<!-- 모달 -->
<div class="modal fade" id="replyModal" role="dialog">
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
      <div class="modal-body">
        <!-- 수정폼 id값을 확인하세요-->
        <div class="reply-content">
          <textarea
            class="form-control"
            rows="4"
            id="modalReply"
            placeholder="내용입력(300자 이내)"
          ></textarea>
          <div class="reply-group">
            <div class="reply-input">
              <input type="hidden" id="modalRno" />
              <!-- 이름도 수정할 수 있게 하자 -->
              <input
                class="form-control"
                id="modalReplyWriter"
                placeholder="이름입력(10자 이내)"
              />
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
        </div>
        <!-- 수정폼끝 -->
      </div>
    </div>
  </div>
</div>

<%@ include file="../include/footer.jsp" %>

<script>
  var passwordDiv = document.querySelector(".passwordDiv");

  var passwordInput = document.getElementById("modifyPwInput");
  var passwordInput2 = document.getElementById("deletePwInput");

  var pwCheckBtn = document.getElementById("pwConfirm");

  var pwCheckText = document.querySelector("small.password-check");

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

  let boardAnsFlag = "${board.answerNo}"; //상세보기 중인 게시글의 자식 개수

  // 삭제된 게시글일 경우 목록버튼만 보이도록 설정
  if ($writer.value.length == 0 || $writer === "") {
    document.querySelector(".btn-lines").style.display = "none";
    pwCheckText.style.display = "none";
    document.getElementById("ansBtn").style.display = "none";
  }

  document.getElementById("ansBtn").onclick = function (e) {
    location.href =
      "${pageContext.request.contextPath}/freeboard/freeAnsRegist?bno=" + bno;
  };

  passwordInput.addEventListener("blur", (e) => {
    if (e.target.value.replace(/\s/g, "") && e.target.value !== null) {
      // 공백 이외 값을 입력했을 시
      if (e.target.value.length < 4 || e.target.value.length > 10) {
        // 비번 자릿수 안 맞을 시 검증 요청 보낼 필요도 없음
        document.querySelector("small.password-check").style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호가 일치하지 않습니다.";
        return;
      }
      pwCheck("delete");
      if (message === "pwCorrect") {
        document.querySelector("small.password-check").style.color = "green";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호가 일치합니다.";
      } else {
        document.querySelector("small.password-check").style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호가 일치하지 않습니다.";
      }
    }
  });

  passwordInput.addEventListener("input", (e) => {
    if (e.target.value.replace(/\s/g, "") && e.target.value !== null) {
      if (e.target.value.replace(/\s/g, "").length > 3) {
        pwCheck("delete");
        if (message === "pwCorrect") {
          document.querySelector("small.password-check").style.color = "green";
          document.querySelector("small.password-check").innerHTML =
            "비밀번호가 일치합니다.";
        } else {
          document.querySelector("small.password-check").style.color = "red";
          document.querySelector("small.password-check").innerHTML =
            "비밀번호가 일치하지 않습니다.";
        }
      }
    }
  });

  passwordInput.addEventListener("keydown", (e) => {
    if (e.key === " ") {
      e.preventDefault();
      // alert("비밀번호에 공백을 사용할 수 없습니다.");
      document.querySelector("small.password-check").style.color = "red";
      document.querySelector("small.password-check").innerHTML =
        "비밀번호에 공백을 사용할 수 없습니다.";
      // passwordInput.value = "";
      passwordInput.focus();
    }
    if (e.target.value.replace(/\s/g, "") && e.target.value !== null) {
      if (e.key === "Enter") {
        pwCheck("delete");

        if (message === "pwCorrect") {
          document.querySelector("small.password-check").style.color = "green";
          document.querySelector("small.password-check").innerHTML =
            "비밀번호가 일치합니다.";
        } else {
          document.querySelector("small.password-check").style.color = "red";
          document.querySelector("small.password-check").innerHTML =
            "비밀번호가 일치하지 않습니다.";
        }
      }
      if (e.key === "Backspace") {
        document.querySelector("small.password-check").innerHTML = "";
      }
      if (e.key === "Delete") {
        document.querySelector("small.password-check").innerHTML = "";
      }
    }
  });

  // 수정 버튼 클릭 시 이벤트: 토글
  document.getElementById("modifyBtn").onclick = function (e) {
    // message = "";
    // togglePasswordInput(e);
    if (passwordInput.value === "") {
      alert("비밀번호를 입력해주세요!");
      return;
    }
    if (passwordInput.value === null) {
      alert("비밀번호를 입력해주세요!");
      return;
    }
    if (passwordInput.value.length < 4 || passwordInput.value.length > 10) {
      passwordInput.style.borderColor = "red";
      passwordInput.style.color = "red";
      document.querySelector("small.password-check").innerHTML =
        "비밀번호는 4~10자리 입니다.";
      // alert("비밀번호 자릿수를 맞춰 주세요.");
      document.getElementById("modifyPwInput").value = "";
      document.getElementById("modifyPwInput").focus();
      return;
    } else {
      // 자릿수 통과
      // 비번 정규식 조합 검증
      if (!englishPattern.test(passwordInput.value)) {
        pwCheckText.style.borderColor = "red";
        pwCheckText.style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호는 영문을 포함해야 합니다.";
        // alert("비밀번호는 영문을 포함해야 합니다.");
        document.getElementById("modifyPwInput").value = "";
        document.getElementById("modifyPwInput").focus();
        return;
      }

      if (!numberPattern.test(passwordInput.value)) {
        pwCheckText.style.borderColor = "red";
        pwCheckText.style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호는 숫자를 포함해야 합니다.";
        // alert("비밀번호는 숫자를 포함해야 합니다.");
        document.getElementById("modifyPwInput").value = "";
        document.getElementById("modifyPwInput").focus();
        return;
      }

      if (!specialPattern.test(passwordInput.value)) {
        pwCheckText.style.borderColor = "red";
        pwCheckText.style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호는 특수문자를 포함해야 합니다.";
        // alert("비밀번호는 특수문자를 포함해야 합니다.");
        document.getElementById("modifyPwInput").value = "";
        document.getElementById("modifyPwInput").focus();
        return;
      }

      if (regex.test(passwordInput.value)) {
        pwCheck("delete");
      }
    }

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

        if (passwordInput.value.length < 4 || passwordInput.value.length > 10) {
          passwordInput.style.borderColor = "red";
          passwordInput.style.color = "red";
          document.querySelector("small.password-check").innerHTML =
            "적절한 자릿수의 비밀번호가 아닙니다.";
          // alert("비밀번호 자릿수를 맞춰 주세요.");
          document.getElementById("modifyPwInput").value = "";
          document.getElementById("modifyPwInput").focus();
          return;
        } else {
          // 자릿수 통과
          // 비번 정규식 조합 검증
          if (!englishPattern.test(passwordInput.value)) {
            pwCheckText.style.borderColor = "red";
            pwCheckText.style.color = "red";
            document.querySelector("small.password-check").innerHTML =
              "비밀번호는 영문을 포함해야 합니다.";
            // alert("비밀번호는 영문을 포함해야 합니다.");
            document.getElementById("modifyPwInput").value = "";
            document.getElementById("modifyPwInput").focus();
            return;
          }

          if (!numberPattern.test(passwordInput.value)) {
            pwCheckText.style.borderColor = "red";
            pwCheckText.style.color = "red";
            document.querySelector("small.password-check").innerHTML =
              "비밀번호는 숫자를 포함해야 합니다.";
            // alert("비밀번호는 숫자를 포함해야 합니다.");
            document.getElementById("modifyPwInput").value = "";
            document.getElementById("modifyPwInput").focus();
            return;
          }

          if (!specialPattern.test(passwordInput.value)) {
            pwCheckText.style.borderColor = "red";
            pwCheckText.style.color = "red";
            document.querySelector("small.password-check").innerHTML =
              "비밀번호는 특수문자를 포함해야 합니다.";
            // alert("비밀번호는 특수문자를 포함해야 합니다.");
            document.getElementById("modifyPwInput").value = "";
            document.getElementById("modifyPwInput").focus();
            return;
          }
          if (regex.test(passwordInput.value)) {
            pwCheck("modPage");
          }
        } // 자릿수 통과조건 끝
      } // Enter
    }; // 키다운이벤트 끝
    // 블러 이벤트
    passwordInput.addEventListener("blur", pwCheck("modPage"));

    if (message === "pwCorrect") {
      // document.querySelector("small.password-check").style.color = "green";
      // document.querySelector("small.password-check").innerHTML =
      //   "비밀번호가 일치합니다.";
      // if(pwCheckBtn.){ // 확인 클릭하면 }
      setTimeout(() => {
        console.log("수정적용 요청함!");
        pwCheckBtn.onclick = location.href = // 수정페이지 이동
          "${pageContext.request.contextPath}/freeboard/freeModify?bno=" + bno;
      }, 2000);
    } else {
      // document.querySelector("small.password-check").style.color = "red";
      // document.querySelector("small.password-check").innerHTML =
      //   "비밀번호가 일치하지 않습니다.";
    }
  };

  // 삭제 버튼 클릭 시 이벤트: 토글
  document.getElementById("deleteBtn").onclick = function (e) {
    // message = "";
    // togglePasswordInput(e);
    if (passwordInput.value === "") {
      alert("비밀번호를 입력해주세요!");
      return;
    }
    if (passwordInput.value === null) {
      alert("비밀번호를 입력해주세요!");
      return;
    }
    if (passwordInput.value.length < 4 || passwordInput.value.length > 10) {
      passwordInput.style.borderColor = "red";
      passwordInput.style.color = "red";
      document.querySelector("small.password-check").innerHTML =
        "비밀번호는 4~10자리 입니다.";
      // alert("비밀번호 자릿수를 맞춰 주세요.");
      document.getElementById("modifyPwInput").value = "";
      document.getElementById("modifyPwInput").focus();
      return;
    } else {
      // 자릿수 통과
      // 비번 정규식 조합 검증
      if (!englishPattern.test(passwordInput.value)) {
        pwCheckText.style.borderColor = "red";
        pwCheckText.style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호는 영문을 포함해야 합니다.";
        // alert("비밀번호는 영문을 포함해야 합니다.");
        document.getElementById("modifyPwInput").value = "";
        document.getElementById("modifyPwInput").focus();
        return;
      }

      if (!numberPattern.test(passwordInput.value)) {
        pwCheckText.style.borderColor = "red";
        pwCheckText.style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호는 숫자를 포함해야 합니다.";
        // alert("비밀번호는 숫자를 포함해야 합니다.");
        document.getElementById("modifyPwInput").value = "";
        document.getElementById("modifyPwInput").focus();
        return;
      }

      if (!specialPattern.test(passwordInput.value)) {
        pwCheckText.style.borderColor = "red";
        pwCheckText.style.color = "red";
        document.querySelector("small.password-check").innerHTML =
          "비밀번호는 특수문자를 포함해야 합니다.";
        // alert("비밀번호는 특수문자를 포함해야 합니다.");
        document.getElementById("modifyPwInput").value = "";
        document.getElementById("modifyPwInput").focus();
        return;
      }
      if (regex.test(passwordInput.value)) {
        pwCheck("delete");
      }
    }

    // 키다운 이벤트
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

        if (passwordInput.value.length < 4 || passwordInput.value.length > 10) {
          passwordInput.style.borderColor = "red";
          passwordInput.style.color = "red";
          document.querySelector("small.password-check").innerHTML =
            "적절한 자릿수의 비밀번호가 아닙니다.";
          // alert("비밀번호 자릿수를 맞춰 주세요.");
          document.getElementById("modifyPwInput").value = "";
          document.getElementById("modifyPwInput").focus();
          return;
        } else {
          // 자릿수 통과
          // 비번 정규식 조합 검증
          if (!englishPattern.test(passwordInput.value)) {
            pwCheckText.style.borderColor = "red";
            pwCheckText.style.color = "red";
            document.querySelector("small.password-check").innerHTML =
              "비밀번호는 영문을 포함해야 합니다.";
            // alert("비밀번호는 영문을 포함해야 합니다.");
            document.getElementById("modifyPwInput").value = "";
            document.getElementById("modifyPwInput").focus();
            return;
          }

          if (!numberPattern.test(passwordInput.value)) {
            pwCheckText.style.borderColor = "red";
            pwCheckText.style.color = "red";
            document.querySelector("small.password-check").innerHTML =
              "비밀번호는 숫자를 포함해야 합니다.";
            // alert("비밀번호는 숫자를 포함해야 합니다.");
            document.getElementById("modifyPwInput").value = "";
            document.getElementById("modifyPwInput").focus();
            return;
          }

          if (!specialPattern.test(passwordInput.value)) {
            pwCheckText.style.borderColor = "red";
            pwCheckText.style.color = "red";
            document.querySelector("small.password-check").innerHTML =
              "비밀번호는 특수문자를 포함해야 합니다.";
            // alert("비밀번호는 특수문자를 포함해야 합니다.");
            document.getElementById("modifyPwInput").value = "";
            document.getElementById("modifyPwInput").focus();
            return;
          }
          if (regex.test(passwordInput.value)) {
            pwCheck("delete");
          }
        } // 자릿수 통과조건 끝
      } //  Enter
    }; // 키다운이벤트 끝
    // 블러 이벤트
    passwordInput.addEventListener("blur", pwCheck("delete"));

    if (message === "pwCorrect") {
      // document.querySelector("small.password-check").style.color = "green";
      // document.querySelector("small.password-check").innerHTML =
      //   "비밀번호가 일치합니다.";
      if (boardAnsFlag > 0) {
        if (!confirm("답변이 존재하는 게시물입니다. 정말 삭제하시겠습니까?")) {
          return;
        }
      } else if (!confirm("정말 삭제하시겠습니까?")) {
        return;
      }

      // var request = new XMLHttpRequest();
      //       request.open(
      //         "POST",
      //         "${pageContext.request.contextPath}/freeboard/" + path,
      //         true
      //       );
      // if(pwCheckBtn.){ // 확인 클릭하면 }
      setTimeout(() => {
        console.log("삭제 요청함!");
        document.boardDetailForm.submit(); // 삭제 요청
      }, 2000);
      // document.boardDetailForm.addEventListener("submit", (e) => {
      //   e.preventDefault();
      //   const payload = new FormData(e.target);
      //   console.log([...payload]);
      // });

      // request.onreadystatechange = function () {
      //   if (request.readyState === 4 && request.status === 200) {
      //     var message = request.responseText;
      //     console.log(message);
      //     if (message === "deleteSuccess") {
      //       // 목록으로 리다이렉트
      //       window.location.href = "/freeboard/freeList";
      //     } else if (message === "deleteFailCauseOfChild") {
      //       alert("답변이 달린 게시글은 삭제할 수 없습니다.");
      //     }
      //   }
      // };
      // const msg = "${mes}";
      // const deletedBoard = "${delBoard}";
      // console.log("deleted board: ", deletedBoard);
      // console.log("msg: ", msg);
    } else {
      // document.querySelector("small.password-check").style.color = "red";
      // document.querySelector("small.password-check").innerHTML =
      //   "비밀번호가 일치하지 않습니다.";
    }
  };

  const msg = "${mes}";
  console.log("msg: ", msg);
  // if (msg === "childExist") {
  //   ("답변이 달린 게시글은 삭제할 수 없습니다.");
  //   window.location.href =
  //     "${pageContext.request.contextPath}/freeboard/freeList";
  // }

  function togglePasswordInput(e) {
    if (passwordDiv.style.display === "none") {
      if (e.target.id === "modifyBtn") {
        e.target.style.borderColor = "black";
      } else if (e.target.id === "deleteBtn") {
        e.target.style.borderColor = "black";
      }
      passwordDiv.style.display = "block";
      var passwordInput = passwordDiv.querySelector("input");
      passwordInput.focus();
    } else {
      passwordDiv.style.display = "none";
      passwordDiv.querySelector("input").onkeydown = null;
    }
  }

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
          document.querySelector("small.password-check").style.color = "green";
          document.querySelector("small.password-check").innerHTML =
            "비밀번호가 일치합니다.";
        } // 비번 일치하는 경우 끝
      } // 요청-응답 정상일때
    };

    request.send(data);
  } // 서버에 요청해 비번 체크하는 함수 끝

  /********** 댓글 ***********/

  window.onload = function () {
    const bno = "${board.bno}"; //현재 게시글 번호도 보내야 한다.
    const replyTag = document.getElementById("reply");
    let reply = document.getElementById("reply").value; // 댓글 내용

    const contentCount = document.querySelector("#content-count"); // 글세기

    const replyIdTag = document.getElementById("replyId");
    let replyId = document.getElementById("replyId").value; // 댓글 작성자

    const replyPwTag = document.getElementById("replyPw");
    let replyPw = document.getElementById("replyPw").value; // 댓글 비번
    const replyPwChk = document.getElementById("replyPw").nextElementSibling; // 댓글 비번 아래 글씨 small태그
    // console.log(replyPwChk);
    let pwFlag;
    replyPwTag.style.borderColor = "#ccc";
    replyPwChk.style.color = "black";
    replyPwChk.textContent = "";

    const replyModTag = document.getElementById("modalReply");
    const replyMod = document.getElementById("modalReply").value;
    const replyWriterTag = document.getElementById("modalReplyWriter");
    const replyWriter = document.getElementById("modalReplyWriter").value;
    const rno = document.getElementById("modalRno").value;
    const replyPwModTag = document.getElementById("modalPw");
    const replyPwMod = document.getElementById("modalPw").value;

    const replyPwChkDefault =
      "비밀번호는 영문, 숫자, 특수문자 조합 4~10자 이내로 입력";

    replyPwTag.addEventListener("click", (e) => {
      replyPwTag.style.borderColor = "black";
      replyPwChk.style.color = "black";
      if (e.target.value === "") {
        replyPwChk.textContent = replyPwChkDefault;
      } else {
        if (e.target.value.length < 4 || e.target.value.length > 10) {
          replyPwTag.focus();
          // alert("비밀번호는 10자 이내여야 합니다.");
          replyPwTag.style.borderColor = "red";
          replyPwChk.style.color = "red";
          replyPwChk.style.color = "red";
          replyPwChk.innerHTML = "비밀번호는 4~10자 이내여야 합니다.";
          var excess = e.target.value.replace(/\s/g, "").length - 10; // 초과하는 글자수 계산
          e.target.value = e.target.value.slice(0, -excess);
          pwFlag = false;
          return;
        }

        if (!englishPattern.test(replyPwTag.value)) {
          replyPwTag.style.borderColor = "red";
          replyPwChk.style.color = "red";
          replyPwChk.style.color = "red";
          replyPwChk.innerHTML = "비밀번호는 영문을 포함해야 합니다.";
          // alert("비밀번호는 영문을 포함해야 합니다.");
          // replyPwTag.value = "";
          replyPwTag.focus();
          return;
        } else if (!numberPattern.test(replyPwTag.value)) {
          replyPwTag.style.borderColor = "red";
          replyPwChk.style.color = "red";
          replyPwChk.style.color = "red";
          replyPwChk.innerHTML = "비밀번호는 숫자를 포함해야 합니다.";
          // alert("비밀번호는 숫자를 포함해야 합니다.");
          // replyPwTag.value = "";
          replyPwTag.focus();
          return;
        } else if (!specialPattern.test(replyPwTag.value)) {
          replyPwTag.style.borderColor = "red";
          replyPwChk.style.color = "red";
          replyPwChk.style.color = "red";
          replyPwChk.innerHTML = "비밀번호는 특수문자를 포함해야 합니다.";
          // replyPwTag.value = "";
          replyPwTag.focus();
          return;
        } else if (regex.test(e.target.value)) {
          replyPwTag.style.borderColor = "green";
          // replyPwTag.style.color = "green";
          replyPwChk.style.color = "green";
          replyPwChk.innerHTML = "사용가능합니다.";
          pwFlag = true;
        }
      }
    });
    replyPwTag.addEventListener("blur", (e) => {
      replyPwTag.style.borderColor = "#ccc";
      replyPwChk.style.color = "black";
      replyPwChk.textContent = "";
    });

    replyIdTag.addEventListener("paste", function () {
      console.log("이름 복붙에 대해 작동");
      setTimeout(function () {
        updateCount(replyIdTag, 10);
      }, 0);
    });
    replyTag.addEventListener("paste", function () {
      console.log("내용 복붙에 대해 작동");
      setTimeout(function () {
        updateCount(replyTag, 300, contentCount);
        // updateCount(replyTag, 300, "#content-count");
      }, 0);
    });

    replyWriterTag.addEventListener("paste", function () {
      console.log("이름 복붙에 대해 작동");
      setTimeout(function () {
        updateCount2(replyWriterTag, 10);
      }, 0);
    });
    updateCount2(replyWriterTag, 10);

    replyModTag.addEventListener("paste", function () {
      console.log("내용 복붙에 대해 작동");
      setTimeout(function () {
        updateCount(replyModTag, 300);
        // updateCount(replyTag, 300, "#content-count");
      }, 0);
    });

    // 문자열에서 공백과 줄바꿈을 제외한 글자수를 계산하는 함수입니다.
    function countCharacters(str) {
      return str.replace(/\s/g, "").length;
    }

    // 초과하는 글자수를 잘라내는 함수입니다.
    function trimExcessCharacters(str, limit) {
      const nonWhitespaceChars = str.match(/\S/g) || [];
      if (nonWhitespaceChars.length > limit) {
        const lastValidIndex = str.lastIndexOf(nonWhitespaceChars[limit - 1]);
        return str.slice(0, lastValidIndex + 1);
      }
      return str;
    }

    // 입력란의 글자수를 계산하고 출력하는 함수입니다.
    function updateCount(input, limit, countElement) {
      // 입력란의 값에서 공백과 줄바꿈을 제외한 글자수를 계산합니다.
      const count = countCharacters(input.value);

      // 글자수가 제한을 초과하는 경우 알림을 띄우고 초과분을 제거합니다.
      if (count > limit) {
        alert("글자수가 제한을 초과했습니다. 초과분은 자동으로 제거됩니다.");
        countElement.textContent = count;
        input.value = trimExcessCharacters(input.value, limit);
      } else {
        // 글자수를 출력 요소에 표시합니다.
        countElement.textContent = count;
      }
    }

    function updateCount2(input, limit) {
      // 입력란의 값에서 공백과 줄바꿈을 제외한 글자수를 계산합니다.
      const count = countCharacters(input.value);

      // 글자수가 제한을 초과하는 경우 알림을 띄우고 초과분을 제거합니다.
      if (count > limit) {
        alert("글자수가 제한을 초과했습니다. 초과분은 자동으로 제거됩니다.");

        input.value = trimExcessCharacters(input.value, limit);
      } else {
        // 글자수를 출력 요소에 표시합니다.
      }
    }

    // 이름
    replyIdTag.onkeyup = (e) => {
      if (anyBlank.test(e.target.value)) {
        alert("이름에 공백은 허용하지 않습니다.");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }
      if (blankPattern.test(e.target.value)) {
        alert("이름은 공백으로 시작할 수 없습니다.");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }
    };

    replyWriterTag.onkeyup = (e) => {
      if (anyBlank.test(e.target.value)) {
        alert("이름에 공백은 허용하지 않습니다.");
        e.target.value = "";
        e.target.focus();
        return;
      }
      if (blankPattern.test(e.target.value)) {
        alert("이름은 공백으로 시작할 수 없습니다.");
        e.target.value = "";
        e.target.focus();
        return;
      }
    };

    replyIdTag.oninput = (e) => {
      if (anyBlank.test(e.target.value)) {
        e.preventDefault();
        alert("이름에 공백은 허용하지 않습니다.!");
        // replyIdTag.value = e.target.value.replace(/\s/g, "");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }

      if (e.target.value.length > 10) {
        alert("이름은 10자 이내여야 합니다.");
        e.target.value = e.target.value.slice(0, 10);
        return;
      }

      if (e.target.value.includes("개새끼")) {
        alert("제목에 비속어가 감지되었습니다.");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }

      if (e.target.value.replace(/\s/g, "").length > 10) {
        alert("이름은 10자를 초과할 수 없습니다.");
        var excess = e.target.value.replace(/\s/g, "").length - 10; // 초과하는 글자수 계산

        e.target.value = e.target.value.slice(0, -excess);
        return;
      }
    };

    replyWriterTag.oninput = (e) => {
      if (anyBlank.test(e.target.value)) {
        e.preventDefault();
        alert("이름에 공백은 허용하지 않습니다.!");
        e.target.value = e.target.value.replace(/\s/g, "");
        e.target.focus();
        return;
      }

      if (e.target.value.length > 10) {
        alert("이름은 10자 이내여야 합니다.");
        e.target.value = e.target.value.slice(0, 10);
        return;
      }

      if (e.target.value.includes("개새끼")) {
        alert("제목에 비속어가 감지되었습니다.");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }

      if (e.target.value.replace(/\s/g, "").length > 10) {
        alert("이름은 10자를 초과할 수 없습니다.");
        var excess = e.target.value.replace(/\s/g, "").length - 10; // 초과하는 글자수 계산

        e.target.value = e.target.value.slice(0, -excess);
        return;
      }
    };

    //내용
    replyTag.oninput = (e) => {
      document.getElementById("content-count").innerText =
        e.target.value.length;
      // resize(e.target);

      if (blankPattern.test(e.target.value)) {
        alert("내용은 공백으로 시작할 수 없습니다.");
        replyTag.value = "";
        document.getElementById("content-count").innerText = 0;
        replyTag.focus();
        // resize(e.target);
        return;
      }

      // if (e.target.value.length > 1000) {
      //   alert("내용은 1000자를 초과할 수 없습니다.");
      //   e.target.value = e.target.value.slice(0, 1000);
      //   document.getElementById("count").innerText = e.target.value.length;
      //   resize(e.target);
      //   return;
      // }

      if (e.target.value.includes("개새끼")) {
        alert("내용에 비속어는 쓸 수 없습니다.");
        replyTag.value = "";
        replyTag.focus();
        return;
      }
    };

    replyModTag.oninput = (e) => {
      // document.getElementById("content-count").innerText =
      //   e.target.value.length;
      // resize(e.target);

      if (blankPattern.test(e.target.value)) {
        alert("내용은 공백으로 시작할 수 없습니다.");
        e.target.value = "";
        // document.getElementById("content-count").innerText = 0;
        e.target.focus();
        // resize(e.target);
        return;
      }

      // if (e.target.value.length > 1000) {
      //   alert("내용은 1000자를 초과할 수 없습니다.");
      //   e.target.value = e.target.value.slice(0, 1000);
      //   document.getElementById("count").innerText = e.target.value.length;
      //   resize(e.target);
      //   return;
      // }

      if (e.target.value.includes("개새끼")) {
        alert("내용에 비속어는 쓸 수 없습니다.");
        e.target.value = "";
        e.target.focus();
        return;
      }
    };

    replyTag.oninput = (e) => {
      setTimeout(function () {
        document.getElementById("content-count").innerText =
          e.target.value.replace(/\s/g, "").length;
        // resize(e.target);

        if (blankPattern.test(e.target.value)) {
          alert("내용은 공백으로 시작할 수 없습니다.");
          replyTag.value = "";
          document.getElementById("content-count").innerText = 0;
          replyTag.focus();
          // resize(e.target);
          return;
        }

        if (e.target.value.replace(/\s/g, "").length > 300) {
          alert("내용은 300자 이내여야 합니다.");
          var excess = e.target.value.replace(/\s/g, "").length - 300;
          e.target.value = e.target.value.slice(0, -excess);
          document.getElementById("content-count").innerText =
            e.target.value.replace(/\s/g, "").length;
          // resize(e.target);
          return;
        }

        if (e.target.value.includes("개새끼")) {
          alert("내용에 비속어는 쓸 수 없습니다.");
          replyTag.value = "";
          replyTag.focus();
          return;
        }
      }, 0);
    };

    replyModTag.oninput = (e) => {
      setTimeout(function () {
        // document.getElementById("content-count").innerText =
        //   e.target.value.replace(/\s/g, "").length;
        // resize(e.target);

        if (blankPattern.test(e.target.value)) {
          alert("내용은 공백으로 시작할 수 없습니다.");
          e.target.value = "";
          // document.getElementById("content-count").innerText = 0;
          e.target.focus();
          // resize(e.target);
          return;
        }

        if (e.target.value.replace(/\s/g, "").length > 300) {
          alert("내용은 300자 이내여야 합니다.");
          var excess = e.target.value.replace(/\s/g, "").length - 300;
          e.target.value = e.target.value.slice(0, -excess);
          // document.getElementById("content-count").innerText =
          //   e.target.value.replace(/\s/g, "").length;
          // resize(e.target);
          return;
        }

        if (e.target.value.includes("개새끼")) {
          alert("내용에 비속어는 쓸 수 없습니다.");
          e.target.value = "";
          e.target.focus();
          return;
        }
      }, 0);
    };

    /*비밀번호 형식 검사 스크립트*/
    replyPwTag.onkeyup = function (e) {
      if (anyBlank.test(e.target.value)) {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        // alert("비밀번호는 공백이 없어야 합니다.");
        replyPwChk.innerHTML = "공백은 비밀번호로 사용할 수 없습니다.";
        replyPwChk.value = "";
        replyPwChk.focus();
        pwFlag = false;
        return;
      }
      // 체크 공백
      if (replyPwTag.value.includes(" ")) {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "공백은 비밀번호로 사용할 수 없습니다.";
        replyPwChk.value = "";
        // document.getElementById("password").focus();
        // replyPwTag.value = replyPwTag.value.replace(" ", "");
        replyPwTag.focus();
        pwFlag = false;
        return; // 공백이 있는 경우 아래의 코드를 실행하지 않는다.
      }

      // if (replyPw.length < 4 || replyPw.length > 10) {
      //   replyPwTag.style.borderColor = "red";
      //   replyPwChk.style.color = "red";
      //   replyPwChk.innerHTML = "비밀번호의 글자수가 유효하지 않습니다.";
      //   replyPw = "";
      //   replyPwTag.focus();
      //   pwFlag = false;
      //   return;
      // }

      if (regex.test(replyPwTag.value)) {
        replyPwTag.style.borderColor = "green";
        replyPwChk.style.color = "green";
        replyPwChk.innerHTML = "사용가능합니다.";
        pwFlag = true;
      }
    };

    replyPwTag.onkeyup = function (e) {
      if (anyBlank.test(e.target.value)) {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        // alert("비밀번호는 공백이 없어야 합니다.");
        replyPwChk.innerHTML = "공백은 비밀번호로 사용할 수 없습니다.";
        replyPwChk.value = "";
        replyPwChk.focus();
        pwFlag = false;
        return;
      }
      // 체크 공백
      if (replyPwTag.value.includes(" ")) {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "공백은 비밀번호로 사용할 수 없습니다.";
        replyPwChk.value = "";
        // document.getElementById("password").focus();
        // replyPwTag.value = replyPwTag.value.replace(" ", "");
        replyPwTag.focus();
        pwFlag = false;
        return; // 공백이 있는 경우 아래의 코드를 실행하지 않는다.
      }

      // if (replyPw.length < 4 || replyPw.length > 10) {
      //   replyPwTag.style.borderColor = "red";
      //   replyPwChk.style.color = "red";
      //   replyPwChk.innerHTML = "비밀번호의 글자수가 유효하지 않습니다.";
      //   replyPw = "";
      //   replyPwTag.focus();
      //   pwFlag = false;
      //   return;
      // }

      if (regex.test(replyPwTag.value)) {
        replyPwTag.style.borderColor = "green";
        replyPwChk.style.color = "green";
        replyPwChk.innerHTML = "사용가능합니다.";
        pwFlag = true;
      }
    };

    replyPwTag.addEventListener("keydown", (e) => {
      replyPwTag.style.borderColor = "#ccc";
      replyPwChk.innerHTML = "";
      if (e.key === " ") {
        e.preventDefault();
        // alert("비밀번호에 공백을 사용할 수 없습니다.");
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "비밀번호에 공백을 사용할 수 없습니다.";
        // passwordInput.value = "";
        replyPwTag.focus();
      }
      if (e.target.value.replace(/\s/g, "") && e.target.value !== null) {
        if (e.key === "Enter") {
        }
        if (e.key === "Backspace") {
          replyPwTag.style.borderColor = "#ccc";
          replyPwChk.innerHTML = "";
        }
        if (e.key === "Delete") {
          replyPwTag.style.borderColor = "#ccc";
          replyPwChk.innerHTML = "";
        }
      }
      if (regex.test(replyPwTag.value)) {
        replyPwTag.style.borderColor = "green";
        replyPwChk.style.color = "green";
        replyPwChk.innerHTML = "사용가능합니다.";
        pwFlag = true;
      }
    });

    replyPwTag.onblur = function (e) {
      if (anyBlank.test(e.target.value)) {
        replyPwTag.style.borderColor = "red";
        replyPwTag.style.color = "red";
        // alert("비밀번호는 공백이 없어야 합니다.");
        replyPwChk.innerHTML = "공백은 비밀번호로 사용할 수 없습니다.";
        replyPwTag.value = "";
        replyPwTag.focus();
        pwFlag = false;
        return;
      }

      if (regex.test(replyPwTag.value)) {
        replyPwTag.style.borderColor = "green";
        replyPwChk.style.color = "green";
        replyPwChk.innerHTML = "사용가능합니다.";
        pwFlag = true;
      }
    };

    document.getElementById("modalPw").oninput = (e) => {
      if (e.target.value === " ") {
        e.preventDefault();
        alert("공백은 비밀번호로 사용할 수 없습니다.");
        e.target.value = "";
        e.target.focus();
        return;
      }
      if (anyBlank.test(e.target.value)) {
        e.preventDefault();
        alert("공백은 비밀번호로 사용할 수 없습니다.");
        e.target.value = e.target.value.replace(/\s/g, "");
        e.target.focus();
        return;
      }
    };

    //비밀번호 유효성 검사(크기제한)
    replyPwTag.oninput = (e) => {
      replyPwTag.style.borderColor = "#ccc";
      replyPwTag.style.color = "black";
      replyPwChk.style.color = "black";
      replyPwChk.innerHTML = "";
      if (replyPwTag.value === " ") {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "공백은 비밀번호로 사용할 수 없습니다.";
        e.target.value = "";
        e.target.focus();
        pwFlag = false;
        return;
      }
      if (anyBlank.test(e.target.value)) {
        // alert("비밀번호는 공백이 없어야 합니다.");
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "공백은 비밀번호로 사용할 수 없습니다.";
        e.target.value = "";
        e.target.focus();
        pwFlag = false;
        return;
      }

      if (e.target.value.length < 4 || e.target.value.length > 10) {
        replyPwTag.focus();
        // alert("비밀번호는 10자 이내여야 합니다.");
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "비밀번호는 4~10자 이내여야 합니다.";
        var excess = e.target.value.replace(/\s/g, "").length - 10; // 초과하는 글자수 계산
        e.target.value = e.target.value.slice(0, -excess);
        pwFlag = false;
        return;
      }

      if (!englishPattern.test(replyPwTag.value)) {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "비밀번호는 영문을 포함해야 합니다.";
        // alert("비밀번호는 영문을 포함해야 합니다.");
        // replyPwTag.value = "";
        replyPwTag.focus();
        return;
      } else if (!numberPattern.test(replyPwTag.value)) {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "비밀번호는 숫자를 포함해야 합니다.";
        // alert("비밀번호는 숫자를 포함해야 합니다.");
        // replyPwTag.value = "";
        replyPwTag.focus();
        return;
      } else if (!specialPattern.test(replyPwTag.value)) {
        replyPwTag.style.borderColor = "red";
        replyPwChk.style.color = "red";
        replyPwChk.style.color = "red";
        replyPwChk.innerHTML = "비밀번호는 특수문자를 포함해야 합니다.";
        // replyPwTag.value = "";
        replyPwTag.focus();
        return;
      } else if (regex.test(e.target.value)) {
        replyPwTag.style.borderColor = "green";
        // replyPwTag.style.color = "green";
        replyPwChk.style.color = "green";
        replyPwChk.innerHTML = "사용가능합니다.";
        pwFlag = true;
      }

      // if (e.target.value.includes("개새끼")) {
      //   alert("비밀번호는 비속어를 허용하지 않습니다.");
      //   document.getElementById("password").value = "";
      //   document.getElementById("password").focus();
      //   return;
      // }
    };

    document.getElementById("replyRegist").onclick = () => {
      console.log("댓글 등록이벤트가 발생함!");
      console.log(replyTag.value);
      ///
      console.log("내용 길이", replyTag.value.replace(/\s/g, "").length);
      console.log("이름 길이", replyIdTag.value.replace(/\s/g, "").length);
      console.log("비밀번호 길이", replyPwTag.value.replace(/\s/g, "").length);

      //유효성 검사
      if (replyTag.value === "") {
        alert("내용은 필수값입니다.");
        replyTag.value = "";
        document.getElementById("content-count").innerText = 0;
        replyTag.focus();
        return;
      }

      if (replyTag.value.trim() === "") {
        alert("내용에 공백만 작성할 수 없습니다.");
        replyTag.value = "";
        document.getElementById("content-count").innerText = 0;
        replyTag.focus();
        return;
      }

      if (replyTag.value.includes("개새끼")) {
        alert("내용에 비속어가 감지되었습니다.");
        replyTag.value = "";
        replyTag.focus();
        return;
      }

      if (replyIdTag.value === "") {
        alert("이름은 필수값입니다.");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }

      if (anyBlank.test(replyIdTag.value)) {
        alert("이름에 공백은 쓸 수 없습니다.");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }

      if (replyIdTag.value.includes("개새끼")) {
        alert("이름에 비속어를 포함할 수 없습니다.");
        replyIdTag.value = "";
        replyIdTag.focus();
        return;
      }

      if (replyPwTag.value === "") {
        replyPwTag.style.borderColor = "red";
        replyPwTag.style.color = "red";
        // replyPwChk.innerHTML =
        //   "적절한 형식의 비밀번호가 아닙니다.";
        alert("비밀번호는 필수값입니다.");
        replyPwTag.value = "";
        replyPwTag.focus();
        return;
      }

      if (replyPwTag.value.trim() === "") {
        replyPw.style.borderColor = "red";
        replyPw.style.color = "red";
        // document.querySelector(".password-check").innerHTML =
        //   "적절한 형식의 비밀번호가 아닙니다.";
        alert("비밀번호에 공백은 쓸 수 없습니다.");
        replyPwTag.value = "";
        replyPwTag.focus();
        return;
      }

      // if (!englishPattern.test(replyPwTag.value)) {
      //   replyPwTag.style.borderColor = "red";
      //   replyPwTag.style.color = "red";
      //   replyPwChk.innerHTML = "적절한 형식의 비밀번호가 아닙니다.";
      //   alert("비밀번호는 영문을 포함해야 합니다.");

      //   replyPwTag.value = "";
      //   replyPwTag.focus();
      //   return;
      // }

      // if (!numberPattern.test(replyPwTag.value)) {
      //   replyPwTag.style.borderColor = "red";
      //   replyPwTag.style.color = "red";
      //   replyPwChk.innerHTML = "적절한 형식의 비밀번호가 아닙니다.";
      //   alert("비밀번호는 숫자를 포함해야 합니다.");

      //   replyPwTag.value = "";
      //   replyPwTag.focus();
      //   return;
      // }

      // if (!specialPattern.test(replyPwTag.value)) {
      //   replyPwTag.style.borderColor = "red";
      //   replyPwTag.style.color = "red";
      //   replyPwChk.innerHTML = "적절한 형식의 비밀번호가 아닙니다.";
      //   alert("비밀번호는 특수문자를 포함해야 합니다.");
      //   replyPwTag.value = "";
      //   replyPwTag.focus();
      //   return;
      // }

      // if (replyPwTag.value.length < 4 || replyPwTag.value.length > 10) {
      //   replyPwTag.style.borderColor = "red";
      //   replyPwTag.style.color = "red";
      //   replyPwChk.innerHTML = "적절한 형식의 비밀번호가 아닙니다.";
      //   alert("비밀번호 자릿수를 맞춰 주세요.");
      //   replyPwTag.value = "";
      //   replyPwTag.focus();
      //   return;
      // }

      if (!pwFlag) {
        alert("비밀번호가 적절한 형식인지 확인해주세요.");
        return;
      }
      ///

      //요청에 관련된 정보 객체
      const reqObj = {
        method: "post",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          bno: bno,
          replyText: replyTag.value,
          replyId: replyIdTag.value,
          replyPw: replyPwTag.value,
        }),
      };

      fetch("${pageContext.request.contextPath}/reply", reqObj)
        .then((res) => res.text())
        .then((data) => {
          console.log("통신 성공!: ", data); //"regSuccess"
          //등록 성공했다면, 다음 등록을 위해 입력창을 비워주자.
          document.getElementById("reply").value = "";
          document.getElementById("replyId").value = "";
          document.getElementById("replyPw").value = "";
          replyPwTag.style.borderColor = "#ccc";
          replyPwTag.style.color = "black";
          replyPwChk.style.color = "black";
          replyPwChk.innerHTML = "";

          //등록 완료 후 댓글 목록 함수를 호출해서 비동기식으로 목록 표현.
          getList(1, true);
        });
    }; // 댓글 등록 이벤트 끝.

    //더보기 버튼 클릭 이벤트
    document.getElementById("moreList").onclick = () => {
      //왜 false를 주냐
      //더보기니까 -> 누적해서 보여줘야 하니까 -> 초기화하면 안됌!
      getList(++page, false);
    };

    let page = 1; //전역의 의미로 사용할 페이지 번호.
    let strAdd = ""; //화면에 그려넣을 태그를 문자열의 형태로 추가할 변수.
    const $replyList = document.getElementById("replyList");

    //게시글 상세보기 화면에 처음 진입했을 시 댓글 리스트를 한 번 불러오자.
    getList(1, true);

    //댓글 목록을 가져올 함수
    //getList의 매개값으로 뭘 줄거냐?
    //요청된 페이지 번호와, 화면을 리셋할 것인지의 여부를 bool 타입의 reset으로 받겠습니다.
    //비동기 방식이기 때문에 페이지가 그대로 계속 머물면서 댓글이 밑에 쌓입니다.
    //때에 따라서는 댓글을 계속 누적시키는 것이 아닌, 화면을 초기화하고 새롭게 보여줘야 할 때가 있다.
    //reset -> true: 페이지를 리셋해서 새롭게 그려내기, reset -> false:  누적해서 쌓기.
    /***** html태그등 안먹게 하는 함수 ******/
    function htmlEntities(str) {
      return String(str)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;");
    }

    function getList(pageNum, reset) {
      console.log("getList() 호출됨!");

      strAdd = ""; //새로운 내용을 작성하기 위해 변수의 값을 비우기.
      //댓글리스트위치 비우는 것 아님!!!!!!!!!!!!!

      const bno = "${board.bno}"; //현재 게시글 번호

      //get방식으로 댓글 목록을 요청 (비동기)
      fetch(
        "${pageContext.request.contextPath}/reply/list/" + bno + "/" + pageNum
      )
        .then((res) => res.json())
        .then((data) => {
          console.log("서버가 전달한 map: ", data);

          let total = data.total; //총 댓글 수
          let replyList = data.list; //댓글 리스트

          document.getElementById("replyCount").innerHTML = total;

          //응답 데이터의 길이가 0과 같거나 더 작으면 함수를 종료
          if (replyList.length <= 0) return;

          if (reset) {
            //더보기 눌렀을 때 reset==false이므로 수행x
            while ($replyList.firstChild) {
              $replyList.firstChild.remove();
            }
            page = 1;
          }

          //더보기 버튼 배치 판단
          //현재 페이지번호 * 이번요청으로 받은 페이지당보여줄댓글수 > 전체 댓글수 -> 더보기 없어도 됌.
          console.log("현재 페이지: ", page);
          if (total <= page * 5) {
            document.getElementById("moreList").style.display = "none";
          } else {
            document.getElementById("moreList").style.display = "block";
          }

          //replyList의 개수만큼 태그를 문자열 형태로 직접 그림.
          //중간중간에 들어가야 할 글쓴이, 날짜, 댓글 내용은 목록에서 꺼내서 표현.
          for (let i = 0; i < replyList.length; i++) {
            strAdd +=
              `<div class='reply-wrap'>
                                <div class='reply-image'>
                                    <img src='${pageContext.request.contextPath}/img/profile.png'>
                                </div>
                                <div class='reply-content'>
                                    <div class='reply-group'>
                                        <strong class='left'>` +
              htmlEntities(replyList[i].replyWriter) +
              `</strong>
                                        <small class='left'>` +
              parseTime(replyList[i].date) +
              `</small>
                                        <a href='` +
              replyList[i].rno +
              `' class='right replyDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a>
                                        <a href='` +
              replyList[i].rno +
              `' class='right replyModify'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                                    </div>
                                    <p class='clearfix'>` +
              htmlEntities(replyList[i].replyText) +
              `</p>
                                </div>
                            </div>`;
          }

          //id가 replyList라는 div 영역에 문자열 형식으로 모든 댓글을 추가.
          // document.getElementById('replyList').innerHTML = strAdd;
          //insertAdjacentHTML(): 인접한 곳에 HTML을 삽입하는 함수.
          //(position문자열, 문자열 형태의 HTML)
          if (!reset) {
            $replyList.insertAdjacentHTML("beforeend", strAdd); //위치, 값: 매개변수
          } else {
            $replyList.insertAdjacentHTML("afterbegin", strAdd);
          }
        }); // .then()의 끝
    } //end getList()

    //수정, 삭제
    /*
            document.querySelector('.replyModify').onclick = function (e) {
                e.preventDefault();
                console.log('수정 버튼 이벤트 발생!');
            } (이거 동작 안함!!!!!!!!!!!!)

            - .replyModify 요소는 실제 존재하는 요소가 아니라
            비동기 통신을 통해 생성되는 요소입니다.
            그러다 보니 이벤트가 등록되는 시점보다 fetch함수의 실행이 먼저 끝날 것이라는
            보장이 없기 때문에 해당 방식은 이벤트 등록이 불가능합니다.

            이 때는 이미 실제로 존재하는 #replyList에 이벤트를 등록하고, 이벤트를 자식에게 위임하여
            사용하는 addEventListener를 통해 처리해야 합니다.
            */
    document.getElementById("replyList").addEventListener("click", (e) => {
      //addEventListener()의 매개변수: type, func
      e.preventDefault(); //태그의 고유 기능을 중지.

      //1. 이벤트가 발생한 target이 a태그가 아니라면 이벤트 강제 종료!
      if (!e.target.matches("a")) return;

      console.log("a에만 이벤트 발생!");

      //2. a태그가 두 개(수정, 삭제)이므로 어떤 링크인지를 확인.
      //댓글이 여러 개 -> 수정, 삭제가 발생하는 댓글이 몇 번인지도 확인해야 한다.
      const rno = e.target.getAttribute("href"); //a태그의 속성 얻기
      console.log("댓글 번호: ", rno);
      //모달 내부에 숨겨진 input 태그에 댓글번호를 달아주자.
      document.getElementById("modalRno").value = rno;

      //댓글 내용도 가져와서 모달에 뿌려주자.
      const content = e.target.parentNode.nextElementSibling.textContent;
      console.log("댓글 내용: ", content);
      // 댓글 작성자도 가져와서 모달에 뿌려주자
      const writer = e.target.parentNode.firstElementChild.textContent;
      console.log("글쓴이: ", writer);

      //3. 모달 창 하나를 이용해서 상황에 맞게 수정 / 삭제 모달을 제공해야 한다.
      //조건문을 작성 (수정 or 삭제에 따라 모달 디자인을 조정)
      if (e.target.classList.contains("replyModify")) {
        //수정 버튼을 눌렀으므로 수정 모달 형식으로 꾸며주겠다.
        document.querySelector(".modal-title").textContent = "댓글 수정"; // 제목 설정
        document.getElementById("modalReply").style.display = "inline"; // 댓글 내용 보이기
        document.getElementById("modalReplyWriter").style.display = "inline"; // 댓글 작성자 보이기

        document.getElementById("modalReply").value = content; // 댓글 내용
        document.getElementById("modalReplyWriter").value = writer; // 댓글 작성자
        document.getElementById("modalModBtn").style.display = "inline";
        document.getElementById("modalDelBtn").style.display = "none";

        //어쩔 수 없이 제이쿼리를 이용하여 bootstrap 모달을 여는 방법
        $("#replyModal").modal("show");
      } else {
        document.querySelector(".modal-title").textContent = "댓글 삭제"; // 제목 설정
        document.getElementById("modalReply").style.display = "none"; // 댓글 내용 숨기기
        document.getElementById("modalReplyWriter").style.display = "none"; // 댓글 작성자 숨기기
        document.getElementById("modalModBtn").style.display = "none";
        document.getElementById("modalDelBtn").style.display = "inline";

        $("#replyModal").modal("show");
      }
    }); // 수정 or 삭제 버튼 클릭 이벤트 끝.

    //수정 처리 함수. (수정 모달을 열어서 수정 내용을 작성한 후 수정 버튼을 클릭했을 때)
    document.getElementById("modalModBtn").onclick = () => {
      const reply = document.getElementById("modalReply").value;
      const replyWriter = document.getElementById("modalReplyWriter").value;
      const rno = document.getElementById("modalRno").value;
      const replyPw = document.getElementById("modalPw").value;

      if (reply === "" || replyPw === "" || replyWriter === "") {
        alert("이름, 내용, 비밀번호를 입력하세요!");
        return;
      }
      if (
        reply.trim() === "" ||
        replyPw.trim() === "" ||
        replyWriter.trim() === ""
      ) {
        alert("이름, 내용, 비밀번호를 입력하세요!");
        return;
      }

      //요청에 관련된 정보 객체
      const reqObj = {
        method: "put",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          replyText: reply,
          replyWriter: replyWriter,
          replyPw: replyPw,
        }),
      };

      fetch("${pageContext.request.contextPath}/reply/" + rno, reqObj)
        .then((res) => res.text())
        .then((data) => {
          if (data === "pwFail") {
            alert("비밀번호를 확인하세요!");
            document.getElementById("modalPw").value = "";
            document.getElementById("modalPw").focus();
          } else {
            alert("정상 수정되었습니다.");
            //모달에 작성된 내용들을 지워주자.
            document.getElementById("modalReply").value = "";
            document.getElementById("modalPw").value = "";
            //제이쿼리 문법으로 bootstrap 모달 닫아주기
            $("#replyModal").modal("hide");
            getList(1, true); //수정 내용 반영
          }
        });
    }; // end update event

    //삭제 이벤트
    document.getElementById("modalDelBtn").onclick = () => {
      /*
                1. 모달창에 rno값, replyPw 값을 얻습니다.

                2. fetch 함수를 이용해서 DELETE 방식으로 reply/{rno} 요청

                3. 서버에서는 요청을 받아서 비밀번호를 확인하고, 비밀번호가 맞으면
                삭제를 진행하시면 됩니다.

                4. 만약 비밀번호가 틀렸다면, 문자열을 반환해서
                '비밀번호가 틀렸습니다.' 경고창을 띄우세요.

                삭제 완료되면 모달 닫고 목록 요청 다시 보내세요. (reset의 여부를 잘 판단)
                */
      const rno = document.getElementById("modalRno").value;
      const replyPw = document.getElementById("modalPw").value;

      if (replyPw === "" || replyPw.trim() === "") {
        alert("비밀번호를 입력하세요!");
        document.getElementById("modalPw").focus();
        return;
      }

      if (!confirm("정말 삭제하시겠습니까?")) {
        return;
      }

      const reqObj = {
        method: "delete",
        headers: {
          "Content-Type": "text/plain",
        },
        body: replyPw,
      };

      fetch("${pageContext.request.contextPath}/reply/" + rno, reqObj)
        .then((res) => res.text())
        .then((data) => {
          console.log(data);

          if (data === "pwFail") {
            alert("비밀번호가 틀렸습니다.");
            document.getElementById("modalPw").value = "";
            document.getElementById("modalPw").focus();
          } else {
            alert("댓글이 삭제되었습니다.");
            document.getElementById("modalPw").value = "";
            //제이쿼리 문법으로 bootstrap 모달 닫아주기
            $("#replyModal").modal("hide");
            getList(1, true); //삭제 내용 반영
          }
        });
    }; // end delete event

    //댓글 날짜 변환 함수
    function parseTime(regDate) {
      //원하는 날짜로 객체를 생성.
      const now = new Date();
      let regTime = new Date(regDate);

      //getTime(): 1970년 1월 1일 자정을 기준으로 현재까지의 시간을 밀리초로 리턴.
      const gap = now.getTime() - regTime.getTime();

      let time;
      if (gap < 60 * 60 * 24 * 1000) {
        //밀리초니까 1000 곱해준다. 시간차가 하루보다 작으면
        if (gap < 60 * 60 * 1000) {
          //시간차가 1시간보다 작으면
          time = "방금 전";
        } else {
          time = parseInt(gap / (1000 * 60 * 60)) + "시간 전";
        }
      } else if (gap < 60 * 60 * 24 * 30 * 1000) {
        //한달보다 작으면
        time = parseInt(gap / (1000 * 60 * 60 * 24)) + "일 전";
      } else {
        time = `\${regTime.getFullYear()}년 \${regTime.getMonth()+1}월 \${regTime.getDate()}일`;
      }

      if (regDate.includes("(수정됨)")) return time + "(수정됨)";
      return time;
    }
  }; //window.onload
</script>

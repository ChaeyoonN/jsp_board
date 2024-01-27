<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="../include/header.jsp" %>
<style>
  small.password-instruction {
    display: block; /* 블록 레벨 요소로 만들어 줍니다 (새 줄에서 시작) */
    font-size: 0.8em; /* 작은 글씨 크기 */
    color: #6c757d; /* 글씨 색상 */
    margin-top: 5px; /* 입력란과의 간격 */
  }
  small.password-check {
    display: block; /* 블록 레벨 요소로 만들어 줍니다 (새 줄에서 시작) */
    font-size: 0.8em; /* 작은 글씨 크기 */
    /* color: red; 글씨 색상 */
    margin-top: 5px; /* 입력란과의 간격 */
  }
</style>

<section>
  <div class="container">
    <div class="row">
      <div class="col-xs-12 content-wrap">
        <div class="titlebox">
          <p>자유게시판</p>
        </div>

        <form method="post" name="boardForm">
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
          <div class="titlefoot">
            <button type="button" class="btn">등록</button>
            <button
              type="button"
              class="btn"
              onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList'"
            >
              목록
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

<%@ include file="../include/footer.jsp" %>

<script>
  let formTag = document.forms[0];
  let writerTag = document.boardForm.writer;
  let passwordTag = document.boardForm.password;
  let titleTag = document.boardForm.title;
  let contentTag = document.boardForm.content;

  let pwFlag; // 등록 폼 보내기 전에 유효성 여부 판단

  console.log(formTag);
  console.log(writerTag);
  console.log(passwordTag);
  console.log(titleTag);
  console.log(contentTag);

  let badList = ["개새끼", "병신"];

  const badwordHandler = (target) => {
    for (const bad of badList) {
      if (
        target.value.trim().includes(bad) ||
        target.value.trim().includes(bad)
      ) {
        return true;
      }
    }
    return false;
  };

  // 등록 이벤트
  document.querySelector(".titlefoot>button:first-child").onclick = () => {
    /***************** 공백만 입력 제한 **********************/
    if (writerTag.value.trim().length <= 0) {
      alert("이름을 입력해 주세요. 공백만 입력할 수 없습니다.");

      return;
    }
    if (titleTag.value.trim().length <= 0) {
      alert("제목을 입력해 주세요. 공백만 입력할 수 없습니다.");

      return;
    }
    if (contentTag.value.trim().length <= 0) {
      alert("내용을 입력해 주세요. 공백만 입력할 수 없습니다.");

      return;
    }
    console.log("제목과 내용이 공백이 아닌 경우!");

    /****************** 비속어 거르기 *********************/
    if (badwordHandler(titleTag) || badwordHandler(contentTag)) {
      alert(
        "욕설 및 비속어가 감지되었습니다. 욕설 및 비속어는 등록할 수 없습니다."
      );

      return;
    }

    /**************** 비밀번호 형식검사 미통과 거르기 ***************/

    if (!pwFlag) {
      return;
    }

    document.boardForm.submit();
  };

  var textarea = document.getElementById("content");

  var strongTag = document.createElement("span");
  strongTag.style.color = "blue"; // 왜 안먹을까?
  strongTag.style.fontWeight = "bold"; // 왜 안먹을까?
  var strongTagText = "본인이 작성한 의견에 대해 법적 책임을 갖는다";
  strongTag.innerHTML = strongTagText;

  console.log(strongTag.innerHTML);
  // var result = strongTagText.fontcolor("blue");

  textarea.addEventListener("click", function () {
    var placeholderText =
      "다양한 의견이 존중될 수 있도록 다른 사람에게 불쾌감을 주는 욕설, 혐오, 비하의 표현이나 타인의 권리를 침해하는 내용은 주의해주세요. 모든 작성자는 " +
      strongTag.innerHTML +
      "는 점 유의하시길 바랍니다.";

    textarea.placeholder = placeholderText;
  });

  textarea.addEventListener("blur", function (e) {
    if (!e.value) {
      textarea.placeholder = "내용은 1000자 이내로 적어주세요.";
    }
  });

  /***************** 내용 글자수 제한 **********************/
  // 이름 허용 용량: 한글 30자 (컬럼 바차2 100바이트)
  // 제목 허용 용량: 한글 40글자 (컬럼 바차2 150바이트)
  // 내용 허용 용량: 한글 1000자 (컬럼 바차2 4000바이트)

  // 커서 맨뒤로 보내는 함수
  const moveCursorToEnd = (e) => {
    console.log("Move cursor to the end!");
    console.log("Event element: ", e.target);
    if (e.target.tagName !== "INPUT" && e.target.tagName !== "TEXTAREA") {
      return;
    }

    const len = e.target.value.length;
    e.target.focus();
    e.target.setSelectionRange(len, len);
  };

  //   var table = document.querySelector('.t-control');
  //   table.addEventListener('click', moveCursorBack);

  // 공백 제외 글자수 세는 함수
  function onInputCount(e) {
    // input 또는 textarea 요소를 선택합니다.
    // 입력 내용을 가져옵니다.
    var inputElement = e.target;
    var inputValue = inputElement.value;
    // console.log("입력값: ", inputValue);
    console.log("입력값 길이(공백 포함): ", inputValue.length);
    // console.log("입력값 길이(공백 미포함): ",inputValue.replaceAll(' ', '').length);

    // 줄바꿈 제거
    var noEnter = inputValue.replace(/\n/g, "");

    // 공백 제거
    var noBlank = noEnter.replace(/\s*/g, "");
    var noSpace = noBlank.replaceAll(" ", "");

    console.log("입력값 길이(공백 미포함): ", noSpace.length);

    return noSpace.length;
  }

  // 글자수를 span태그안에 넣는 함수
  function onInputPrint(e) {
    var inputElement = e.target;
    var inputValue = inputElement.value;

    // 글자수 출력 span태그 있다면 넣기
    const siblingDiv =
      inputValue.nextElementSibling.tagName === "DIV"
        ? inputValue.nextElementSibling
        : inputValue.previousElementSibling.tagName === "DIV"
        ? inputValue.previousElementSibling
        : null;

    if (siblingDiv) {
      console.log("형제 div 태그가 있습니다: ", siblingDiv);
      const innerSpan = siblingDiv.querySelector("span");
      if (innerSpan) {
        innerSpan.innerHTML = PureLength; // 넣기
        console.log("글자수 넣기 완료!");
      } else {
        console.log("'div' 형제 요소 안에 'span' 태그가 없습니다.");
      }
    } else {
      console.log("형제 div 태그가 없습니다.");
    }
  }

  /*************함수 호출***************/
  titleTag.addEventListener("input", function (e) {
    var maxLength = 40;

    // 길이 계산을 위해 스페이스와 줄바꿈 문자를 제거하지만 입력값에는 그대로 유지
    var valueWithoutSpaces = e.target.value.replace(/\s/g, "");
    var currentLength = valueWithoutSpaces.length;

    // 글자수를 세서 span 태그에 출력
    document.getElementById("title-count").innerText = currentLength;

    // 특정 글자수를 넘으면 알림창을 띄우고 초과한 글자수를 지워줌
    if (currentLength > maxLength) {
      alert("입력 가능한 글자수가 초과되었습니다!");
      var excessLength = currentLength - maxLength;
      var actualLength = e.target.value.length;
      e.target.value = e.target.value.substring(0, actualLength - excessLength);
      currentLength = e.target.value.replace(/\s/g, "").length;

      // 글자수를 다시 세서 span 태그에 출력
      document.getElementById("title-count").innerText = currentLength;

      // 커서를 맨마지막 부분에 놓음
      e.target.focus();
      var cursorPosition = e.target.value.length;
      e.target.setSelectionRange(cursorPosition, cursorPosition);
    }
  });

  contentTag.addEventListener("input", function (e) {
    var maxLength = 1000;

    // 길이 계산을 위해 스페이스와 줄바꿈 문자를 제거하지만 입력값에는 그대로 유지
    var valueWithoutSpaces = e.target.value.replace(/\s/g, "");
    var currentLength = valueWithoutSpaces.length;

    // 글자수를 세서 span 태그에 출력
    document.getElementById("content-count").innerText = currentLength;

    // 특정 글자수를 넘으면 알림창을 띄우고 초과한 글자수를 지워줌
    if (currentLength > maxLength) {
      alert("입력 가능한 글자수가 초과되었습니다!");
      var excessLength = currentLength - maxLength;
      var actualLength = e.target.value.length;
      e.target.value = e.target.value.substring(0, actualLength - excessLength);
      currentLength = e.target.value.replace(/\s/g, "").length;

      // 글자수를 다시 세서 span 태그에 출력
      document.getElementById("content-count").innerText = currentLength;

      // 커서를 맨마지막 부분에 놓음
      e.target.focus();
      var cursorPosition = e.target.value.length;
      e.target.setSelectionRange(cursorPosition, cursorPosition);
    }
  });

  writerTag.addEventListener("input", function (e) {
    var maxLength = 10;

    // 스페이스와 줄바꿈 문자를 제거한 후 길이를 계산
    var currentLength = e.target.value.replace(/\s/g, "").length;

    // 글자수를 세서 span 태그에 출력
    document.getElementById("writer-count").innerText = currentLength;

    // 특정 글자수를 넘으면 알림창을 띄우고 초과한 글자수를 지워줌
    if (currentLength > maxLength) {
      alert("입력 가능한 글자수가 초과되었습니다!");
      e.target.value = e.target.value.substring(0, maxLength);
      currentLength = e.target.value.replace(/\s/g, "").length;

      // 글자수를 다시 세서 span 태그에 출력
      document.getElementById("writer-count").innerText = currentLength;
    }

    // 커서를 맨마지막 부분에 놓음
    e.target.focus();
    e.target.setSelectionRange(currentLength, currentLength);
  });
  //   titleTag.addEventListener("input", onInputRemove);
  //   contentTag.addEventListener("input", onInputRemove);
  //   writerTag.addEventListener("input", onInputRemove);

  /*비밀번호 형식 검사 스크립트*/
  passwordTag.onkeyup = function () {
    var regex = /^.*(?=^.{4,10}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

    // 체크 공백
    if (passwordTag.value.includes(" ")) {
      passwordTag.style.borderColor = "red";
      passwordTag.style.color = "red";
      document.querySelector(".password-check").innerHTML =
        "공백은 비밀번호로 사용할 수 없습니다.";

      passwordTag.value = passwordTag.value.replace(" ", "");
      passwordTag.focus();
      pwFlag = false;
      return; // 공백이 있는 경우 아래의 코드를 실행하지 않는다.
    }

    if (regex.test(passwordTag.value)) {
      passwordTag.style.borderColor = "green";
      passwordTag.style.color = "green";
      document.querySelector(".password-check").innerHTML = "사용가능합니다.";
      pwFlag = true;
    } else {
      passwordTag.style.borderColor = "red";
      passwordTag.style.color = "red";
      document.querySelector(".password-check").innerHTML =
        "적절한 형식의 비밀번호가 아닙니다.";
      pwFlag = false;
    }
  };
</script>

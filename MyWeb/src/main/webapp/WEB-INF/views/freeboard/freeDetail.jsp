﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
  textarea#content-line {
    height: auto;
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

        <form name="boardDetailForm" action="" method="post">
          <div>
            <label>날짜</label>
            <p>${board.date}</p>
            <!-- <input
              class="form-control"
              name="date"
              value="${board.date}"
              readonly
            /> -->
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
              value="${fn:escapeXml(board.title)}"
              readonly
            />
          </div>

          <div class="form-group">
            <label>내용</label>
            <!-- <div style="white-space: pre-wrap"> -->
            <input
              id="content-line"
              class="form-control"
              name="content"
              value="${fn:escapeXml(board.content)}"
              readonly
            />
            <!-- </div> -->
            <!-- <textarea
              id="content-line"
              class="form-control"
              name="content"
              readonly
            >
              ${fn:escapeXml(board.content)}
            </textarea> -->
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
          <div class="passwordDiv form-group" style="display: none">
            <input
              class="form-control input-sm"
              type="password"
              name="inputPw"
              placeholder="비밀번호를 입력해주세요."
            />
            <small class="password-check"></small>
          </div>
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
  // const DEFAULT_HEIGHT = 30; // textarea 기본 height

  // const $textarea = document.querySelector("textarea#content-line");

  // // Textarea 자동 높이 조절

  // $target.style.height = DEFAULT_HEIGHT + $target.scrollHeight + "px";

  // 수정 버튼 이벤트 처리
  function togglePasswordInput(path) {
    var passwordDiv = document.querySelector(".passwordDiv");
    if (passwordDiv.style.display === "none") {
      passwordDiv.style.display = "block";
      var passwordInput = passwordDiv.querySelector("input");
      passwordInput.focus();

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
            return;
          } else if (
            path === "freeModify" &&
            !confirm("정말로 수정하시겠습니까?")
          ) {
            return;
          } else if (
            path === "delete" &&
            !confirm("정말로 삭제하시겠습니까?")
          ) {
            return;
          }

          var request = new XMLHttpRequest();
          request.open("POST", "/freeboard/" + path, true);
          request.setRequestHeader(
            "Content-Type",
            "application/x-www-form-urlencoded"
          );

          request.onreadystatechange = function () {
            if (request.readyState === 4 && request.status === 200) {
              var message = request.responseText;
              if (message === "pwWrong") {
                alert("비밀번호가 일치하지 않습니다.");
              } else if (message === "pwCorrect") {
                alert("비밀번호가 일치합니다.");
                location.href = "/freeboard/freeList.jsp";
              }
            }
          };

          request.send("inputPw=" + encodeURIComponent(passwordInput.value));
        }
      };
    } else {
      passwordDiv.style.display = "none";
      passwordDiv.querySelector("input").onkeydown = null;
    }
  }

  document.getElementById("modifyBtn").addEventListener("click", function () {
    togglePasswordInput("freeModify");
  });

  document.getElementById("deleteBtn").addEventListener("click", function () {
    togglePasswordInput("delete");
  });

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

  // window.onload = function () {
  //   /*** 댓글 ***/
  //   document.getElementById("replyRegist").onclick = () => {
  //     console.log("댓글 등록이벤트가 발생함!");

  //     const bno = "${board.bno}"; //현재 게시글 번호도 보내야 한다.
  //     const reply = document.getElementById("reply").value;
  //     const replyId = document.getElementById("replyId").value;
  //     const replyPw = document.getElementById("replyPw").value;

  //     if (reply === "" || replyId === "" || replyPw === "") {
  //       alert("이름, 비밀번호, 내용은 필수 값입니다.");
  //       return;
  //     }

  //     //요청에 관련된 정보 객체
  //     const reqObj = {
  //       method: "post",
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: JSON.stringify({
  //         bno: bno,
  //         replyText: reply,
  //         replyId: replyId,
  //         replyPw: replyPw,
  //       }),
  //     };

  //     fetch("${pageContext.request.contextPath}/reply", reqObj)
  //       .then((res) => res.text())
  //       .then((data) => {
  //         console.log("통신 성공!: ", data); //"regSuccess"
  //         //등록 성공했다면, 다음 등록을 위해 입력창을 비워주자.
  //         document.getElementById("reply").value = "";
  //         document.getElementById("replyId").value = "";
  //         document.getElementById("replyPw").value = "";

  //         //등록 완료 후 댓글 목록 함수를 호출해서 비동기식으로 목록 표현.
  //         getList(1, true);
  //       });
  //   }; // 댓글 등록 이벤트 끝.

  //   //더보기 버튼 클릭 이벤트
  //   document.getElementById("moreList").onclick = () => {
  //     //왜 false를 주냐
  //     //더보기니까 -> 누적해서 보여줘야 하니까 -> 초기화하면 안됌!
  //     getList(++page, false);
  //   };

  //   let page = 1; //전역의 의미로 사용할 페이지 번호.
  //   let strAdd = ""; //화면에 그려넣을 태그를 문자열의 형태로 추가할 변수.
  //   const $replyList = document.getElementById("replyList");

  //   //게시글 상세보기 화면에 처음 진입했을 시 댓글 리스트를 한 번 불러오자.
  //   getList(1, true);

  //   //댓글 목록을 가져올 함수
  //   //getList의 매개값으로 뭘 줄거냐?
  //   //요청된 페이지 번호와, 화면을 리셋할 것인지의 여부를 bool 타입의 reset으로 받겠습니다.
  //   //비동기 방식이기 때문에 페이지가 그대로 계속 머물면서 댓글이 밑에 쌓입니다.
  //   //때에 따라서는 댓글을 계속 누적시키는 것이 아닌, 화면을 초기화하고 새롭게 보여줘야 할 때가 있다.
  //   //reset -> true: 페이지를 리셋해서 새롭게 그려내기, reset -> false:  누적해서 쌓기.
  //   function getList(pageNum, reset) {
  //     console.log("getList() 호출됨!");

  //     strAdd = ""; //새로운 내용을 작성하기 위해 변수의 값을 비우기.
  //     //댓글리스트위치 비우는 것 아님!!!!!!!!!!!!!

  //     const bno = "${board.bno}"; //현재 게시글 번호

  //     //get방식으로 댓글 목록을 요청 (비동기)
  //     fetch(
  //       "${pageContext.request.contextPath}/reply/list/" + bno + "/" + pageNum
  //     )
  //       .then((res) => res.json())
  //       .then((data) => {
  //         console.log("서버가 전달한 map: ", data);

  //         let total = data.total; //총 댓글 수
  //         let replyList = data.list; //댓글 리스트

  //         //응답 데이터의 길이가 0과 같거나 더 작으면 함수를 종료
  //         if (replyList.length <= 0) return;

  //         if (reset) {
  //           //더보기 눌렀을 때 reset==false이므로 수행x
  //           while ($replyList.firstChild) {
  //             $replyList.firstChild.remove();
  //           }
  //           page = 1;
  //         }

  //         //더보기 버튼 배치 판단
  //         //현재 페이지번호 * 이번요청으로 받은 페이지당보여줄댓글수 > 전체 댓글수 -> 더보기 없어도 됌.
  //         console.log("현재 페이지: ", page);
  //         if (total <= page * 5) {
  //           document.getElementById("moreList").style.display = "none";
  //         } else {
  //           document.getElementById("moreList").style.display = "block";
  //         }

  //         //replyList의 개수만큼 태그를 문자열 형태로 직접 그림.
  //         //중간중간에 들어가야 할 글쓴이, 날짜, 댓글 내용은 목록에서 꺼내서 표현.
  //         for (let i = 0; i < replyList.length; i++) {
  //           strAdd +=
  //             `<div class='reply-wrap'>
  //                               <div class='reply-image'>
  //                                   <img src='${pageContext.request.contextPath}/img/profile.png'>
  //                               </div>
  //                               <div class='reply-content'>
  //                                   <div class='reply-group'>
  //                                       <strong class='left'>` +
  //             replyList[i].replyWriter +
  //             `</strong>
  //                                       <small class='left'>` +
  //             parseTime(replyList[i].date) +
  //             `</small>
  //                                       <a href='` +
  //             replyList[i].replyNo +
  //             `' class='right replyDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a>
  //                                       <a href='` +
  //             replyList[i].replyNo +
  //             `' class='right replyModify'><span class='glyphicon glyphicon-pencil'></span>수정</a>
  //                                   </div>
  //                                   <p class='clearfix'>` +
  //             replyList[i].replyText +
  //             `</p>
  //                               </div>
  //                           </div>`;
  //         }

  //         //id가 replyList라는 div 영역에 문자열 형식으로 모든 댓글을 추가.
  //         // document.getElementById('replyList').innerHTML = strAdd;
  //         //insertAdjacentHTML(): 인접한 곳에 HTML을 삽입하는 함수.
  //         //(position문자열, 문자열 형태의 HTML)
  //         if (!reset) {
  //           $replyList.insertAdjacentHTML("beforeend", strAdd); //위치, 값: 매개변수
  //         } else {
  //           $replyList.insertAdjacentHTML("afterbegin", strAdd);
  //         }
  //       }); // .then()의 끝
  //   } //end getList()

  //   //수정, 삭제
  //   /*
  //           document.querySelector('.replyModify').onclick = function (e) {
  //               e.preventDefault();
  //               console.log('수정 버튼 이벤트 발생!');
  //           } (이거 동작 안함!!!!!!!!!!!!)

  //           - .replyModify 요소는 실제 존재하는 요소가 아니라
  //           비동기 통신을 통해 생성되는 요소입니다.
  //           그러다 보니 이벤트가 등록되는 시점보다 fetch함수의 실행이 먼저 끝날 것이라는
  //           보장이 없기 때문에 해당 방식은 이벤트 등록이 불가능합니다.

  //           이 때는 이미 실제로 존재하는 #replyList에 이벤트를 등록하고, 이벤트를 자식에게 위임하여
  //           사용하는 addEventListener를 통해 처리해야 합니다.
  //           */
  //   document.getElementById("replyList").addEventListener("click", (e) => {
  //     //addEventListener()의 매개변수: type, func
  //     e.preventDefault(); //태그의 고유 기능을 중지.

  //     //1. 이벤트가 발생한 target이 a태그가 아니라면 이벤트 강제 종료!
  //     if (!e.target.matches("a")) return;

  //     console.log("a에만 이벤트 발생!");

  //     //2. a태그가 두 개(수정, 삭제)이므로 어떤 링크인지를 확인.
  //     //댓글이 여러 개 -> 수정, 삭제가 발생하는 댓글이 몇 번인지도 확인해야 한다.
  //     const rno = e.target.getAttribute("href"); //a태그의 속성 얻기
  //     console.log("댓글 번호: ", rno);
  //     //모달 내부에 숨겨진 input 태그에 댓글번호를 달아주자.
  //     document.getElementById("modalRno").value = rno;

  //     //댓글 내용도 가져와서 모달에 뿌려주자.
  //     const content = e.target.parentNode.nextElementSibling.textContent;
  //     console.log("댓글 내용: ", content);

  //     //3. 모달 창 하나를 이용해서 상황에 맞게 수정 / 삭제 모달을 제공해야 한다.
  //     //조건문을 작성 (수정 or 삭제에 따라 모달 디자인을 조정)
  //     if (e.target.classList.contains("replyModify")) {
  //       //수정 버튼을 눌렀으므로 수정 모달 형식으로 꾸며주겠다.
  //       document.querySelector(".modal-title").textContent = "댓글 수정"; // 제목 설정
  //       document.getElementById("modalReply").style.display = "inline"; // 댓글 내용 보이기
  //       document.getElementById("modalReply").value = content; // 댓글 내용
  //       document.getElementById("modalModBtn").style.display = "inline";
  //       document.getElementById("modalDelBtn").style.display = "none";

  //       //어쩔 수 없이 제이쿼리를 이용하여 bootstrap 모달을 여는 방법
  //       $("#replyModal").modal("show");
  //     } else {
  //       document.querySelector(".modal-title").textContent = "댓글 삭제"; // 제목 설정
  //       document.getElementById("modalReply").style.display = "none"; // 댓글 내용 숨기기
  //       document.getElementById("modalModBtn").style.display = "none";
  //       document.getElementById("modalDelBtn").style.display = "inline";

  //       $("#replyModal").modal("show");
  //     }
  //   }); // 수정 or 삭제 버튼 클릭 이벤트 끝.

  //   //수정 처리 함수. (수정 모달을 열어서 수정 내용을 작성한 후 수정 버튼을 클릭했을 때)
  //   document.getElementById("modalModBtn").onclick = () => {
  //     const reply = document.getElementById("modalReply").value;
  //     const rno = document.getElementById("modalRno").value;
  //     const replyPw = document.getElementById("modalPw").value;

  //     if (reply === "" || replyPw === "") {
  //       alert("내용, 비밀번호를 확인하세요!");
  //       return;
  //     }

  //     //요청에 관련된 정보 객체
  //     const reqObj = {
  //       method: "put",
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: JSON.stringify({
  //         replyText: reply,
  //         replyPw: replyPw,
  //       }),
  //     };

  //     fetch("${pageContext.request.contextPath}/reply/" + rno, reqObj)
  //       .then((res) => res.text())
  //       .then((data) => {
  //         if (data === "pwFail") {
  //           alert("비밀번호를 확인하세요!");
  //           document.getElementById("modalPw").value = "";
  //           document.getElementById("modalPw").focus();
  //         } else {
  //           alert("정상 수정되었습니다.");
  //           //모달에 작성된 내용들을 지워주자.
  //           document.getElementById("modalReply").value = "";
  //           document.getElementById("modalPw").value = "";
  //           //제이쿼리 문법으로 bootstrap 모달 닫아주기
  //           $("#replyModal").modal("hide");
  //           getList(1, true); //수정 내용 반영
  //         }
  //       });
  //   }; // end update event

  //   //삭제 이벤트
  //   document.getElementById("modalDelBtn").onclick = () => {
  //     /*
  //               1. 모달창에 rno값, replyPw 값을 얻습니다.

  //               2. fetch 함수를 이용해서 DELETE 방식으로 reply/{rno} 요청

  //               3. 서버에서는 요청을 받아서 비밀번호를 확인하고, 비밀번호가 맞으면
  //               삭제를 진행하시면 됩니다.

  //               4. 만약 비밀번호가 틀렸다면, 문자열을 반환해서
  //               '비밀번호가 틀렸습니다.' 경고창을 띄우세요.

  //               삭제 완료되면 모달 닫고 목록 요청 다시 보내세요. (reset의 여부를 잘 판단)
  //               */
  //     const rno = document.getElementById("modalRno").value;
  //     const replyPw = document.getElementById("modalPw").value;

  //     if (replyPw === "") {
  //       alert("비밀번호를 확인하세요!");
  //       return;
  //     }

  //     const reqObj = {
  //       method: "delete",
  //       headers: {
  //         "Content-Type": "text/plain",
  //       },
  //       body: replyPw,
  //     };

  //     fetch("${pageContext.request.contextPath}/reply/" + rno, reqObj)
  //       .then((res) => res.text())
  //       .then((data) => {
  //         console.log(data);

  //         if (data === "pwFail") {
  //           alert("비밀번호가 틀렸습니다.");
  //           document.getElementById("modalPw").value = "";
  //           document.getElementById("modalPw").focus();
  //         } else {
  //           alert("댓글이 삭제되었습니다.");
  //           document.getElementById("modalPw").value = "";
  //           //제이쿼리 문법으로 bootstrap 모달 닫아주기
  //           $("#replyModal").modal("hide");
  //           getList(1, true); //삭제 내용 반영
  //         }
  //       });
  //   }; // end delete event

  //   //댓글 날짜 변환 함수
  //   function parseTime(regDate) {
  //     //원하는 날짜로 객체를 생성.
  //     const now = new Date();
  //     let regTime = new Date(regDate);

  //     //getTime(): 1970년 1월 1일 자정을 기준으로 현재까지의 시간을 밀리초로 리턴.
  //     const gap = now.getTime() - regTime.getTime();

  //     let time;
  //     if (gap < 60 * 60 * 24 * 1000) {
  //       //밀리초니까 1000 곱해준다. 시간차가 하루보다 작으면
  //       if (gap < 60 * 60 * 1000) {
  //         //시간차가 1시간보다 작으면
  //         time = "방금 전";
  //       } else {
  //         time = parseInt(gap / (1000 * 60 * 60)) + "시간 전";
  //       }
  //     } else if (gap < 60 * 60 * 24 * 30 * 1000) {
  //       //한달보다 작으면
  //       time = parseInt(gap / (1000 * 60 * 60 * 24)) + "일 전";
  //     } else {
  //       time = `\${regTime.getFullYear()}년 \${regTime.getMonth()+1}월 \${regTime.getDate()}일`;
  //     }

  //     if (regDate.includes("(수정됨)")) return time + "(수정됨)";
  //     return time;
  //   }
  // }; //window.onload
</script>

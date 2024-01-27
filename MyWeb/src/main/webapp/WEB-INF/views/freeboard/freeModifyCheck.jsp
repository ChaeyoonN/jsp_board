<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="../include/header.jsp" %>

<section>
  <div class="container">
    <div class="row">
      <div class="col-lg-6 col-md-7 col-xs-10 login-form">
        <div class="titlebox">게시글 수정</div>
        <form method="post" name="loginForm">
          <div class="form-group">
            <!--사용자클래스선언-->
            <label for="id">아이디</label>
            <input
              type="text"
              name="userId"
              class="form-control"
              id="id"
              placeholder="아이디"
              autofocus
            />
          </div>
          <div class="form-group">
            <!--사용자클래스선언-->
            <label for="id">비밀번호</label>
            <input
              type="password"
              name="userPw"
              class="form-control"
              id="pw"
              placeholder="비밀번호"
              autoComplete="off"
            />
          </div>
          <div class="form-group">
            <button type="button" id="loginBtn" class="btn btn-info btn-block">
              수정하기
            </button>
            <button
              type="button"
              id="joinBtn"
              class="btn btn-primary btn-block"
            >
              뒤로가기
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

<%@ include file="../include/footer.jsp" %>

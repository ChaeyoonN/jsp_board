<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="../include/header.jsp" %>

    <section>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-7 col-xs-10 login-form">
                    <div class="titlebox">
                        로그인
                    </div>
                    <form method="post" name="loginForm">
                        <div class="form-group"><!--사용자클래스선언-->
                            <label for="id">아이디</label>
                            <input type="text" name="userId" class="form-control" id="id" placeholder="아이디" autofocus>
                         </div>
                         <div class="form-group"><!--사용자클래스선언-->
                            <label for="id">비밀번호</label>
                            <input type="password" name="userPw" class="form-control" id="pw" placeholder="비밀번호" autoComplete="off">
                         </div>
                         <div class="form-group">
                            <button type="button" id="loginBtn" class="btn btn-info btn-block">로그인</button>
                            <button type="button" id="joinBtn" class="btn btn-primary btn-block">회원가입</button>
                         </div>
                    </form>                
                </div>
            </div>
        </div>
    </section>
    
    <%@ include file="../include/footer.jsp" %>

    <script>

        //회원가입 완료 후 addFlashAttribute로 msg라는 이름의 데이터가 전달됐는지 확인
        const msg = '${msg}';
        if(msg === 'joinSuccess'){
            alert('회원가입을 환영합니다!');
        }else if(msg === 'loginFail'){
        	alert('로그인에 실패했습니다. 아이디와 비밀번호를 확인하세요.');
        }

        //id, pw 입력란이 공백인지 아닌지 확인한 후, 공백이 아니라면 submit을 진행하세요.
        //요청 url은 /user/userLogin -> post로 갑니다. (비동기 아니에요!) (action 안쓰면 자기자신 호출)
        document.getElementById('loginBtn').onclick = () => {
            
            if(document.loginForm.userId.value.trim().length <= 0){
                alert('공백이 아닌 아이디를 입력해 주세요.');
                document.loginForm.userId.value = document.loginForm.userId.value.replaceAll(' ', '');
                document.loginForm.userId.focus();  
                return;
            }
            if(document.loginForm.userPw.value.trim().length <= 0){
                alert('공백이 아닌 비밀번호를 입력해 주세요.');
                document.loginForm.userPw.value = document.loginForm.userPw.value.replaceAll(' ', '');
                document.loginForm.userPw.focus(); 
                return;
            }
            document.loginForm.submit();
                
            
        }

        // 엔터 키 눌렀을 때도 로그인 폼 보내기
        document.addEventListener("DOMContentLoaded", function() {
            // 아이디 입력창에 autofocus 설정함
            var usernameInput = document.loginForm.userId;
            var passwordInput = document.loginForm.userPw;

            usernameInput.addEventListener("keyup", function(event) {
                if (event.key === "Enter") {
                    if (usernameInput.value === ''){
                        alert('아이디를 입력해 주세요.');
                        return;
                    }
                    document.loginForm.submit();
                }
            });

            passwordInput.addEventListener("keyup", function(event) {
                if (event.key === "Enter") {
                    if (passwordInput.value === ''){
                        alert('비밀번호를 입력해 주세요.');
                        return;
                    }
                    document.loginForm.submit();
                }
            });
    });

        document.getElementById('joinBtn').onclick = function () {
            location.href = '${pageContext.request.contextPath}/user/userJoin';
        }

    </script>
    
    
    
    

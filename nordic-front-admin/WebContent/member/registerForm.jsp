<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>회원가입</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>

</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="check.js"></script>
<script src="idCheck.js"></script>
<script>

    function doRegister() {

        var member_code = document.getElementById("member_code").value;
        var member_name = document.getElementById("member_name").value;
        var mobile_no = document.getElementById("mobile_no").value;
        var address = document.getElementById("address").value;
        var age = document.getElementById("age").value;
        var sex = document.getElementById("sex").value;
        var password = document.getElementById("password").value;

        var url = "http://localhost/api/member/register";
        var data = $("#frmData").serialize();

        // <button>내 정보 보기</button>
        var register2 = 
        `
            <h1>회원가입이 완료 되었습니다!</h1><br>
            <a href = "findOne.html"> 내 정보 보기 </a>    
        `;

        $.ajax ({
            type : "post",
            url : url,
            data : data,
            success : function(result) {
                console.log(result);
                alert("회원가입 완료!");
                $("#registerTitle").empty();
                $("#register").empty();
                document.getElementById("registerResult").innerHTML = register2;
                // location.href="findOne.html";
            },
            error : function(request, status, error) {
                // alert(request.responseJSON.error);
                console.log(request);
                console.log(request.responseJSON.error);
            }
        }); // ajax end

    }

</script>
<style>
    table {
        margin:auto;
    }
    div {
        /* border :1px dotted red; */
        margin:auto;
    }

    #register {
        width:auto;
        float:none;
        margin-left: 20px;
    }

    #registerTitle {
        font-size:xx-large;
        text-align: right;
        margin-top: 100px;
        margin-bottom: 80px;
    }

    th {
        text-align: right;
        font-size: large;
        width: 150px;
    }

    td {
        text-align: center;
        width: 500px;
    }

    input {
        width: 300px;
    }

    #indexArea {
        text-align: right;
        font-size: x-large;
        font-weight:600;
    }

</style>
<body>

    <div class="container text-center">
        <div class="row">
          <div class="col" id="registerTitle">
            회원가입
          </div>
          <div class="col">
          </div>
          <div class="col">
          </div>
        </div>
      </div>

    <div id="register">
        <form method="post" id="frmData" onSubmit="return check()">
        
        <!-- 아이디 영역 -->
        <div id="idgroup" class="row">

            <!-- 중복검사 메시지 영역 -->
            <div class="col"></div>
            <div class="col" id="duplicateId"></div>
            <div class="col"></div>
            <div class="w-100"></div>
            
            <div class="col" id="indexArea">
                아이디
            </div>
            <div class="col">
                <input class="form-control" type="text" id="member_code" name="member_code" placeholder="member_code" maxlength="16"></td><td style="width:100px">
            </div>
            <div class="col">
                <button type="button" class="btn btn-dark" id="btnIdchk" onClick="idCheck()" style="text-align: left;">중복</button>
            </div>
        </div>
<br>
        <!-- 비밀번호 영역 -->
        <div id="pwgroup" class="row">
            
            <div class="col" id="indexArea">
                비밀번호
            </div>
            <div class="col">
                <input type="password" class="form-control" id="password" name="password" placeholder="password" maxlength="16">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 비밀번호 확인 영역 -->
        <div id="pwgroup" class="row">
            
            <div class="col" id="indexArea">
                비밀번호 확인
            </div>
            <div class="col">
                <input type="password" class="form-control" id="password2" name="password2" placeholder="password check" maxlength="16">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 이름 영역 -->
        <div id="namegroup" class="row">
            
            <div class="col" id="indexArea">
                이름
            </div>
            <div class="col">
                <input type="text" class="form-control" id="member_name" name="member_name" placeholder="member_name">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 휴대폰 영역 -->
        <div id="mobilegroup" class="row">
            
            <div class="col" id="indexArea">
                휴대폰
            </div>
            <div class="col">
                <input type="text" class="form-control" id="mobile_no" name="mobile_no" placeholder="mobile_no">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 주소 영역 -->
        <div id="mobilegroup" class="row">
            
            <div class="col" id="indexArea">
                주소
            </div>
            <div class="col">
                <input type="text" class="form-control" id="address" name="address" placeholder="address">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 성별 영역 -->
        <div id="sexgroup" class="row">
            
            <div class="col" id="indexArea">
                성별
            </div>
            <div class="col">
                <input type="text" class="form-control" id="sex" name="sex" placeholder="sex">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 나이 영역 -->
        <div id="mobilegroup" class="row">
            
            <div class="col" id="indexArea">
                나이
            </div>
            <div class="col">
                <input type="number" class="form-control" id="age" name="age" placeholder="age">
            </div>
            <div class="col"></div>
        </div>

        <table class="table table-borderless w-auto">
            <tr><td><br><br>
                <button id="rgstBtn" class="btn btn-dark" onClick="doRegister()" >회원가입</button>
            </td></tr>
        </table>
        </form>
    </div>
    <div id="registerResult"></div>
</body>
</html>
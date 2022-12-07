<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>회원가입</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='main.css'>

</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="js.js"></script>
<script src="idCheck.js"></script>
<style>

    div {
        border :1px solid red;
    }

    #duplicateId {
        color: red;
        font-size: small;
    }

    #availableId {
        color: blue;
        font-size: small;
    }

</style>
<body>
    <div id="registerTitle"> 회원가입 </div>

    <div id="register">
        <form action="http://localhost:80/api/member/register" method="post" onSubmit="return check()">
            <input type="text" id="member_code" name="member_code" placeholder="member_code">
            <input type="button" onClick="idCheck()" value="중복검사"><br>
            <div id="duplicateId"></div>
            <div id="availableId"></div>
            <input type="text" id="member_name" name="member_name" placeholder="member_name"><br>
            <input type="text" id="mobile_no" name="mobile_no" placeholder="mobile_no"><br>
            <input type="text" id="address" name="address" placeholder="address"><br>
            <input type="text" id="age" name="age" placeholder="age"><br>
            <input type="text" id="sex" name="sex" placeholder="sex"><br>
            <input type="text" id="password" name="password" placeholder="password"><br>
            <input type="test" id="password2" name="password2" placeholder="비밀번호 확인"><br>
            <button onClick="register()">가입</button>
        </form>
    </div>
</body>
</html>
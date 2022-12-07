<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>회원 1명의 정보</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='main.css'>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

    /********************* 회원정보조회 *********************/
    function findOne() {

        $("#member").empty();
        $("#modifyFormArea").empty();
        var member_code = document.getElementById("memberCode").value;

        fetch("http://localhost/api/member/"+member_code, {
            method: "GET",
            mode: 'cors',
            headers: {
                'Content-Type' : 'application/json',
            }
        })

        .then(response => response.json())
        .then((response) => {
                
            let memKeys = Object.keys(response.data);
            let memValues = Object.values(response.data);
            console.log(memKeys);
            console.log(memValues);
            $("#member").append(`<tr>`);

            for (var i=0; i<memValues.length; i++) {
                var data = `<td>${memValues[i]}</td>`;
                $("#member").append(data)
            }

            var data = `
                <td><button onClick="doModifyForm(${member_code})">수정</button></td>
                <td><button onClick="doDelete(${member_code})">삭제</button></td>
            `;
            $("#member").append(data);
            $("#member").append(`</tr>`)

        })
            
        .catch(error => {
            console.log(error);
            alert("회원 정보를 찾을 수 없습니다");
            document.getElementById("memberCode").value = "";
        });

    }// findOne end
    
    /********************* 회원정보수정 폼 *********************/
    function doModifyForm(member_code) {

        var member_code = document.getElementById("memberCode").value;
        var url = "http://localhost/api/member/modifyForm/";

        fetch( url+member_code , {
            method: "GET",
            mode:'cors',
            headers: {
                'Content-Type' : 'application/json',
            }
        })

        .then(response => response.json())
        .then(response => {

            var memKeys = Object.keys(response.data);
            var memValues = Object.values(response.data);
            console.log(memValues[0]);

            var data =
            `
                <form method="put" id="frmData">
                회원코드 : <input type="text" id="member_code" name="member_code" value="${memValues[0]}" readOnly><br>
                이름 : <input type="text" id="member_name" name="member_name" value="${memValues[1]}"><br>
                핸드폰 : <input type="text" id="mobile_no" name="mobile_no" value="${memValues[2]}"><br>
                주소 : <input type="text" id="address" name="address" value="${memValues[3]}"><br>
                나이 : <input type="text" id="age" name="age" value="${memValues[4]}"><br>
                성별 : <input type="text" id="sex" name="sex" value="${memValues[5]}"><br>
                비밀번호 : <input type="text" id="password" name="password" value="${memValues[7]}"><br><br>
                <button type="button" onClick="doModify()"> 수정 </button>
                </form>
            `
            document.getElementById("modifyFormArea").innerHTML = data;
            
        })
        .catch (error => {
            console.log(error);
            alert(error);
            alert("에러입니다");
        })

    } // doModifyForm end
    
    /********************* 회원정보삭제 *********************/
    function doDelete(member_code) {

        var url = "http://localhost/api/member/del/";

        if (confirm(member_code+" 회원을 정말 강제탈퇴 처리 하시겠습니까?")) {

            if (confirm(member_code+" 회원을 강제탈퇴 처리합니다.")) {
                $(function (){
                    $.ajax ({
                        type : "post",
                        url : url + member_code,
                        data : member_code,
                        success : function(result) {
                            alert(result);
                            alert(member_code+"회원을 강제탈퇴 처리하였습니다.")
                        }
                    }); // 
                }); // jQuery end
            }

        } // if end
    } // doDelete end

   /********************* 회원정보수정 실행 *********************/
    function doModify() {
        
        var member_code = document.getElementById("member_code").value;
        var member_name = document.getElementById("member_name").value;
        var mobile_no = document.getElementById("mobile_no").value;
        var address = document.getElementById("address").value;
        var age = document.getElementById("age").value;
        var sex = document.getElementById("sex").value;
        var password = document.getElementById("memberCode").value;
        var url1 = "http://localhost/api/member/modify/";
        var data1 = $("#frmData").serialize();

        $(function() {
        
            $.ajax({
                type : "post",
                url : url1 + member_code,
                data : data1,
                success : function(result) {
                    alert(result);
                    alert("회원정보수정 완료!");
                }
            }); // ajax end
            
        }); // jQuery function end

    } // doModify end

</script>
<style>
    div{
        text-align: center;
    }
</style>
<body>
    멤버코드 : <input type="text" id="memberCode" name="memberCode" value="10001">
    <button onClick="findOne()">찾기</button>
    <br><br>
    <table border="1">
        <thead>

            <tr>
                <th>회원코드</th>
                <th>이름</th>
                <th>핸드폰</th>
                <th>주소</th>
                <th>나이</th>
                <th>성별</th>
                <th>동의여부</th>
                <th>비밀번호</th>
                <th>가입승인여부</th>
                <th>가입승인일시</th>
                <th>활동중지여부</th>
                <th>활동중지일시</th>
                <th>관리자여부</th>
                <th>관리자등록일</th>
                <th>누적포인트</th>
                <th>가용포인트</th>
                <th>사용포인트</th>
                <th>비고</th>
                <th>등록자</th>
                <th>등록일시</th>
                <th>변경자</th>
                <th>변경일시</th>
                <th></th>
            </tr>
        </thead>
        <tbody id="member" name="member"></tbody>
    </table>

    <br><br>
    <div id="modifyFormArea"></div>

    <div id="deleteArea"></div>
</body>
</html>
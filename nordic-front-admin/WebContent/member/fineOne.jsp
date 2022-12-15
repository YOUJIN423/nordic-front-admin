<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>회원 1명의 정보</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
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
            $("#member").append(`<tr>`);

            for (var i=0; i<memValues.length; i++) {
                if( i == 7 ) {
                        i=8;
                }   // 비밀번호는 출력하지 않는다.
                
                var asd = memValues[i]
                // if (i == 1) {
                //     var asd = `<button onClick = " location.href='memberInfo.html' ">\${memValues[i]}</button>`;
                // }   // 회원 이름을 클릭하면 활동 내역을 볼 수 있는 페이지로 연결
                
                if (asd == null || asd == 0 ) {
                    var asd = "-";
                }  // null, 0 인 값을 '-' 로 출력
                
                var data = `<td>\${asd}</td>`;
                $("#member").append(data)
            }

            var data = `
                <td><button class="btn btn-outline-dark btn-sm" onClick="doModifyForm(\${member_code})">수정</button></td>
                <td><button class="btn btn-outline-danger btn-sm" onClick="doDelete(\${member_code})">탈퇴</button></td>
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
            
            var data2 =
            ` 
            <div id="modifyFormWrapper">
            <form method="put" id="frmData">
                <br>
                <div id="idgroup" class="row">
                    <div class="col" id="indexArea">
                        아이디
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="member_code" name="member_code" value="\${memValues[0]}" readOnly>
                    </div>
                </div><br>
                <div id="pwgroup" class="row">
                    <div class="col" id="indexArea">
                        비밀번호
                    </div>
                    <div class="col">
                        <input type="password" class="form-control form-control-sm" id="password" name="password">
                    </div>
                </div><br>
                <div id="namegroup" class="row">
                    <div class="col" id="indexArea">
                        이름
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="member_name" name="member_name" value="\${memValues[1]}">
                    </div>
                </div><br>
                <div id="mobilegroup" class="row">
                    <div class="col" id="indexArea">
                        휴대폰
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="mobile_no" name="mobile_no" value="\${memValues[2]}">
                    </div>
                </div><br>
                <div id="mobilegroup" class="row">
                    <div class="col" id="indexArea">
                        주소
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="address" name="address" value="\${memValues[3]}">
                    </div>
                </div><br>
                <div id="sexgroup" class="row">
                    <div class="col" id="indexArea">
                        성별
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="sex" name="sex" value="\${memValues[5]}">
                    </div>
                </div><br>
                <div id="agegroup" class="row">
                    <div class="col" id="indexArea">
                        나이
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="age" name="age" value="\${memValues[4]}">
                    </div>
                </div>
                <table class="table table-borderless w-auto"><tr><td><br><br>
                    <button type="button" class="btn btn-dark btn-sm" onClick="doModify()"> 수정 </button></td>
                </td></table>
            </table>
            </form>
            </div>
            `
            document.getElementById("modifyFormArea").innerHTML = data2;

        })
        .catch (error => {
            console.log(error);
            alert("에러입니다");
        })

    } // doModifyForm end
    
    /********************* 회원정보삭제 *********************/
    function doDelete(member_code) {

        var url = "http://localhost/api/member/del/";

        if (confirm("정말 탈퇴 하시겠습니까?")) {

            if (confirm("탈퇴 후 동일 아이디로 재가입 할 수 없습니다.")) {
                $(function (){
                    $.ajax ({
                        type : "post",
                        url : url + member_code,
                        data : member_code,
                        success : function(result) {
                            alert("탈퇴가 완료되었습니다.")
                        }
                    }); // 
                }); // ajax end
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
        var password = document.getElementById("password").value;

        console.log(password);
        
        var url1 = "http://localhost/api/member/modify/";
        var data1 = $("#frmData").serialize();

        $(function() {
        
            $.ajax({
                type : "post",
                url : url1 + member_code,
                data : data1,
                success : function(result) {
                    alert("회원정보수정 완료!");
                    // location.reload();
                    findOne();
                }
            }); // ajax end
            
        }); // jQuery function end

    } // doModify end

</script>
<style>

    #memberArea { text-align: center; }

    #wrapper { justify-content: center; margin-top: 100px;}

    #delFormat {
        text-decoration: line-through;
        color: darkgray;
    }

    #adminFormat {
        font-weight: bold;
        color: red;
    }

    #modifyFormArea {
        text-align: center;
        display:flex;
        justify-content: center;
    }

    #member_code {
        background-color: rgb(248, 248, 248);
        border-color: rgb(208, 208, 208);
        color:darkgray;
    }

    #indexArea {
        text-align: right;
        font-size: large;
        font-weight:600;
    }

    span { 
        /* border: 1px red; border-style: solid; */
        margin:auto;
    }

    div{
        /* border :1px dotted red; */
        /* text-decoration: line-through; */
        width: 90%;
        margin:auto;
    }

    input {
        width: 200px;
    }

    table {
        margin: auto;
        /* width: 90%; */
    }

    #member_code {width:300px;}
    #password {width:300px;}
    #member_name {width:300px;}
    #address {width:300px;}
    #mobile_no {width:300px;}
    #sex {width:300px;}
    #age {width:300px;}

</style>
<body>
<div id="wrapper">
    <div>
    <span>
        아이디 : <input type="text" class="form-control-sm" id="memberCode" name="memberCode">
        <button class="btn btn-dark btn-sm" onClick="findOne()">찾기</button>
    </span>
    </div>
    <br><br>
    <div id="memberArea">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>회원코드</th>
                    <th>이름</th>
                    <th>핸드폰</th>
                    <th>주소</th>
                    <th>나이</th>
                    <th>성별</th>
                    <th>동의여부</th>
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
                    <th></th>
                </tr>
            </thead>
            <tbody id="member"></tbody>
        </table>
    </div>

    <br><br>
    <div id="modifyFormArea"></div>
    <div id="actArea"></div>

    <div id="deleteArea"></div>
</div>
</body>
</html></html>
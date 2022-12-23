<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>전체 회원 정보</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

    /********************* 회원정보수정 폼 *********************/
    function doModifyForm(member_code, pageNum){

        var url = "http://localhost/api/member/modifyForm/";
        
        let token = localStorage.getItem('wtw-token') || '';

        fetch ( url+member_code, {
            method: "GET",
            mode: 'cors',
            headers : {
                'Content_Type' : 'application/json',
                'Authorization' : `Bearer \${token}`,
            }
        })

        .then(response => response.json())
        .then(response => {

            var memKeys = Object.keys(response.data);
            var memValues = Object.values(response.data);
            
            if(memValues[11] == null ) { memValues[11] = '-' }

            if (memValues[12] == 'Y'  && memValues[8] == 'Y' && memValues[10] == 'N') {
                memValues[12] = "관리자";
            } else if (memValues[12] == 'N' && memValues[8] == 'Y' && memValues[10] == 'N') {
                memValues[12] = "일반 회원";
            } else if (memValues[12] == 'N' && memValues[8] == 'N' && memValues[10] == 'N') {
                memValues[12] = "승인 대기";
            } else if (memValues[10] == 'Y') {
                memValues[12] = "탈퇴";
            } // 회원 등급 : 일반 회원, 관리자, 승인 대기

            var data =
            `   <div id="modifyFormWrapper">
                <form method="put" id="frmData">
                <input type="hidden" id="currentPageNum" name="currentPageNum" value="\${pageNum}">
                <br>

                <div id="idgroup" class="row">
                    <div class="col" id="indexArea">
                        아이디
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control form-control-sm"  id="member_code" name="member_code" value="\${memValues[0]}" readOnly>
                    </div>
                </div><br>
                
                <div id="pwgroup" class="row">
                    <div class="col" id="indexArea">
                        비밀번호
                    </div>
                    <div class="col" id="inputArea">
                        <input type="password" class="form-control form-control-sm" id="password" name="password">
                    </div>
                </div><br>
                
                <div id="namegroup" class="row">
                    <div class="col" id="indexArea">
                        이름
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control form-control-sm" id="member_name" name="member_name" value="\${memValues[1]}">
                    </div>
                </div><br>
                
                <div id="mobilegroup" class="row">
                    <div class="col" id="indexArea">
                        휴대폰
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control form-control-sm" id="mobile_no" name="mobile_no" value="\${memValues[2]}">
                    </div>
                </div><br>
                
                <div id="mobilegroup" class="row">
                    <div class="col" id="indexArea">
                        주소
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control form-control-sm" id="address" name="address" value="\${memValues[3]}">
                    </div>
                </div><br>
                
                <div id="sexgroup" class="row">
                    <div class="col" id="indexArea">
                        성별
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control form-control-sm" id="sex" name="sex" value="\${memValues[5]}">
                    </div>
                </div><br>
                
                <div id="agegroup" class="row">
                    <div class="col" id="indexArea">
                        나이
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control form-control-sm" id="age" name="age" value="\${memValues[4]}">
                    </div>
                </div><br>
                
                <div id="create_dategroup" class="row">
                    <div class="col" id="indexArea">
                        가입일자
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control-plaintext" id="create_date" name="create_date" value="\${memValues[19]}" disabled>
                    </div>
                </div><br>
                
                <div id="stop_dategroup" class="row">
                    <div class="col" id="indexArea">
                        탈퇴일자
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control-plaintext" id="stop_date" name="stop_date" value="\${memValues[11]}" disabled>
                    </div>
                </div><br>
                
                <div id="admin_yngroup" class="row">
                    <div class="col" id="indexArea">
                        등급
                    </div>
                    <div class="col" id="inputArea">
                        <input type="text" class="form-control-plaintext" id="admin_yn" name="admin_yn" value="\${memValues[12]}" disabled>
                    </div>
                </div><br>
                
                <table class="table table-borderless w-auto"><tr><td><br><br>
                <button type="button" class="btn btn-dark btn-sm" onClick="doModify()"> 수정 </button>
                <button type="button" class="btn btn-dark btn-sm" onClick="findAll(\${pageNum})">목록</button>
                </td></table>
                </form>
                </div>
                <Br>
            `

            document.getElementById("modifyFormArea").innerHTML = data;
            $("#allMemList").hide();
            $("#pageArea").empty();

        })

        .catch (error => {
            console.log(error);
            alert(error);
            alert("에러입니다");
        })
    }  // doModifyForm end

    /********************* 회원정보수정 실행 *********************/
    function doModify() {
        
        var pageNum = document.getElementById("currentPageNum").value;
        var member_code = document.getElementById("member_code").value;
        var member_name = document.getElementById("member_name").value;
        var mobile_no = document.getElementById("mobile_no").value;
        var address = document.getElementById("address").value;
        var age = document.getElementById("age").value;
        var sex = document.getElementById("sex").value;
        var password = document.getElementById("password").value;
        
        var url1 = "http://localhost/api/member/modify/";
        var data1 = $("#frmData").serialize();
        
        let token = localStorage.getItem('wtw-token') || '';

        $(function() {
        
            $.ajax({
                type : "post",
                url : url1 + member_code,
                data : data1,
                headers:{
                	'Authorization' : `Bearer \${token}`,
                },
                success : function(result) {
                    alert("회원정보수정 완료!");
                    findAll(pageNum);
                }
            }); // ajax end
            
        }); // jQuery function end

    } // doModify end

    /********************* 탈퇴 실행  *********************/
    function doDelete(member_code, pageNum) {

        var url = "http://localhost/api/member/del/"+member_code;
        
        let token = localStorage.getItem('wtw-token') || '';

        if (confirm(member_code+" 회원을 정말 강제탈퇴 처리 하시겠습니까?")) {

            if (confirm(member_code+" 회원을 강제탈퇴 처리합니다.")) {
                $(function (){
                    $.ajax ({
                        type : "post",
                        url : url,
                        data : member_code,
                        headers:{
                        	'Authorization' : `Bearer \${token}`,
                        },
                        success : function(result) {
                            alert(member_code+"회원을 강제탈퇴 처리하였습니다.");
                            findAll(pageNum);
                        }
                    }); // 
                }); // ajax end
            }

        } // if end
    }

    /********************* 탈퇴 철회  *********************/
    function undoDelete(member_code, pageNum) {
        var url = "http://localhost/api/member/members/undoDelete/"+member_code;
        
        let token = localStorage.getItem('wtw-token') || '';

        $(function(){

            $.ajax({
                type: "POST",
                url: url,
                data: member_code,
                headers:{
                	'Authorization' : `Bearer \${token}`,
                },
                success: function (result) {

                    alert("탈퇴 철회 완료");
                    memberState(1);

                }
            }); // ajax end

        }); // function end

    }

    /********************* 모든회원정보 불러오기 *********************/
    function findAll(pageNum) {
    
    if ($("#aC").is(":checked")) {  // 관리자 체크박스가 checked 상태일 때

        var url = "http://localhost:80/api/member/admins/"+pageNum;
        if (pageNum == 1 ) {
        }

    } else {

        if 
            (true) {
            var url = "http://localhost:80/api/member/members/"+pageNum;
        } else {
            $("#members").empty();
            $("#pageArea").empty();
            return false;
        }

    }   // if end

        fetch(url, {
            method: "GET",
            mode: 'cors',
            headers: {
            'Content-Type' : 'application/json',
            }
        })
        
        .then(response => response.json())
        .then(response => {

            $("#members").empty();
            $("#memberIndex").empty();
            $("#allMemList").show();
            $("#modifyFormArea").empty();
            $("#pageArea").empty();

            var tableColumnL = (response.data.list.length); // 행 길이

            var tableIndex = `
                    <th>아이디</th>
                    <th>이름</th>
                    <th>핸드폰</th>
                    <th style="width:200px;">주소</th>
                    <th>나이</th>
                    <th>성별</th>
                    <th>회원등급</th>
                    <th>전체포인트</th>
                    <th>가용포인트</th>
                    <th>사용포인트</th>
                    <th>비고</th>
                    <th></th><th></th>
            `;

            $("#memberIndex").append(tableIndex);

            for (var j=0; j<tableColumnL; j++){

                var memKeys = Object.keys(response.data.list[j]);
                var memValues = Object.values(response.data.list[j]);
                
                $("#members").append(`<tr>`);
                
                var i=0;
                while (i < memValues.length) {

                    if (i == 6) i++; // 동의여부 출력 x
                    if( i == 7 ) i=9; // 비밀번호 출력 x
                    if (i == 9) i=12; // 승인일시 출력 x
                    if (i == 13) i++;
                    if (i == 18) break; // 등록자 출력 x

                    var asd = memValues[i];
                    if (memValues[i] == null || memValues[i] == 0 ) {
                        var asd = "-";
                    }   // null, 0 인 값을 '-' 로 출력
                    
                    if (i == 12) {
                    	if (memValues[12] == 'Y'  && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "관리자";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "일반 회원";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'N' && memValues[10] == 'N') {
                    		var asd = "승인 대기";
                    	} else if (memValues[10] == 'Y') {
                    		var asd = "탈퇴";
                    	}
                    } // 회원 등급 : 일반 회원, 관리자, 승인 대기, 탈퇴
                    
                    /* if (i == 1) {
                        // var asd = `<a href = "memberInfo.html">${memValues[i]}</a>`;
                        var asd = `<button class="btn btn-outline-dark btn-sm" style="border:0;"  onClick = " location.href='memberInfo.html' ">${memValues[i]}</button>`;
                    }   // 회원 이름을 클릭하면 활동 내역을 볼 수 있는 페이지로 연결 */

                 	// 탈퇴한 회원일 경우 취소선 적용
                    if (response.data.list[j].stop_yn == 'Y' &&
                        response.data.list[j].admin_yn == 'N' &&
                        response.data.list[j].approval_yn == 'N') {
                        var tdValue = `<td id="delFormat">`;
                    
                    // 일반 회원일 경우 아무런 서식 적용 없음
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' ) {
                        var tdValue = `<td>`;
                    } else if (response.data.list[j].stop_yn == 'N' &&
                             response.data.list[j].admin_yn == 'N' &&
                             response.data.list[j].admin_yn == 'Y' ) {
                      var tdValue = `<td>`;
                    
                    // 관리자 회원일 경우 굵게 빨간 글씨
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'Y' &&
                               response.data.list[j].approval_yn == 'Y')  {
                        var tdValue = `<td id="adminFormat">`;
                    }

                    var data = `\${tdValue}\${asd}</td>`;
                    i++;
                    
                    $("#members").append(data);

                }   // while end (td 추가 끝)
                
                var member_code = memValues[0];

                if ( $("#aC").is(":checked") == false) {  // 일반 회원 출력 버튼 : 수정, 탈퇴

                    var data = `<td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doModifyForm(\${member_code}, \${response.data.pageNum})">수정</button></td>
                    <td><button class="btn btn-outline-danger btn-sm" style="border:0;" onClick="doDelete(\${member_code}, \${response.data.pageNum})">탈퇴</button></td></tr>`
                    $("#members").append(data);

                } else if ( $("#aC").is(":checked")) { // 관리자 회원 노출 버튼 : 수정, 관리자 해제
                    
                    var data = `
                    <td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doModifyForm(\${member_code}, ${response.data.pageNum})">수정</button></td>
                    <td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doUnadmin(\${member_code}, ${response.data.pageNum})">관리자 해제</button></td></tr>`
                    $("#members").append(data);

                }
            }   //for end

            var pageNum = response.data.pageNum     // 1, 현재 페이지
            var pageCount = response.data.pages     // 144, 가장 마지막 페이지
            var memberCount = response.data.total;  // 전체 회원 수

            var prePage = (Math.floor((pageNum - 1)/10)*10+1) ;       // 시작 페이지
            var nextPage = prePage + 10 - 1;       // 끝 페이지
            
            
            // 블록 변수
            var pageSize = response.data.pageSize; // 10, 1블록당 페이지 수
            var startRow = response.data.startRow;  // 1, 11, 21, 31, 41 ...
            var endRow = response.data.endRow;  // 10, 20, 30, 40, 50 ...
            if (nextPage > pageCount) nextPage = pageCount;
            
            // 가장 처음 페이지
            var paging1 = 
            `<a onClick="javascript:findAll(1)">[처음]   </a>`;
            $("#pageArea").append(paging1);

            // 이전 블록 이동
            if ( prePage > 10) {
                var paging2 =
                `<a onClick="javascript:findAll(\${prePage-10})"> <<  </a>`;
                $("#pageArea").append(paging2);
            } 

            // 페이지 이동 (숫자)
            for (i=prePage; i<=nextPage; i++) { 
                if (pageNum != i) {
                    var paging3 = 
                    `<a onClick="javascript:findAll(\${i})">\${i}  </a>`;
                } else if (pageNum == i) {
                    var paging3 =
                    `<b> \${i} </b>`;
                }

                $("#pageArea").append(paging3);
            }

            // 다음 블록 이동
            if ( nextPage < pageCount) {
                var paging4 =
                `<a onClick="javascript:findAll(\${prePage+10})"> >> </a>`;
                $("#pageArea").append(paging4);
            }

            // 가장 마지막 페이지
            var paging5 = 
            `<a onClick="javascript:findAll(\${pageCount})">   [끝]</a>`;
            $("#pageArea").append(paging5);
            
        })

        .catch(error => {
            console.log(error);
            alert(error);
        });
    } // findAll end

    /********************* 포인트 정렬 *********************/
    function arg(pageNum) {

        //셀렉트 1의 값 - 전체, 가용, 사용
        var arrangeBox1 = document.getElementById("arrangeBox1").value;
        //셀렉트 2의 값 - 오름차순, 내림차순
        var arrangeBox2 = document.getElementById("arrangeBox2").value;
        var url = "http://localhost:80/api/member/members/arg/" + arrangeBox1 + arrangeBox2 + "/" + pageNum;
        
        let token = localStorage.getItem('wtw-token') || '';

        fetch(url, 
        {
            method: "GET",
            mode: 'cors',
            headers: {
            'Content-Type' : 'application/json',
            'Authorization' : `Bearer \${token}`
            }
        })
        
        .then(response => response.json())
        .then(response => {

            $("#memberIndex").empty();
            $("#members").empty();
            $("#pageArea").empty();

            var tableColumnL = (response.data.list.length); // 행 길이
            
            var tableIndex = `
            	<th>아이디</th>
                <th>이름</th>
                <th>핸드폰</th>
                <th style="width:200px;">주소</th>
                <th>나이</th>
                <th>성별</th>
                <th>회원등급</th>
                <th>전체포인트</th>
                <th>가용포인트</th>
                <th>사용포인트</th>
                <th>비고</th>
                <th>가입일자</th>
                <th></th><th></th>
            `;

            $("#memberIndex").append(tableIndex);

            for (var j=0; j<tableColumnL; j++){

                var memValues = Object.values(response.data.list[j]);
                    
                $("#members").append(`<tr>`);

                var i=0;
                while (i < memValues.length) {

                    if (i == 6) i++; // 동의여부 출력 x
                    if( i == 7 ) i=9; // 비밀번호 출력 x
                    if (i == 9) i=12; // 승인일시 출력 x
                    if (i == 13) i++;
                    if (i == 18) i++; // 등록자 출력 x
                    if (i == 20) break;

                    var asd = memValues[i];
                    if (memValues[i] == null || memValues[i] == 0 ) {
                        var asd = "-";
                    }   // null, 0 인 값을 '-' 로 출력
                    
                    if (i == 12) {
                    	if (memValues[12] == 'Y'  && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "관리자";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "일반 회원";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'N' && memValues[10] == 'N') {
                    		var asd = "승인 대기";
                    	} else if (memValues[10] == 'Y') {
                    		var asd = "탈퇴";
                    	}
                    } // 회원 등급 : 일반 회원, 관리자, 승인 대기
                    
                    /* if (i == 1) {
                        // var asd = `<a href = "memberInfo.html">${memValues[i]}</a>`;
                        var asd = `<button class="btn btn-outline-dark btn-sm" style="border:0;"  onClick = " location.href='memberInfo.html' ">${memValues[i]}</button>`;
                    }   // 회원 이름을 클릭하면 활동 내역을 볼 수 있는 페이지로 연결 */

                 	// 탈퇴한 회원일 경우 취소선 적용
                    if (response.data.list[j].stop_yn == 'Y' &&
                        response.data.list[j].admin_yn == 'N' &&
                        response.data.list[j].approval_yn == 'N') {
                        var tdValue = `<td id="delFormat">`;
                    
                    // 일반 회원일 경우 아무런 서식 적용 없음
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' ) {
                        var tdValue = `<td>`;
                    } else if (response.data.list[j].stop_yn == 'N' &&
                             response.data.list[j].admin_yn == 'N' &&
                             response.data.list[j].admin_yn == 'Y' ) {
                      var tdValue = `<td>`;
                    
                    // 관리자 회원일 경우 굵게 빨간 글씨
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'Y' &&
                               response.data.list[j].approval_yn == 'Y')  {
                        var tdValue = `<td id="adminFormat">`;
                    }

                    var data = `\${tdValue}\${asd}</td>`;
                    i++;
                    
                    $("#members").append(data);

                }   // while end (td 추가 끝)
                    
                var member_code = memValues[0];

                var data = 
                `<td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doModifyForm(\${member_code}, \${response.data.pageNum})">수정</button></td>
                 <td><button class="btn btn-outline-danger btn-sm" style="border:0;" onClick="doDelete(\${member_code}, \${response.data.pageNum})">탈퇴</button></td></tr>`
                
                $("#members").append(data);

            }   //for end

            var pageNum = response.data.pageNum     // 1, 현재 페이지
            var pageCount = response.data.pages     // 144, 가장 마지막 페이지
            var memberCount = response.data.total;  // 전체 회원 수

            var prePage = (Math.floor((pageNum - 1)/10)*10+1) ;       // 시작 페이지
            var nextPage = prePage + 10 - 1;       // 끝 페이지
            
            
            // 블록 변수
            var pageSize = response.data.pageSize; // 10, 1블록당 페이지 수
            var startRow = response.data.startRow;  // 1, 11, 21, 31, 41 ...
            var endRow = response.data.endRow;  // 10, 20, 30, 40, 50 ...
            if (nextPage > pageCount) nextPage = pageCount;
            
            // 가장 처음 페이지
            var paging1 = 
            `<a onClick="javascript:arg(1)">[처음]   </a>`;
            $("#pageArea").append(paging1);

            // 이전 블록 이동
            if ( prePage > 10) {
                var paging2 =
                `<a onClick="javascript:arg(\${prePage-10})"> <<  </a>`;
                $("#pageArea").append(paging2);
            } 

            // 페이지 이동 (숫자)
            for (i=prePage; i<=nextPage; i++) { 
                if (pageNum != i) {
                    var paging3 = 
                    `<a onClick="javascript:arg(\${i})">\${i}  </a>`;
                } else if (pageNum == i) {
                    var paging3 =
                    `<b> \${i} </b>`;
                }

                $("#pageArea").append(paging3);
            }

            // 다음 블록 이동
            if ( nextPage < pageCount) {
                var paging4 =
                `<a onClick="javascript:arg(\${prePage+10})"> >> </a>`;
                $("#pageArea").append(paging4);
            }

            // 가장 마지막 페이지
            var paging5 = 
            `<a onClick="javascript:arg(\${pageCount})">   [끝]</a>`;
            $("#pageArea").append(paging5);
            
        })

        .catch(error => {
            console.log(error);
            alert(error);
        });


    } // arg function end

    /********************* 목록으로 돌아가기 *********************/
    function goList() {
        $("#allMemList").show();
        $("#modifyFormArea").empty();
    }

    /********************* 가입 승인 / 미승인 / 탈퇴 목록 *********************/
    function memberState(pageNum) {
        
        // 활동상태 셀렉트 값 - 가입 미승인 / 가입 승인 / 탈퇴
        var memberState = document.getElementById("memberState").value;
        var url = "http://localhost:80/api/member/members/mst/"+ memberState + "/" + pageNum;
        
        let token = localStorage.getItem('wtw-token') || '';

        fetch ( url , 
        {
            method: 'GET',
            mode: 'cors',
            headers: {
                'Content-Type' : 'application/json',
                'Authorization' : `Bearer \${token}`,
            }
        })

        .then(response => response.json())
        .then(response => {

            $("#memberIndex").empty();
            $("#members").empty();
            $("#pageArea").empty();
            
            var tableColumnL = (response.data.list.length); // 행 길이

            var tableIndex = `
                    <th>아이디</th>
                    <th>이름</th>
                    <th>핸드폰</th>
                    <th>나이</th>
                    <th>성별</th>
                    <th>승인일시</th>
                    <th>탈퇴일시</th>
                    <th>회원등급</th>
                    <th>비고</th>
                    <th>가입일자</th>
                    <th>변경일시</th>
                    <th></th><th></th>
            `;

            $("#memberIndex").append(tableIndex);


            for (var j=0; j<tableColumnL; j++) {

                var memValues = Object.values(response.data.list[j]);

                $("#members").append(`<tr>`);

                var i=0;
                while (i < memValues.length) {
                    
                	if (i == 3) i++; // 주소 x
                	if (i == 6) i++; // 동의여부 출력 x
                    if( i == 7 ) i=9; // 비밀번호, 승인여부 출력 x
                    if (i == 10) i++; // 탈퇴 출력x
                    if (i == 13) i=17;
                    if (i == 18) i++; // 등록자 출력 x
                    if (i == 20) i++;

                    var asd = memValues[i];
                    if (memValues[i] == null) {
                        var asd = "-";
                    } else if (memValues[i] == 0) {
                        var asd = "-";
                    } // null, 0 인 값을 '-' 로 출력
                    
                    if (i == 12) {
                    	if (memValues[12] == 'Y'  && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "관리자";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "일반 회원";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'N' && memValues[10] == 'N') {
                    		var asd = "승인 대기";
                    	} else if (memValues[10] == 'Y') {
                    		var asd = "탈퇴";
                    	}
                    } // 회원 등급 : 일반 회원, 관리자, 승인 대기
                    
                 	// 탈퇴한 회원일 경우 취소선 적용
                    if (response.data.list[j].stop_yn == 'Y' &&
                        response.data.list[j].admin_yn == 'N' &&
                        response.data.list[j].approval_yn == 'N') {
                        var tdValue = `<td id="delFormat">`;
                    
                    // 일반 회원일 경우 아무런 서식 적용 없음
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' ) {
                        var tdValue = `<td>`;
                    } else if (response.data.list[j].stop_yn == 'N' &&
                             response.data.list[j].admin_yn == 'N' &&
                             response.data.list[j].admin_yn == 'Y' ) {
                      var tdValue = `<td>`;
                    
                    // 관리자 회원일 경우 굵게 빨간 글씨
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'Y' &&
                               response.data.list[j].approval_yn == 'Y')  {
                        var tdValue = `<td id="adminFormat">`;
                    }

                    var data = `\${tdValue}\${asd}</td>`;
                    i++;

                    $("#members").append(data);

                }   // while end (td 추가 끝)

                var member_code = memValues[0];

                // 가입 미승인 : approval_yn == 'N', stop_yn == 'N', admin_yn == 'N'
                if ( response.data.list[j].approval_yn == 'N' &&
                     response.data.list[j].stop_yn == 'N'&&
                     response.data.list[j].admin_yn == 'N') {

                    var data = `<td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doApproval(\${member_code}, \${response.data.pageNum})">가입승인</button></td></tr>`;
                    $("#members").append(data);
                
                // 가입승인O 관리자X : 
                } else if ( response.data.list[j].approval_yn == 'Y'  &&
                            response.data.list[j].stop_yn == 'N' && 
                            response.data.list[j].admin_yn == 'N') {

                    var data = `<td><button class="btn btn-outline-danger btn-sm" style="border:0;" onClick="doAdmin(\${member_code}, \${response.data.pageNum})">관리자 등록</button></td></tr>`;
                    $("#members").append(data);
                
                // 탈퇴 회원
                } else if (response.data.list[j].stop_yn == 'Y') {
                    var data = `
                    <td><button class="btn btn-outline-danger btn-sm" style="border:0;" onClick="undoDelete(\${member_code}, \${response.data.pageNum})">탈퇴 철회</button></td></tr>`;
                    $("#members").append(data);
                }
                
            } // for end

            var pageNum = response.data.pageNum     // 1, 현재 페이지
            var pageCount = response.data.pages     // 144, 가장 마지막 페이지
            var memberCount = response.data.total;  // 전체 회원 수

            var prePage = (Math.floor((pageNum - 1)/10)*10+1) ;       // 시작 페이지
            var nextPage = prePage + 10 - 1;       // 끝 페이지
            
            // 블록 변수
            var pageSize = response.data.pageSize; // 10, 1블록당 페이지 수
            var startRow = response.data.startRow;  // 1, 11, 21, 31, 41 ...
            var endRow = response.data.endRow;  // 10, 20, 30, 40, 50 ...
            if (nextPage > pageCount) nextPage = pageCount;
            
            // 가장 처음 페이지
            var paging1 = 
            `<a onClick="javascript:memberState(1)">[처음]   </a>`;
            $("#pageArea").append(paging1);

            // 이전 블록 이동
            if ( prePage > 10) {
                var paging2 =
                `<a onClick="javascript:memberState(\${prePage-10})"> <<  </a>`;
                $("#pageArea").append(paging2);
            } 

            // 페이지 이동 (숫자)
            for (i=prePage; i<=nextPage; i++) { 
                if (pageNum != i) {
                    var paging3 = 
                    `<a onClick="javascript:memberState(\${i})">\${i}  </a>`;
                } else if (pageNum == i) {
                    var paging3 =
                    `<b> \${i} </b>`;
                }

                $("#pageArea").append(paging3);
            }

            // 다음 블록 이동
            if ( nextPage < pageCount) {
                var paging4 =
                `<a onClick="javascript:memberState(\${prePage+10})"> >> </a>`;
                $("#pageArea").append(paging4);
            }

            // 가장 마지막 페이지
            var paging5 = 
            `<a onClick="javascript:memberState(\${pageCount})">   [끝]</a>`;
            $("#pageArea").append(paging5);

        })

        .catch(error => {
            console.log(error);
            alert(error);
        })

    }

    /********************* 가입 승인 실행 *********************/
    function doApproval(member_code, pageNum) {

        var url = "http://localhost/api/member/members/doApproval/"+member_code;
        
        let token = localStorage.getItem('wtw-token') || '';

        $(function(){

            $.ajax({

                type: "post",
                url : url,
                data : member_code,
                headers: {
    		        'Authorization': `Bearer \${token}`,
    		  	},
                success : function(result) {
                    alert("가입승인 완료!");
                    memberState(1);
                }

            }); // ajax end

        }); // function end


    }

    /********************* 관리자 등록 *********************/
    function doAdmin(member_code, pageNum) {
        
        var url = "http://localhost/api/member/members/doAdmin/"+member_code;
        
        let token = localStorage.getItem('wtw-token') || '';

        $(function(){

            $.ajax({

                type: "POST",
                url : url,
                data : member_code,
                headers: {
    		        'Authorization': `Bearer \${token}`,
    		  	},
                success : function (result) {
                    alert("관리자 승인 완료!");
                    memberState(1);
                }

            }); // ajax end

        }); // function end

    }

    /********************* 관리자 해제 *********************/
    function doUnadmin(member_code, pageNum) {

        var url = "http://localhost/api/member/members/doUnadmin/"+member_code;
        
        let token = localStorage.getItem('wtw-token') || '';

        $(function(){

            $.ajax({

                type: "POST",
                url : url,
                data : member_code,
                headers: {
    		        'Authorization': `Bearer \${token}`,
    		  	},
                success : function (result) {
                    alert("관리자 해제 완료!");
                    findAll(1);
                }

            }); // ajax end

        }); // function end
    }

    /********************* 검색으로 회원 조회 *********************/
    function doSearch(pageNum) {
        
        var search = document.getElementById("search").value;
        var keyword = document.getElementById("keyword").value;

        var url = "http://localhost/api/member/members/"+search+"/"+keyword+"/"+pageNum;
        
        let token = localStorage.getItem('wtw-token') || '';

        fetch(url, {
            method : "GET",
            mode: "cors",
            headers: {
                'Content-Type' : 'application/json',
                'Authorization' : `Bearer \${token}`,
            }
        })

        .then (response => response.json())
        .then (response => {

            $("#memberIndex").empty();
            $("#members").empty();
            $("#pageArea").empty();

            var tableColumnL = (response.data.list.length); // 행 길이
            
            var tableIndex = `
                <th>아이디</th>
                <th>이름</th>
                <th>핸드폰</th>
                <th style="width:200px;">주소</th>
                <th>나이</th>
                <th>성별</th>
                <th>회원등급</th>
                <th>전체포인트</th>
                <th>가용포인트</th>
                <th>사용포인트</th>
                <th>비고</th>
                <th></th><th></th>
        `;

            $("#memberIndex").append(tableIndex);

            for (var j=0; j<tableColumnL; j++){

                var memKeys = Object.keys(response.data.list[j]);
                var memValues = Object.values(response.data.list[j]);
                
                $("#members").append(`<tr>`);
                
                var i=0;
                while (i < memValues.length) {

                    if (i == 6) i++; // 동의여부 출력 x
                    if( i == 7 ) i=9; // 비밀번호 출력 x
                    if (i == 9) i=12; // 승인일시 출력 x
                    if (i == 13) i++;
                    if (i == 18) break; // 등록자 출력 x

                    var asd = memValues[i];
                    if (memValues[i] == null || memValues[i] == 0 ) {
                        var asd = "-";
                    }   // null, 0 인 값을 '-' 로 출력
                    
                    if (i == 12) {
                    	if (memValues[12] == 'Y'  && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "관리자";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'Y' && memValues[10] == 'N') {
                    		var asd = "일반 회원";
                    	} else if (memValues[12] == 'N' && memValues[8] == 'N' && memValues[10] == 'N') {
                    		var asd = "승인 대기";
                    	} else if (memValues[10] == 'Y') {
                    		var asd = "탈퇴";
                    	}
                    } // 회원 등급 : 일반 회원, 관리자, 승인 대기
                    
                    /* if (i == 1) {
                        // var asd = `<a href = "memberInfo.html">${memValues[i]}</a>`;
                        var asd = `<button class="btn btn-outline-dark btn-sm" style="border:0;"  onClick = " location.href='memberInfo.html' ">${memValues[i]}</button>`;
                    }   // 회원 이름을 클릭하면 활동 내역을 볼 수 있는 페이지로 연결 */

                 	// 탈퇴한 회원일 경우 취소선 적용
                    if (response.data.list[j].stop_yn == 'Y' &&
                        response.data.list[j].admin_yn == 'N' &&
                        response.data.list[j].approval_yn == 'N') {
                        var tdValue = `<td id="delFormat">`;
                    
                    // 일반 회원일 경우 아무런 서식 적용 없음
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' &&
                               response.data.list[j].admin_yn == 'N' ) {
                        var tdValue = `<td>`;
                    } else if (response.data.list[j].stop_yn == 'N' &&
                             response.data.list[j].admin_yn == 'N' &&
                             response.data.list[j].admin_yn == 'Y' ) {
                      var tdValue = `<td>`;
                    
                    // 관리자 회원일 경우 굵게 빨간 글씨
                    } else if (response.data.list[j].stop_yn == 'N' &&
                               response.data.list[j].admin_yn == 'Y' &&
                               response.data.list[j].approval_yn == 'Y')  {
                        var tdValue = `<td id="adminFormat">`;
                    }

                    var data = `\${tdValue}\${asd}</td>`;
                    i++;
                    
                    $("#members").append(data);

                }   // while end (td 추가 끝)
                
                var member_code = memValues[0];

                if ( $("#aC").is(":checked") == false) {  // 일반 회원 노출 버튼

                    var data = `<td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doModifyForm(\${member_code}, \${response.data.pageNum})">수정</button></td>
                    <td><button class="btn btn-outline-danger btn-sm" style="border:0;" onClick="doDelete(\${member_code}, \${response.data.pageNum})">탈퇴</button></td></tr>`
                    $("#members").append(data);

                } else if ( $("#aC").is(":checked")) { // 관리자 회원 노출 버튼
                    
                    var data = `
                    <td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doModifyForm(\${member_code}, ${response.data.pageNum})">수정</button></td>
                    <td><button class="btn btn-outline-dark btn-sm" style="border:0;" onClick="doUnadmin(\${member_code}, ${response.data.pageNum})">관리자 해제</button></td></tr>`
                    $("#members").append(data);

                }
            }   //for end

            var pageNum = response.data.pageNum     // 1, 현재 페이지
            var pageCount = response.data.pages     // 144, 가장 마지막 페이지
            var memberCount = response.data.total;  // 전체 회원 수

            var prePage = (Math.floor((pageNum - 1)/10)*10+1) ;       // 시작 페이지
            var nextPage = prePage + 10 - 1;       // 끝 페이지
            
            
            // 블록 변수
            var pageSize = response.data.pageSize; // 10, 1블록당 페이지 수
            var startRow = response.data.startRow;  // 1, 11, 21, 31, 41 ...
            var endRow = response.data.endRow;  // 10, 20, 30, 40, 50 ...
            if (nextPage > pageCount) nextPage = pageCount;
            
            // 가장 처음 페이지
            var paging1 = 
            `<a onClick="javascript:doSearch(1)">[처음]   </a>`;
            $("#pageArea").append(paging1);

            // 이전 블록 이동
            if ( prePage > 10) {
                var paging2 =
                `<a onClick="javascript:doSearch(\${prePage-10})"> <<  </a>`;
                $("#pageArea").append(paging2);
            } 

            // 페이지 이동 (숫자)
            for (i=prePage; i<=nextPage; i++) { 
                if (pageNum != i) {
                    var paging3 = 
                    `<a onClick="javascript:doSearch(\${i})">\${i}  </a>`;
                } else if (pageNum == i) {
                    var paging3 =
                    `<b> ${i} </b>`;
                }

                $("#pageArea").append(paging3);
            }

            // 다음 블록 이동
            if ( nextPage < pageCount) {
                var paging4 =
                `<a onClick="javascript:doSearch(\${prePage+10})"> >> </a>`;
                $("#pageArea").append(paging4);
            }

            // 가장 마지막 페이지
            var paging5 = 
            `<a onClick="javascript:doSearch(\${pageCount})">   [끝]</a>`;
            $("#pageArea").append(paging5);
            

        })

        .catch(error => {
            console.log(error);
            alert(error);
        })

    }
</script>
<style>

	#membersTitle {
        font-size:xx-large;
        text-align: right;
        margin-top: 30px;
        margin-bottom: 30px;
    }

    #pageArea { text-align: center; }

    #allMemList { text-align: center; font-size:smaller;}
    
    #wrapper { justify-content: center; width:1100px;}
    
    #delFormat {
        text-decoration: line-through;
        color: darkgray;
    }

    #indexArea {
        text-align: right;
        font-size: large;
        font-weight:600;
    }
    
    #inputArea {
        width: 600px;
    }

    #adminFormat {
        font-weight: bold;
        color: red;
    }

    #modifyFormArea {
        text-align: center;
        display:flex;
    }

    #searchBox {
        float: right;
    }

    #alignArea {
        margin-top: 10px;
    }

    select {
        width:100px;
    }

    /* span { border: 1px red; border-style: solid;} */

    div{
        margin:auto;
    }

    table {
        margin: auto;
        /* width: 90%; */
        vertical-align:middle;
    }

    #member_code {width:500px;}
    #password {width:500px;}
    #member_name {width:500px;}
    #address {width:500px;}
    #mobile_no {width:500px;}
    #sex {width:500px;}
    #age {width:500px;}
    #create_date {width:500px;}
    #stop_date {width:500px;}
    #admin_yn {width:500px;}

</style>
<body>
<jsp:include page="../header.jsp"/>
<script>
    findAll(1);
</script>
<div class="container mt-5 mb-5">
<div class="row">
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="col-sm-10 ps-5">
<div id="wrapper">

<div class="container text-center h-auto">
        <div class="row">
          <div class="col" id="membersTitle">
           전체 회원 정보
          </div>
          <div class="col">
          </div>
          <div class="col">
          </div>
        </div>
      </div>
      
    <div id="alignArea">
        <span>
            <button type="button" class="btn btn-dark btn-sm" onClick="location.reload()">전체회원보기</button>
        </span>
        <span id="adminCheck">
            <input type="checkbox" id="aC" onClick="findAll(1)"> 
            <label for="aC"> 관리자</label>
        </span>
        <br><br>
        <span>
            활동상태 : 
            <select style="width:100px;" id="memberState">
                <option value=""></option>
                <option value="approvaly">가입 승인</option>
                <option value="approvaln">가입 미승인</option>
                <option value="delmember">탈퇴</option>
            </select>
            <button type="button" class="btn btn-dark btn-sm" onClick="memberState(1)">검색</button>
        </span><br>
        <span>
            정렬기준 : 
            <select id="arrangeBox1">
                <option value=""></option>
                <option id="total" value="total">전체포인트</option>
                <option id="req" value="req">가용포인트</option>
                <option id="use" value="use">사용포인트</option>
            </select>
            정렬방식 : 
            <select id="arrangeBox2">
                <option value=""></option>
                <option id="asc" value="asc">오름차순</option>
                <option id="desc" value="desc">내림차순</option>
            </select>
            <button type="button" class="btn btn-dark btn-sm" onClick="arg(1)">정렬</button>
        </span>
        <span id="searchBox">
            <form id="frmSearch">
                <select id="search">
                    <option value="member_code">회원코드</option>
                    <option value="member_name">이름</option>
                    <option value="mobile_no">핸드폰</option>
                    <option value="address">주소</option>
                    <option value="age">나이</option>
                    <option value="sex">성별</option>
                </select>
            <input type="text" id="keyword">
            <button type="button" class="btn btn-dark btn-sm" onClick="doSearch(1)">찾기</button>
        </form>
        </span>
    </div>
    <br>
    <div id="allMemList">
        <table class="table">
            <thead>
                <tr id="memberIndex">
                </tr>
            </thead>
            <tbody id="members"></tbody>
        </table>
        <br><br>
    </div>
    <div id="pageArea"></div>
    <div id="modifyFormArea"></div>
    <br><br><br>
</div>
</div></div></div>
<jsp:include page="../footer.jsp"/>
</body>
</html>
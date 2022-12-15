function check() {

    var member_code = document.getElementById("member_code");
    var member_name = document.getElementById("member_name");
    var mobile_no = document.getElementById("mobile_no");
    var address = document.getElementById("address");
    var age = document.getElementById("age");
    var sex = document.getElementById("sex");
    var password = document.getElementById("password");
    var password2 = document.getElementById("password2");
    var availableId = document.getElementsByTagName('div')[3];

    if (member_code.value == "")  {
        alert("아이디를 입력해주세요");
        member_code.focus();
        return false;
    }

    if (member_name.value == "") {
        alert("이름을 입력해주세요");
        member_name.focus();
        return false;
    }

    if (mobile_no.value == "") {
        alert("휴대폰 번호를 입력해주세요");
        mobile_no.focus();
        return false;
    }

    if (address.value == "") {
        alert("주소를 입력해주세요");
        address.focus();
        return false;
    }

    if (age.value == "") {
        alert("나이를 입력해주세요");
        age.focus();
        return false;
    }

    if (sex.value == "") {
        alert("성별을 입력해주세요");
        sex.focus();
        return false;
    }

    if (password.value == "") {
        alert("비밀번호를 입력해주세요");
        password.focus();
        return false;
    }

    if (password2.value == "") {
        alert("비밀번호 확인을 입력해주세요");
        password.focus();
        return false;
    }

    if (password.value != password2.value) {
        alert("비밀번호가 일치하지 않습니다");
        password.value = "";
        password2.value = "";
        password.focus();
        return false;
    }

    if (availableId == null) {
        alert("ID 중복 검사를 진행해주세요");
        member_code.focus();
        return false;
    }

}
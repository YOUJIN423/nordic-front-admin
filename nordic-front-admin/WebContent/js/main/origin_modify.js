let sel_files = [];
let board_no;
let update_member;
let create_member;
let pre_Img;
let image_no

$(document).ready(function (){
    $("#input_imgs").on("change", handleImgFileSelect);
});

function fileUploadAction() {
    console.log("fileUploadAction")
    $("#input_imgs").trigger("click")
}

function handleImgFileSelect(e) {
    sel_files = [];
    $(".img-wrap").empty();

    let files = e.target.files;
    let fileArr = Array.prototype.slice.call(files);

    let index = 0;
    fileArr.forEach(function (f) {
        if(!f.type.match("image.*")) {
            alert("이미지만 첨부 가능합니다.");
            return;
        }

        sel_files.push(f);

        let reader = new FileReader();
        reader.onload = function (e) {
            let html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\">" +
                "<img src=\""+ e.target.result +"\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";

            $(".img-wrap").append(html);
            index++;
        }

        reader.readAsDataURL(f);

    })
}

function deleteImageAction(index) {
    console.log("index : " + index);
    sel_files.splice(index, 1);

    let img_id = "#img_id_" + index;
    $(img_id).remove();

    console.log(sel_files);
}

$.ajax({
    method: "GET",
    url: "http://localhost:80/api/origin",
    success: (result) => {
        console.log(result)
        let dataList = result.data;
        console.log(dataList)
        let data = result.data[0];
        console.log(data)

        board_no = data.board_no;
        create_member = data.create_member;
        update_member = create_member;

        let title = data.board_object;
        let desc = data.board_desc;

        $("#board_object").val(title)
        $("#content").val(desc)

        let index = 0;
        for (let i = 0; i < dataList.length; i++) {
            if(dataList[i].image_use_yn == 'Y') {
                let imgData = dataList[i]
                pre_Img = imgData.orignal_name;
                image_no = imgData.board_image_no;

                let html = "<button type='button' onclick=\"deleteImg("+ image_no +")\" " +
                    "class=\"btn btn-danger btn-sm\" style=\"font-size: 5pt;\">X</button>" +
                    "<span>&nbsp" + pre_Img + "</span><br>"
                $("#imgList").append(html)

            }
        }
    }
});

function deleteImg(no) {
    console.log('deleteImg, image_no - ' + no)

    $.ajax({
        method: 'DELETE',
        url: 'http://localhost:80/api/img/' + update_member + '/' + no,
        beforeSend: (xhr) => {
            let answer = confirm('정말 삭제하시겠습니까?');
            if(!answer) xhr.abort();
        }
        ,
        success: (data) => {
            console.log(data)
            alert('삭제완료!')
        }
    });
}

function submitAction() {

    let formData = new FormData();
    let data = {
        "board_no"     : board_no,
        "board_object" : $("#board_object").val(),
        "board_desc"   : $("#content").val(),
        "reply_yn"     : $("input[name=reply_yn]:checked").val(),
        "create_member": create_member,
        "update_member": update_member
    }
    console.log(data)

    formData.append("board", new Blob([JSON.stringify(data)] , {type : "application/json"}));
    for(let i = 0; i < $("#input_imgs")[0].files.length; i++) {
        formData.append("files", $("#input_imgs")[0].files[i]);
    }

    $.ajax({
        type: "PUT",
        url: "http://localhost:80/api/origin/" + board_no,
        contentType: false,
        processData: false,
        enctype: "multipart/form-data",
        data: formData,
        dataType: "json",
        beforeSend: (xhr) => {
            let choice = confirm('수정하시겠습니까?');
            if(!choice) xhr.abort();
        },
        success: (result) => {
            console.log(result)

            alert("수정완료!");
            location.href = "origin.jsp";
        }
    });
}
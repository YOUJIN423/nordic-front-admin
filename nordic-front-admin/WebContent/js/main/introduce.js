let board_no;
let update_member;

window.onload = function() {
    $(document).ready(function (){
        $.ajax({
            type: 'GET',
            url: 'http://localhost:80/api/intro',
            success: (result) => {
                let data = result.data;
                console.log(data);
                let board = data[0];
                board_no = board.board_no;
                update_member = board.create_member;

                let path = new Array();
                for (let i = 0; i < data.length; i++) {
                    if(data[i].image_use_yn == 'Y') {
                        let name = data[i].image_file;
                        console.log(name);
                        path.push(name);
                    }
                }
                getImg(path);

                $('#desc').html(board.board_desc)

            }
        })
    })
}

function resetLoad() {
    $(document).ready(function (){
        $.ajax({
            type: 'GET',
            url: 'http://localhost:80/api/intro',
            success: (result) => {
                let data = result.data;
                console.log(data);
                let board = data[0];
                board_no = board.board_no;
                update_member = board.create_member;

                let path = new Array();
                for (let i = 0; i < data.length; i++) {
                    if(data[i].image_use_yn == 'Y') {
                        let name = data[i].image_file;
                        console.log(name);
                        path.push(name);
                    }
                }
                getImg(path);

                $('#desc').html(board.board_desc)

            }
        })
    })
}


function getImg(path) {
    console.log("getImg - " + path.length);

    let fileName;

    for (let i = 0; i < path.length; i++) {
        fileName = path.at(i).substr(path.at(i).lastIndexOf('/') + 1);
        console.log(fileName);

        let getImage = new Image();
        getImage.src = 'http://localhost:80/api/img/' + fileName;
        getImage.width = 900;
        getImage.height = 600;

        $('#img-wrap').append(getImage);
        $('#img-wrap').append('<br><br><br>');

    }
}

function deleteIntro() {
    $.ajax({
        type: 'DELETE',
        url: 'http://localhost:80/api/intro/' + board_no + '/' + update_member,
        beforeSend: (xhr) => {
            let choice = confirm('정말 삭제하시겠습니까?');
            if(!choice) xhr.abort();
        },
        success: (result) => {
            console.log(result);
            resetLoad();

        }
    });
}
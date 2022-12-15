let board_no;
let update_member;

window.onload = function () {
    $.ajax({
        type: 'GET',
        url: 'http://localhost:80/api/origin',
        success: (result) => {
            console.log(result);
            let data = result.data;
            let origin = data[0];
            $('#desc').html(origin.board_desc);

            let path = new Array();
            for (let i = 0; i < data.length; i++) {
                if (data[i].image_use_yn == 'Y') {
                    let name = data[i].image_file;
                    console.log(name);
                    path.push(name);
                }
            }
            getImg(path);

        }
    });
}

function getImg(path) {
    console.log("path length - " + path.length);

    let fileName;
    for (let i = 0; i < path.length; i++) {
        fileName = path.at(i).substr(path.at(i).lastIndexOf('/') + 1);
        console.log(fileName);

        let getImage = new Image();
        getImage.src = 'http://localhost:80/api/img/' + fileName;
        getImage.width = 900;
        getImage.height = 600;

        $('#origin-image').append(getImage);
        $('#origin-image').append('<br><br><br>');
    }
}

function deleteOrigin() {
    $.ajax({
        type: 'DELETE',
        url: 'http://localhost:80/api/origin/' + board_no + '/' + update_member,
        beforeSend: (xhr) => {
            let choice = confirm('삭제하시겠습니까?');
            if(!choice) xhr.abort();
        },
        success: (result) => {
            $('#origin-content').remove();
        }
    })
}

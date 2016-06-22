function startDemo() {
    draw();
}

$('#startBtn').on('click', function(){
    $('#myCanvas').fadeIn();
    $('#video').fadeIn();
    draw();
    $('#jumboText').fadeOut();
})
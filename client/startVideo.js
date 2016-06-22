function startDemo() {
    draw();
}

$('#startBtn').on('click', function(){
    $('#myCanvas').fadeTo(1000,.8);
    $('#video').fadeIn();
    draw();
    $('#jumboText').fadeOut();
})
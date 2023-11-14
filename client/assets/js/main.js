$(document).ready(function () {
    $(".navbar-burger").click(function () {
        $(".navbar-active").toggleClass("is-active");
        $(".navbar-burger").toggleClass("is-active");
    });

    var text = $("#typedText").text();
    $("#typedText").text("");
    var charCount = 0;
    
    function typeText() {
        var slice = text.slice(0, charCount++);
        $("#typedText").text(slice);
    
        if (charCount <= text.length) {
            setTimeout(typeText, 50);
        }
    }
    
    typeText();
});


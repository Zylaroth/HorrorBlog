$(document).ready(function () {
    // Включение бургера
    $(".navbar-burger").click(function () {
        $(".navbar-active").toggleClass("is-active");
        $(".navbar-burger").toggleClass("is-active");
    });

    // Идентификатор слайдера
    bulmaCarousel.attach('.carousel', {
        slidesToScroll: 1,
        slidesToShow: 1
    });

    // Появление текста
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


$(document).ready(function () {
    $(".navbar-burger").click(function () {
        $(".navbar-active").toggleClass("is-active");
        $(".navbar-burger").toggleClass("is-active");
    });
});
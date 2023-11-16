$(document).ready(function () {
  // Включение бургера
  $(".navbar-burger").click(function () {
    $(".navbar-active").toggleClass("is-active");
    $(".navbar-burger").toggleClass("is-active");
  });

  $(".modal-active").click(function () {
    $(".modal").toggleClass("is-active");
  });

  $(".modal-delete, .modal-cancel").click(function () {
    $(".modal").removeClass("is-active");
  });

  let currentCarousel = 0;
  const carousel = $('#carousel');
  const carouselItems = $('.carousel');
  const prevImage = $('#prev-image');
  const nextImage = $('#next-image');

  function updateCarousel() {
    const translateValue = -currentCarousel * 100 + '%';
    carousel.css('transform', 'translateX(' + translateValue + ')');
  }

  function updateSideImages() {
    const prevImageSrc = (currentCarousel - 1 + carouselItems.length) % carouselItems.length;
    const nextImageSrc = (currentCarousel + 1) % carouselItems.length;

    prevImage.attr('src', carouselItems.eq(prevImageSrc).find('img').attr('src'));
    nextImage.attr('src', carouselItems.eq(nextImageSrc).find('img').attr('src'));
  }

  function handleClick() {
    $(this).attr('id') === 'prev' ? currentCarousel = (currentCarousel - 1 + carouselItems.length) % carouselItems.length : currentCarousel = (currentCarousel + 1) % carouselItems.length;
    updateCarousel();
    updateSideImages();
  }

  $('#prev, #next, #prev-image, #next-image').on('click', handleClick);

  updateSideImages();

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


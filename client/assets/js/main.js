$(document).ready(function () {

  // Бургер
  $(".navbar-burger").click(function () {
    $(".navbar-active").toggleClass("is-active");
    $(".navbar-burger").toggleClass("is-active");
  });

  // Модальное окно
  $(".modal-active").click(function () {
    $(".modal").toggleClass("is-active");
  });

  $(".modal-delete, .modal-cancel").click(function () {
    $(".modal").removeClass("is-active");
  });

  // Карусель
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

  // Подтекст
  const TypedText = (text, targetElementId) => {
    var charCount = 0;

    function typeText() {
      var slice = text.slice(0, charCount++);
      $(`#${targetElementId}`).text(slice);

      if (charCount <= text.length) {
        setTimeout(typeText, 50);
      }
    }

    typeText();
  };

  // Обработка AJAX
  const fetchData = async (url) => {
    try {
      const response = await fetch('http://localhost:3000' + url);
      const data = await response.json();
      var text = data.message;
      return text

    } catch (error) {
      console.error('Ошибка:', error);
    }
  };

  (async () => {
    const textData = await fetchData('/api/index');
    TypedText(textData, 'typedText');
  })();

  const populateTable = (moviesData) => {
    const tableBody = document.querySelector('tbody');

    moviesData.forEach((movie) => {
      const row = document.createElement('tr');
      row.innerHTML = `
      <td>${movie['Movie ID']}</td>
      <td><figure class="image is-3by4"><img src="${movie['Image URL']}" alt="${movie.title}"></td></figure>
      <td>${movie.Title}</td>
      <td>${movie.Director}</td>
      <td>${movie['Release Date']}</td>
      <td>${movie.Rating}</td>
      <td>${movie.Genre}</td>
      <td>${movie.Actors}</td>
        `;
      tableBody.appendChild(row);
    });
  };

  (async () => {
    try {
      const moviesData = await fetchData('/api/movies');
      populateTable(moviesData);
    } catch (error) {
      console.error('Ошибка при получении данных:', error);
    }
  })();
});
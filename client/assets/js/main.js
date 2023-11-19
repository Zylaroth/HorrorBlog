$(document).ready(function () {

  // Бургер
  $(".navbar-burger").click(function () {
    $(".navbar-active, .navbar-burger").toggleClass("is-active");
  });

  // Модальное окно
  $(".modal-active").click(function () {
    $(".modal").toggleClass("is-active");
  });

  $(".modal-delete, .modal-cancel").click(function () {
    $(".modal").removeClass("is-active");
  });

  // Карусель
  const initCarousel = () => {
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
  };


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

  const populateTableMovie = (moviesData) => {
    const tableBody = document.querySelector('.movie');

    moviesData.forEach((movie) => {
      const row = document.createElement('tr');
      row.innerHTML = `
      <td>${movie['Movie ID']}</td>
      <td><figure class="image is-3by4"><img src="${movie['Image URL']}" alt="${movie.title}"></td></figure>
      <td class="has-text-weight-bold">${movie.Title}</td>
      <td>${movie.Director}</td>
      <td>${movie['Release Date']}</td>
      <td>${movie.Rating}</td>
      <td>${movie.Genre}</td>
      <td>${movie.Actors}</td>
        `;
      tableBody.appendChild(row);
    });
  };

  const populateTableReview = (review) => {
    const reviewBody = document.querySelector('#review');
    const newDiv = document.createElement('div');
    newDiv.classList.add('tile', 'is-ancestor');

    newDiv.innerHTML = `
    <div class="tile is-4 is-vertical is-parent">
    <div class="tile is-child box has-background-white-ter">
      <figure class="image is-3by4">
        <img src="${review['Image URL']}">
      </figure>
    </div>
    <div class="tile is-child box has-background-white-ter"><p class="subtitle">${review.Date}</p></div>
    </div>
    <div class="tile is-parent">
    <div class="tile is-child box has-background-white-ter">
      <p class="title">${review.Title}</p>
      <p class="subtitle">${review.Text}</p>
    </div>
    </div>
    `;
    reviewBody.appendChild(newDiv);
  }

  const handleDataFetch = async () => {
    try {
      const textData = await fetchData('/api/index');
      const carousel = document.querySelector('#carousel');
      TypedText(textData[0], 'typedText');

      textData[1].forEach((url) => {
        const newDiv = document.createElement('div');
        newDiv.classList.add('carousel');
        newDiv.innerHTML = `<img src="${url}">`;
        carousel.appendChild(newDiv);

        initCarousel();
      });

      const moviesData = await fetchData('/api/movies');
      const reviewData = await fetchData('/api/review');
      populateTableMovie(moviesData);
      populateTableReview(reviewData[0]);

      const movieSelect = document.getElementById('movieSelect');
      movieSelect.innerHTML = '';

      moviesData.forEach((movie) => {
        if (!movie.is_reviewed) {
          const option = document.createElement('option');
          option.value = movie["Movie ID"];
          option.textContent = movie.Title;
          movieSelect.appendChild(option);
        }
      })
    } catch (error) {
      console.error('Ошибка при получении данных:', error);
    }
  };

  (async () => {
    await handleDataFetch();
  })();

  $("#send-review").click(async function () {
    const movieId = $("#movieSelect").val();
    const text = $("#review-text").val();
    $(".modal").removeClass("is-active");

    try {
      const response = await fetch('http://localhost:3000/api/create/review', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          movie_id: parseInt(movieId),
          text: text,
        }),
      });

      if (response.ok) {
        console.log('Рецензия успешно добавлена');
      } else {
        const errorMessage = await response.text();
        console.error('Ошибка при добавлении рецензии:', errorMessage);
      }
    } catch (error) {
      console.error('Ошибка:', error);
    }
  });
});
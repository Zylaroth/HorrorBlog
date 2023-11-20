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
      <td id="titleCell" class="has-text-weight-bold"><span>${movie.Title}</span></td>
      <td id="titleCell"><span>${movie.Director}</span></td>
      <td id="titleCell"><span>${movie['Release Date']}</span></td>
      <td id="titleCell"><span>${movie.Rating}</span></td>
      <td id="titleCell"><span>${movie.Genre}</span></td>
      <td id="titleCell"><span>${movie.Actors}</span></td>
        `;
      tableBody.appendChild(row);
    });
    $('[id="titleCell"]').each(function () {
      const $this = $(this);
      const originalText = $this.text();
      const truncatedText = originalText.length > 50 ? originalText.slice(0, 50) + '...' : originalText;
      $this.text(truncatedText);
      $this.data('original-text', originalText);
    });
    
    $('[id="titleCell"]').click(function () {
      const $this = $(this);
      const originalText = $this.data('original-text') || $this.text();
      const isTruncated = $this.data('is-truncated') || false;
    
      if (!isTruncated) {
        $this.text(originalText);
        $this.data('is-truncated', true);
      } else {
        $this.data('original-text', originalText);
        const truncatedText = originalText.length > 50 ? originalText.slice(0, 50) + '...' : originalText;
        $this.text(truncatedText);
        $this.data('is-truncated', false);
      }
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
    <div class="tile is-child box has-background-white-ter"><p class="subtitle"><strong>Время публикации: </strong>${review.Date}</p></div>
    </div>
    <div class="tile is-parent">
    <div class="tile is-child box has-background-white-ter">
      <p class="title">${review.Title}</p>
      <p class="subtitle text">${review.Text}</p>
    </div>
    </div>
    `;
    reviewBody.appendChild(newDiv);
  }

  const populateMovieSelect = (moviesData) => {
    const movieSelect = document.getElementById('movieSelect');
    movieSelect.innerHTML = '';

    const availableMovies = moviesData.filter(movie => !movie.is_reviewed);

    if (availableMovies.length === 0) {
      const option = document.createElement('option');
      option.textContent = 'Нет доступных фильмов';
      option.disabled = true;
      movieSelect.appendChild(option);
    } else {
      availableMovies.forEach((movie) => {
        const option = document.createElement('option');
        option.value = movie["Movie ID"];
        option.textContent = movie.Title;
        movieSelect.appendChild(option);
      });
    }
  };

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
      populateMovieSelect(moviesData);

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
        const updatedMoviesData = await fetchData('/api/movies');
        populateMovieSelect(updatedMoviesData);
      } else {
        const errorMessage = await response.text();
        console.error('Ошибка при добавлении рецензии:', errorMessage);
      }
    } catch (error) {
      console.error('Ошибка:', error);
    }
  });

  $("#send-movie").click(async function () {
    const title = $("#movie").val();
    const director = $("#director").val();
    const actors = $("#actors").val();
    const releaseDate = $("#releaseDate").val();
    const rating = $("#rating").val();
    const genres = $("#genres").val();
    const url = $("#url").val();
    $(".modal").removeClass("is-active");
  
    try {
      const response = await fetch('http://localhost:3000/api/create/movie', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          title: title,
          director: director,
          actors: actors,
          release_date: releaseDate,
          rating: parseFloat(rating),
          genres: genres.split(',').map(genre => {
            const trimmedGenre = genre.trim();
            return trimmedGenre.charAt(0).toUpperCase() + trimmedGenre.slice(1).toLowerCase();
          }),
          url: url,
        }),
      });
  
      if (response.ok) {
        console.log('Фильм успешно добавлен');
        const updatedMoviesData = await fetchData('/api/movies');
        populateMovieSelect(updatedMoviesData);
      } else {
        const errorMessage = await response.text();
        console.error('Ошибка при добавлении фильма:', errorMessage);
      }
    } catch (error) {
      console.error('Ошибка:', error);
    }
  });

  $("#modalTypeSelect").change(async function () {
    const isMovie = $("#modalTypeSelect").val() === 'movie';
    $("#movieFieldsContainer").css('display', isMovie ? 'block' : 'none');
    $("#reviewFieldsContainer").css('display', isMovie ? 'none' : 'block');
  });
});
$(document).ready(function () {

  // Бургер
  $(".navbar-burger").click(function () {
    $(".navbar-active, .navbar-burger").toggleClass("is-active");
  });

  // Модальное окно
  $(".modal-active").click(function () {
    $(".modal").toggleClass("is-active");
  });

  $(".modal-delete, .modal-cancel, .modal-close").click(function () {
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
      $(this).attr('id') === 'prev' || $(this).attr('id') === 'prev-image' ? currentCarousel = (currentCarousel - 1 + carouselItems.length) % carouselItems.length : currentCarousel = (currentCarousel + 1) % carouselItems.length;
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
    const tableBody = $('.movie');

    moviesData.forEach((movie) => {
      const row = $('<tr>');
      row.html(`
        <td id="${movie['Movie ID']}">${movie['Movie ID']}</td>
        <td><figure class="image is-3by4"><img src="${movie['Image URL']}" alt="${movie.title}"></figure></td>
        <td id="titleCell" class="has-text-weight-bold link"><span>${movie.Title}</span></td>
        <td id="titleCell"><span>${movie.Director}</span></td>
        <td id="titleCell"><span>${movie['Release Date']}</span></td>
        <td id="titleCell"><span>${movie.Rating}</span></td>
        <td id="titleCell"><span>${movie.Genre}</span></td>
        <td id="titleCell" class="text-small"><span>${movie.Actors}</span></td>
      `);
      
      row.find('.link').click(async function () {
        const movieId = movie['Movie ID'];
      
        try {
          const review = await fetchData(`/api/review/${movieId}`);
          console.log(review)
          if (review) {
            $("#review-image-url").attr("src", review[0]['Image URL']);
            $("#review-title").text(review[0].Title);
            $("#review-text").text(review[0].Text);
            $("#review-date").text(review[0].Date);
      
            $("#reviewModal").addClass("is-active");
          } else {
            console.error('Review data is empty or not available.');
          }
        } catch (error) {
          console.error('Error fetching review data:', error);
        }
      });

      tableBody.append(row);

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
    <div class="tile is-child has-background-transparent"></div>
    <div class="tile is-child has-background-transparent"></div>
    <div class="tile is-child has-background-transparent"></div>
    <div class="tile is-child has-background-transparent"></div>
    <div class="tile is-child has-background-transparent"></div>
    <div class="tile is-child has-background-transparent"></div>
    <div class="tile is-child has-background-transparent"></div>
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

      textData[1].forEach((data) => {
        const newDiv = document.createElement('div');
        newDiv.classList.add('carousel');
        newDiv.innerHTML = `<a href="#${data.id}"><img src="${data.image_url}"></a>`;
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
    const text = $("#review_text").val();
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
        alert('Рецензия успешно добавлена')
      } else {
        const errorMessage = await response.text();
        console.error('Ошибка при добавлении рецензии:', errorMessage);
        alert('Ошибка при добавлении рецензии:', errorMessage)
      }
    } catch (error) {
      console.error('Ошибка:', error);
      alert('Ошибка:', error)
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

    function isValidImageUrl(url) {
      var imageRegex = /\.(jpeg|jpg|gif|png|bmp)$/;
      return imageRegex.test(url);
    }

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
          url: isValidImageUrl(url) ? url : null,
        }),
      });

      if (response.ok) {
        console.log('Фильм успешно добавлен');
        const updatedMoviesData = await fetchData('/api/movies');
        populateMovieSelect(updatedMoviesData);
        alert('Фильм успешно добавлен')
      } else {
        const errorMessage = await response.text();
        console.error('Ошибка при добавлении фильма:', errorMessage);
        alert('Ошибка при добавлении фильма:', errorMessage)
      }
    } catch (error) {
      console.error('Ошибка:', error);
      alert('Ошибка:', error)
    }
  });

  $("#modalTypeSelect").change(async function () {
    const isMovie = $("#modalTypeSelect").val() === 'movie';
    $("#movieFieldsContainer").css('display', isMovie ? 'block' : 'none');
    $("#reviewFieldsContainer").css('display', isMovie ? 'none' : 'block');
  });
});
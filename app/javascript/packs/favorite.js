document.addEventListener("DOMContentLoaded", () => {
    const favoriteStars = document.querySelectorAll(".favorite");
  
    favoriteStars.forEach(star => {
      star.addEventListener("click", function() {
        const postId = this.dataset.postId;
        const starIcon = this.querySelector("i");
  
        fetch(`/favorites/toggle`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
          body: JSON.stringify({ post_id: postId })
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          if (data.status === 'added') {
            starIcon.classList.remove("far");
            starIcon.classList.add("fas", "filled");
          } else if (data.status === 'removed') {
            starIcon.classList.remove("fas", "filled");
            starIcon.classList.add("far");
          }
        })
        .catch(error => {
          console.error('Fetch error:', error);
        });
      });
    });
  });
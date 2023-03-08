document.addEventListener('DOMContentLoaded', function(event) {
  var algorithms = document.querySelectorAll('.algorithm');
  algorithms.forEach(function(algorithm) {
    algorithm.addEventListener('click', function(event) {
      Array.from(this.children).forEach(function(child) {
        child.classList.toggle('hidden');
      });
    });
  });
});


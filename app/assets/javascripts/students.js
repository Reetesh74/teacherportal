function openModal() {
  document.getElementById("addStudentModal").style.display = "block";
}

function toggleActions(elementId) {
  document.querySelectorAll(".action-popup").forEach((popup) => {
    if (popup.id !== elementId) {
      popup.style.display = "none";
    }
  });

  const element = document.getElementById(elementId);
  element.style.display =
    element.style.display === "none" || element.style.display === ""
      ? "block"
      : "none";
}

window.onclick = function (event) {
  const modal = document.getElementById("addStudentModal");

  if (event.target == modal) {
    modal.style.display = "none";
  }

  if (
    !event.target.matches(".toggle-button") &&
    !event.target.closest(".action-popup")
  ) {
    document.querySelectorAll(".action-popup").forEach((popup) => {
      popup.style.display = "none";
    });
  }
};

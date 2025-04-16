
window.addEventListener("message", function (event) {
  if (event.data.action === "openUI") {
    console.log("UI açılıyor");
    document.body.style.display = "block";
  }
  if (event.data.action === "closeUI") {
    console.log("UI kapanıyor");
    document.body.style.display = "none";
  }
});

document.addEventListener("keydown", function (e) {
  if (e.key === "Escape") {
    fetch(`https://${GetParentResourceName()}/exitUI`, { method: "POST" });
    document.body.style.display = "none";
  }
});

document.addEventListener("DOMContentLoaded", () => {
  const plateInput = document.getElementById("plateInput");
  const buyBtn = document.querySelector(".buy-btn");

  const plateRegex = /^[A-Z0-9]{5,8}$/;

  function isPlateValid(plate) {
    return plateRegex.test(plate);
  }

  function showNotification(message, isError = true) {
    let box = document.createElement("div");
    box.className = "alert-box";
    box.textContent = message;
    box.style.backgroundColor = isError ? "rgba(255, 60, 60, 0.9)" : "rgba(60, 255, 100, 0.9)";
    document.body.appendChild(box);
    setTimeout(() => box.remove(), 3000);
  }

  buyBtn.addEventListener("click", () => {
    const plate = plateInput.value.trim().toUpperCase();
    if (!isPlateValid(plate)) {
      showNotification("5-8 harf/rakam, özel karakter yok.");
      return;
    }
    fetch(`https://${GetParentResourceName()}/sound`, { method: "POST" });
    fetch(`https://${GetParentResourceName()}/buyPlate`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ plate })
    }).then(resp => resp.json())
      .then(data => {
        if (data.success) {
          showNotification("Plaka değişti!", false);
        } else {
          showNotification(data.message || "Hata oluştu.");
        }
      });
  });
});

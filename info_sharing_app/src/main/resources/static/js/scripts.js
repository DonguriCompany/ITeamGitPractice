// scripts.js
document.addEventListener("DOMContentLoaded", function () {
    console.log("Page loaded!");

    // 例: ボタンのクリックイベント
    const buttons = document.querySelectorAll("button");
    buttons.forEach(button => {
        button.addEventListener("click", () => {
            alert("Button clicked: " + button.innerText);
        });
    });
});

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// 編集画面のプレビュー機能
window.previewImage = function(input) {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = function(e) {
      const preview = document.getElementById('preview');
      preview.src = e.target.result;
    }
    reader.readAsDataURL(input.files[0]);
  }
}

// ヘッダーのユーザー名クリックでドロップダウンメニュー表示
window.addEventListener('turbo:load', () => {
  const btn = document.getElementById('mypageBtnContainer');
  const menu = document.getElementById('mypageDropdownMenu');

  if (btn && menu) {
    btn.addEventListener('click', () => {
      menu.classList.toggle('show');
    });

    document.addEventListener('click', (e) => {
      if (!btn.contains(e.target)) {
        menu.classList.remove('show');
      }
    });
  }
});

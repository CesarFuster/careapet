import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Vai deixar seu pet sozinho?", "Procure aqui quem pode cuidar dele", "Care a pet! Conte pra galera!"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };

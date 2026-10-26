// Termos e privacidade abrem com o mesmo tema do app (o app guarda o último tema aplicado); sem ele, seguem o sistema.
try {
  var tema = localStorage.getItem('pense-tema');
  if (tema === 'dark' || tema === 'light') document.documentElement.dataset.theme = tema;
} catch (e) { /* armazenamento indisponível */ }

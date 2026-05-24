const pwInput = document.getElementById('password');
const eyeIcon = document.getElementById('eye-icon');
const toggleBtn = document.getElementById('toggle-pw');

toggleBtn.addEventListener('click', () => {
    const show = pwInput.type === 'password';
    pwInput.type = show ? 'text' : 'password';
    eyeIcon.className = show ? 'ti ti-eye-off' : 'ti ti-eye';
    toggleBtn.setAttribute('aria-label', show ? 'Ocultar contraseña' : 'Mostrar contraseña');
});

document.getElementById('btn-ingresar').addEventListener('click', () => {
    const email = document.getElementById('email').value.trim();
    const pass = pwInput.value;
    const errBox = document.getElementById('error-msg');
    const errText = document.getElementById('error-text');

    if (!email || !pass) {
    errText.textContent = 'Por favor completa todos los campos.';
    errBox.style.display = 'flex';
    } else {
    errBox.style.display = 'none';
    // Aquí conectas tu lógica de autenticación
    console.log('Iniciando sesión con:', email);
    }
});
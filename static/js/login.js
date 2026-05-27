const pwInput = document.getElementById('password');
const eyeIcon = document.getElementById('eye-icon');
const toggleBtn = document.getElementById('toggle-pw');

function showMessage(){
    const errBox = document.getElementById('error-msg');
    errBox.style.display = 'flex';
}

toggleBtn.addEventListener('click', () => {
    const show = pwInput.type === 'password';
    pwInput.type = show ? 'text' : 'password';
    eyeIcon.className = show ? 'ti ti-eye-off' : 'ti ti-eye';
    toggleBtn.setAttribute('aria-label', show ? 'Ocultar contraseña' : 'Mostrar contraseña');
});
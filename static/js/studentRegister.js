const API_URL = "http://localhost:5000/api/asesores";

document.querySelectorAll(".toggle-visibility").forEach(btn => {
    btn.addEventListener("click", () => {
        const targetId = btn.dataset.target;
        const input = document.getElementById(targetId);
        const icon = btn.querySelector("i");
        if (!input) return;

        if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else if (input.type === "text") {
            input.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    });
});

const avatarCircle = document.getElementById("avatarPreview");
const photoInput = document.getElementById("photoInput");
const avatarImg = document.getElementById("avatarImg");
const avatarIcon = document.getElementById("avatarIcon");
let photoBase64 = null;

avatarCircle.addEventListener("click", () => photoInput.click());

photoInput.addEventListener("change", () => {
    const file = photoInput.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = e => {
        photoBase64 = e.target.result; // complete base64
        avatarImg.src = photoBase64;
        avatarImg.style.display = "block";
        avatarIcon.style.display = "none";
    };
    reader.readAsDataURL(file);
});

/* VALIDACIÓN DE CAMPOS */
function showError(id, msg) {
    const input = document.getElementById(id);
    const err = document.getElementById("err-" + id);
    if (input) input.classList.add("is-error");
    if (err) err.textContent = msg;
}

function clearErrors() {
    document.querySelectorAll(".field-input").forEach(el => el.classList.remove("is-error"));
    document.querySelectorAll(".field-error").forEach(el => el.textContent = "");
}

function validateForm() {
    clearErrors();
    let valid = true;

    const nombres = document.getElementById("nombres").value.trim();
    const apellidoP = document.getElementById("apellidoP").value.trim();
    const apellidoM = document.getElementById("apellidoM").value.trim();
    const usuario = document.getElementById("usuario").value.trim();
    const correo = document.getElementById("correo").value.trim();
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    if (!nombres) {
        showError("nombres", "El nombre es requerido.");
        valid = false;
    }

    if (!usuario) {
        showError("usuario", "El nombre de usuario es requerido.");
        valid = false;
    } else if (usuario.length < 4) {
        showError("usuario", "Mínimo 4 caracteres.");
        valid = false;
    }
    
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

    if (!correo) {
        showError("correo", "El correo es requerido.");
        valid = false;
    } else if (!emailRegex.test(correo)) {
        showError("correo", "Ingresa un correo con dominio válido (ej. usuario@gmail.com).");
        valid = false;
    }

    if (!password) {
        showError("password", "La contraseña es requerida.");
        valid = false;
    } else if (password.length < 8) {
        showError("password", "Mínimo 8 caracteres.");
        valid = false;
    }

    if (!confirmPassword) {
        showError("confirmPassword", "Confirma tu contraseña.");
        valid = false;
    } else if (password !== confirmPassword) {
        showError("confirmPassword", "Las contraseñas no coinciden.");
        valid = false;
    }

    /* if (!fechaNacimiento) {
        showError("fechaNacimiento", "La fecha de nacimiento es requerida.");
        valid = false;
    } else {
        const hoy = new Date();
        const nacimiento = new Date(fechaNacimiento);
        const edad = hoy.getFullYear() - nacimiento.getFullYear();
        if (edad < 18) {
            showError("fechaNacimiento", "Debes tener al menos 18 años.");
            valid = false;
        }
    } */

    return valid;
}

function showAlert(msg, type = "error") {
    const box = document.getElementById("alertBox");
    box.className = `alert ${type}`;
    box.innerHTML = `<i class="fas fa-${type === "success" ? "check-circle" : "exclamation-circle"}"></i> ${msg}`;
    box.scrollIntoView({ behavior: "smooth", block: "nearest" });

    if (type === "success") {
        setTimeout(() => { box.classList.add("hidden"); }, 5000);
    }
}

document.getElementById("btnCrear").addEventListener("click", async () => {
    if (!validateForm()) return;

    const btnCrear = document.getElementById("btnCrear");
    const btnText = document.getElementById("btnText");
    const btnLoader = document.getElementById("btnLoader");

    // Estado de carga
    btnCrear.disabled = true;
    btnText.classList.add("hidden");
    btnLoader.classList.remove("hidden");

    const payload = {
        nombres: document.getElementById("nombres").value.trim(),
        apellidoP: document.getElementById("apellidoP").value.trim(),
        apellidoM: document.getElementById("apellidoM").value.trim(),
        usuario: document.getElementById("usuario").value.trim(),
        correo: document.getElementById("correo").value.trim(),
        password: document.getElementById("password").value,
        cuota: null,
        /* fecha_nacimiento: document.getElementById("fechaNacimiento").value, */
        foto: photoBase64 || null,
        rol: "asesorado"
    };

    try {
        fetch("/registerAccount", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        }).then(r => r.json())
        .then(data => {

            if(!data.success){
                showAlert(data.message, "error");
            } else {
                showAlert(data.message, "success");

                location.href = "/";
            }
        });
    } catch (error) {
        console.error("Error de red:", error);
        showAlert("No se pudo conectar con el servidor. Verifica tu conexión.", "error");
    } finally {
        btnCrear.disabled = false;
        btnText.classList.remove("hidden");
        btnLoader.classList.add("hidden");
    }
});

function resetForm() {
    ["nombres", "apellidoP", "apellidoM", "usuario", "correo", "password", "confirmPassword",
        /* "fechaNacimiento" */].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.value = "";
        });

    // Resetear foto
    photoInput.value = "";
    photoBase64 = null;
    avatarImg.src = "";
    avatarImg.style.display = "none";
    avatarIcon.style.display = "";
}
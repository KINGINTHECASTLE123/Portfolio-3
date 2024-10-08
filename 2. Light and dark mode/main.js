const themeSwitch = document.getElementById('theme-switch');

// Function to enable dark mode
const enableDarkMode = () => {
    document.body.classList.add('dark-mode')
}

// Function to disable dark mode
const disableDarkMode = () => {
    document.body.classList.remove('dark-mode')
}

// Toggle between light and dark modes when the button is clicked
themeSwitch.addEventListener("click", () => {
    if (!document.body.classList.contains(`dark-mode`)) {
        enableDarkMode()
    } else {
        disableDarkMode()
    }
});
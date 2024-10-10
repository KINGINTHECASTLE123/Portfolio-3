let score = 20;
let secretValue = Math.floor(Math.random() * 20) + 1;
let guessHistory = [];

const checkButton = document.querySelector('main .check');
const againButton = document.querySelector('header .again');
const victorySound = document.getElementById('victorySound');
const randomInRange = (min, max) => Math.random() * (max - min) + min;
const updateUI = (selector, text) => document.querySelector(selector).textContent = text;
const handleGameOver = () => {
    updateUI('.message', 'Game over! You lost');
    score = 0;
    updateUI('.score', score);
};

againButton.addEventListener('click', function () {
    score = 20;
    secretValue = Math.floor(Math.random() * 20) + 1;
    guessHistory = [];

    victorySound.pause();
    victorySound.currentTime = 0;

    updateUI('.message', 'Start guessing...');
    updateUI('.score', score);
    updateUI('.number', '?');
    document.querySelector('.guess').value = '';
    document.querySelector('.history').textContent = '📍 Guess history:';
});

checkButton.addEventListener('click', function () {
    const userGuess = Number(document.querySelector('.guess').value);
    if (!userGuess || userGuess < 1 || userGuess > 20) {
        updateUI('.message', 'Insert a number between 1 and 20!');
        return;
    }

    guessHistory.push(userGuess);
    document.querySelector('.history').textContent = `📍 Guess history: ${guessHistory.join(', ')}`;

    if (userGuess === secretValue) {
        updateUI('.message', 'Correct answer!');
        updateUI('.number', secretValue);
        victorySound.play();
        runConfetti();
    } else {
        updateUI('.message', userGuess > secretValue ? 'Number too high!' : 'Number too low!');
        score--;
        updateUI('.score', score);

        if (score === 0) {
            handleGameOver();
        }
    }
});

const runConfetti = () => {
    const duration = 3000;
    const animationEnd = Date.now() + duration;
    const defaults = { startVelocity: 30, spread: 360, ticks: 60, zIndex: 0 };

    const interval = setInterval(function () {
        const timeLeft = animationEnd - Date.now();
        if (timeLeft <= 0) {
            return clearInterval(interval);
        }
        const particleCount = 50 * (timeLeft / duration);

        confetti(
            Object.assign({}, defaults, {
                particleCount,
                origin: { x: randomInRange(0.1, 0.3), y: Math.random() - 0.2 },
            })
        );
        confetti(
            Object.assign({}, defaults, {
                particleCount,
                origin: { x: randomInRange(0.7, 0.9), y: Math.random() - 0.2 },
            })
        );
    }, 250);
};
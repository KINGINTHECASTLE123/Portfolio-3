let score = 20;
let secretValue = Math.floor(Math.random() * 20) + 1;
let guessHistory = [];

const checkButton = document.querySelector('main .check');
const againButton = document.querySelector('header .again');

// Funktion til tilfældig værdi i interval
const randomInRange = (min, max) => Math.random() * (max - min) + min;

// Nulstil spillet ved tryk på "Again!" knappen
againButton.addEventListener('click', function () {
    score = 20;
    secretValue = Math.floor(Math.random() * 20) + 1;
    guessHistory = [];

    document.querySelector('.message').textContent = 'Start guessing...';
    document.querySelector('.score').textContent = score;
    document.querySelector('.number').textContent = '?';
    document.querySelector('.guess').value = '';
    document.querySelector('.history').innerHTML = '📍 Guess history:'; // Nulstil visning af guess history
});

// Tjek gæt ved tryk på "Check" knappen
checkButton.addEventListener('click', function () {
    const userGuess = Number(document.querySelector('.guess').value);
    guessHistory.push(userGuess);
    document.querySelector('.history').innerHTML = `📍 Guess history: ${guessHistory.join(', ')}`;

    if (!userGuess || userGuess < 1 || userGuess > 20) {
        document.querySelector('.message').textContent = 'Insert a number between 1 and 20!';
        return;
    }

    if (userGuess === secretValue) {
        document.querySelector('.message').textContent = 'Correct answer!';
        document.querySelector('.number').textContent = secretValue;

        // Tilføj lydeffekt ved korrekt svar
        const victorySound = new Audio('file:///C:/Users/jacbi/Music/claps-29454.mp3');
        victorySound.play();

        // Start confetti animation ved korrekt svar
        const duration = 3000; // Animationens varighed i millisekunder (3 sekunder)
        const animationEnd = Date.now() + duration;

        const defaults = { startVelocity: 30, spread: 360, ticks: 60, zIndex: 0 };

        const interval = setInterval(function () {
            const timeLeft = animationEnd - Date.now();

            if (timeLeft <= 0) {
                return clearInterval(interval); // Stopper animationen, når tiden er op
            }

            const particleCount = 50 * (timeLeft / duration);

            // Confetti skydes fra to forskellige punkter
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
        }, 250); // Kører hvert 250 ms for en jævn effekt

    } else if (userGuess > secretValue) {
        document.querySelector('.message').textContent = 'Number too high!';
        score--;
        document.querySelector('.score').textContent = score;

        if (score === 0) {
            document.querySelector('.message').textContent = 'Game over! You lost';
            return;
        }
    } else {
        document.querySelector('.message').textContent = 'Number too low!';
        score--;
        document.querySelector('.score').textContent = score;

        if (score === 0) {
            document.querySelector('.message').textContent = 'Game over! You lost';
            return;
        }
    }
});

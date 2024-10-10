let score = 20;
let secretValue = Math.floor(Math.random()*20) + 1;

const checkButton = document.querySelector('main .check')
const againButton = document.querySelector('header .again')

againButton.addEventListener('click', function () {
    score = 20;
    secretValue = Math.floor(Math.random() * 20) + 1;
    document.querySelector('.message').textContent = 'Start guessing...';
    document.querySelector('.score').textContent = score;
    document.querySelector('.number').textContent = '?';
    document.querySelector('.guess').value = '';
});

checkButton.addEventListener('click', function () {
    const userGuess = Number(document.querySelector(`.guess`).value);

    if (!userGuess) {
        document.querySelector('.message').textContent = 'Insert a number';
    } else if (userGuess === secretValue) {
        document.querySelector('.message').textContent = 'Correct answer!';
        document.querySelector('.number').textContent = secretValue;
        document.querySelector('.score').textContent = score;
    } else if (userGuess > secretValue){
        document.querySelector('.message').textContent = 'Number to high!';
        score--;
        document.querySelector('.score').textContent = score;
    } else {
        document.querySelector('.message').textContent = 'Number to low!';
        score--;
        document.querySelector('.score').textContent = score;
    }

    if (score === 0) {
        document.querySelector('.message').textContent = 'Game over! You lost';
    }
    if (userGuess < 1 || userGuess > 20) {
        document.querySelector('.message').textContent = 'Insert a number between 1 and 20!';
        return;
    }
});
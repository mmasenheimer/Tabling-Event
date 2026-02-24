const startButton = document.getElementById("startButton");
const mainMenu = document.querySelector('.mainMenu')
const clickable = document.querySelector('.clickableArea')
const message = document.querySelector('.clickableArea .message')
const userData = JSON.parse(localStorage.getItem("userData")) || [];

let username;
let timer;
let greenDisplayed;
let currentTime;
let waitingForStart;
let waitingForGreen;
let resultscreenActive;
let usernameVal;

// clears local storage
function clearscoreboard(){
    localStorage.removeItem("userData");
    location.reload();
}

const startVals= ()=>{
    resultscreenActive = false;
    greenDisplayed = false;
    waitingForStart = false;
    waitingForGreen = false;
}
startVals();

// parses local storage, sorts the items into increasing order, reutrns the top 3
function calculateTop3() {
  const data = JSON.parse(localStorage.getItem("userData")) || [];

  return data
    .filter(item => item.score !== null)
    .sort((a, b) => a.score - b.score)
    .slice(0, 3);
}

// sets the background to green and starts timer
const setGreen = () =>{
    clickable.style.backgroundColor = "limegreen";
    message.innerHTML = "Click!"
    message.style.color =  "#111"
    greenDisplayed = true;
    currentTime = Date.now();
}

// sets the background to red, generates a random number between 3000 and 7000
// which is the time it will take for the screen to turn green.
const startGame = ()=>{
    clickable.style.backgroundColor = "red"
    message.innerHTML = "Wait..."
    let randomNum = Math.floor(Math.random()*4000+3000)
    timer = setTimeout(setGreen, randomNum); 
    waitingForGreen = true;     
    waitingForStart = false;   
}

// if the user clicks on red an error message is displayed and the timer is reset
const displayErrorScreen = () =>{
    clickable.style.backgroundColor = "#0C234B"
    message.innerHTML = `<p>Clicked too soon!</p><p>Click to try again.</p>`
    message.style.color = "white"
    clearTimeout(timer);
    waitingForStart = true;
     
}

// displays the current and the top three scores. If no scores are avaialable yet 
// a "-" is displayed in place of it. A button to clear the scoreboard is also added.
const displayReactionTime = (userTime) =>{
    clickable.style.backgroundColor = "#0C234B"
    const topScores = calculateTop3();
    const first  = topScores[0]?.uName ?? "—";
    const firstScore = topScores[0]?.score ?? "-";

    const second = topScores[1]?.uName ?? "—";
    const secondScore = topScores[1]?.score ?? "-";

    const third  = topScores[2]?.uName ?? "—";    
    const thirdScore = topScores[2]?.score ?? "-";
    message.innerHTML = `
    <div class="reactionTimeText">${userTime} seconds</div>
    <div class= "reactionTimeTextSubtext">Click to continue.</div>
    <div class="podiums">
        <div class="podium small">
            <div class="scorePods">
                <div class="rank">3</div>
                <div class="score">${thirdScore}s</div>
            </div>
            <div class="name">${third}</div>
        </div>

        <div class="podium tall">
            <div class="scorePods">
                <div class="rank1">1</div>
                <div class="score">${firstScore}s</div>
            </div>
            <div class="name1">${first}</div>
        </div>
            
        <div class="podium medium">
            <div class="scorePods">
                <div class="rank">2</div>
                <div class="score">${secondScore}s</div>
            </div>
            <div class="name">${second}</div>
        </div>
        <br>
        <button onclick="clearscoreboard()" id="clearScoreboard">Clear Scoreboard</button>
        </div>`
    greenDisplayed = false;
    waitingForStart = true;
    resultscreenActive = true;
}

// waits for first click, if the username given is valid it deactivates the 
// main menu screen and calls start game. If an invalid username is given , it 
// displays an alert and ends.
startButton.addEventListener("click",()=>{
    username = document.getElementById("username").value.trim();

    if(!username){
        alert("Enter your name");
        return;
    }
    mainMenu.classList.remove("active");
    startGame();
})

// if the user is on the result screen, it sends them to the main menu screen. If 
// the green screen is displayed, it calculates the time it took the user to click and
// calls displayReactionTime(). 
clickable.addEventListener("click",()=>{
    if(resultscreenActive){
        usernameVal = document.getElementById("username");
        username = usernameVal.value.trim();
        usernameVal.value = "";
        mainMenu.classList.add("active");
        message.innerHTML = ``;
        resultscreenActive = false;
        return;
    }
    if(greenDisplayed){
        let clickTime = Date.now();
        let userTime = (clickTime - currentTime)/1000;
        userData.push({uName: username, score: userTime})
        localStorage.setItem("userData",JSON.stringify(userData))
        displayReactionTime(userTime);
        return; 
    }
    if(waitingForStart){
        startGame();
        return;
    }
    if(waitingForGreen){
        displayErrorScreen();
    }
})
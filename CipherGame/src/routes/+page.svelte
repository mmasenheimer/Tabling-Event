<script>
    import { Spring } from 'svelte/motion'
    import Aedan from '$lib/assets/Aedan.png'
    import cipherBottom from '$lib/assets/cipher-bottom.png'
    import cipherTop from '$lib/assets/cipher-top.png'

    let wheelX = new Spring({ x:0})
    let innerWidth = $state(0)
    let originX = $derived(innerWidth / 2)
    let offsetX = $state(0)
    let mouseDown = $state(false)
    var originalMsg = "OLSSV HTIHZZHKVYZ!"
    let output = $state("-------")
    let shift = $derived(Math.floor(Math.min(Math.max(-25,wheelX.current.x / 50), 25)))

    function decode() {
        output = ""
        var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        for (var i = 0; i < originalMsg.length; i++) {  
            if (!letters.includes(originalMsg.charAt(i))) {
                output += originalMsg.charAt(i)
                continue
            }
            var rawAscii = originalMsg.charCodeAt(i)+shift - 65
            let boundAscii = 0

            boundAscii = ((13000 + rawAscii) % 26)+65

            output += String.fromCharCode(boundAscii)
        }
        // @ts-ignore
        document.getElementById('wheelImage').style.right = String(shift*100.99 - 2576 + originX)+'px'

        
    }


</script>

<svelte:window bind:innerWidth={innerWidth} />


<h1>CIPHER GAME</h1>

<div id = 'gameContainer'>
    <div id='originalMsg'><h2>{originalMsg}</h2></div>
    <hr class='borderLines'>
    <div id='wheelContainer'>
        <hr class='wheelMask leftMask'>
        <hr class='wheelMask rightMask'>
        <input id='shiftInput' type="number" defaultValue='0' bind:value={shift} onchange={decode} max='25' min='-25'>
        <img id='staticImage' src={cipherTop} alt='cipherTop'> 
        <img id='wheelImage' src={cipherBottom} alt='cipherBottom'  onmousedown={(e) => {offsetX = e.clientX - originX; wheelX.target = {x: (wheelX.target.x + offsetX)}; decode()}}>
    </div>
    <hr class='borderLines'>
    <div id='output'><h2>{output}</h2></div>
    <div > </div>
    <!-- <p>Origin: {originX} Offset: {offsetX} Wheel: {wheelX.target.x} shift: {shift}</p> -->
</div>

<style>
    h1 {
        font-family: "Fugaz One", sans-serif;
        font-weight: 400;
        font-style: normal;
        font-size: 40px;
        width: 40vw;
        margin-left: 20px;
        margin-top: 15px;
    }
    h2 {
        font-size: 70px;
    }
    .borderLines {
        display: block;
        margin-top: 0;
        margin-bottom: 0;
        margin-left: auto;
        margin-right: auto;
        border: 2px solid black;
        width: 70vw;
    }

    #shiftInput {
        position: absolute;
        bottom: -10px;
        right: 45vw;
        width: 10vw;
        z-index: 1;
    }

    #gameContainer {
        display: flex;
        align-items: center;
        flex-direction: column;
    }
    #originalMsg {

    }
    #dragTest {
        background-color: red;
        width: 60vw;
        height: 20vw;
    }

    #wheelContainer {
        position: relative;
        width: 100vw;
        height: 20vw;
    }

    #staticImage {
        position: absolute;
        right: calc(-2576px + 50vw);
        width: 5152px;
        height: 10vw;
        top: 0;
    }

    #wheelImage {
        position: absolute;
        bottom: 0;
        right: calc(-2576px + 50vw);
        margin-top: 0;
        margin-bottom: 0;
        margin-left: auto;
        margin-right: auto;
        width: 5152px;
        height: 10vw;
        -webkit-user-drag: none;
        user-select: none;
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
        z-index: 0;
    }

    .wheelMask {
        position: absolute;
        margin-top: 0;
        margin-bottom: 0;
        margin-left: 0;
        margin-right: 0;
        width: 250px;
        height: 20vw;
        z-index: 1;
        background-color: white;
        border: 0;
    }

    .leftMask{
        left: 0;
    }

    .rightMask{
        right: 0;
    }


</style>
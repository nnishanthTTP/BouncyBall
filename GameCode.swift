import Foundation

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/


// MARK: Creating The Shapes

// We create a ball
let ball = OvalShape(width: 40, height: 40) // Oval shapes need a width and height


// We create a barrier so our ball won't fall off our screen
let barrierWidth = 300
let barrierHeight = 25

let barrierPoints = [   // Polygon shapes require an array of Points
    Point(x: 0, y: 0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y: barrierHeight),
    Point(x: barrierWidth, y: 0)
]
let barrier = PolygonShape(points: barrierPoints)


// We create a funnel so we can "shoot" our ball from the top of our screen
let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]
let funnel = PolygonShape(points: funnelPoints)


// We create a target so we can turn this app into a game (if the ball hits the target, we get a point)
let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
]
let target = PolygonShape(points: targetPoints)


// MARK: Functions for Setting up Shapes

func setupTarget() {
    /* We set up a target that has physics, can't move, and objects can pass through it */
    
    target.position = Point(x: 200, y: 400)
    target.hasPhysics = true
    target.isImmobile = true
    target.fillColor = .blue
    target.isImpermeable = false
    scene.add(target)
    
    target.name = "target"  // we give this target a name to single it out from the others. Now this is the only shape on our screen that has a name.
}

fileprivate func setupFunnel() {
    /* We place our funnel at the top of our screen, and when it is tapped by the user, the ball will shoot from the funnel */
    
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    funnel.onTapped = dropBall // when we tap on the funnel, call the function to drop the ball
}

fileprivate func setupBarrier() {
    /* We place our barrier towards the bottom on the scene, and make it Immobile so it doesn't fall off the screen */
    
    barrier.position = Point(x: 200, y: 150)
    scene.add(barrier)
    barrier.hasPhysics = true
    barrier.isImmobile = true
}

fileprivate func setupBall() {
    /* We add a red ball to our scene, and we keep track of what other shapes the ball is colliding with using the .onCollision property */
    
    ball.position = Point(x: 250, y: 400)
    scene.add(ball)
    ball.hasPhysics = true
    ball.fillColor = .red
    
    ball.onCollision = ballCollided(with:)
}

// MARK: Setting Up Our Scene

func setup() {
    /* We set up all of our shapes using their respective functions */
    setupBall()

    setupBarrier()
    
    setupFunnel()
    
    setupTarget()
}


// MARK: Extra Functions

func ballCollided(with otherShape: Shape) {
    /* Since we only want the target to change color, we need to make sure that we're colliding with the right shape, using the name of the shape */
    if otherShape.name != "target" { return } // If we're checking a shape whose name is not target, we exit the function
    otherShape.fillColor = .green   // if we collide with our target, change the color to green
}

func dropBall() {
    // to make the ball "shoot out" of the funnel, we set its position to the funnel's position
    ball.position = funnel.position
}



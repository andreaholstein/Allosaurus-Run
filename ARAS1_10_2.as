package  
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import fl.motion.Color;
	import flash.utils.Timer;
	
	public class ARAS1_10_2 extends MovieClip 
	{		var list : Array = new Array( );
			var timer: Timer = new Timer(2500);
			
			var smallRock: SmallRock = new SmallRock( ); 
			var medRock: MedRock = new MedRock( );
			var largeRock: LargeRock = new LargeRock( );
			
			var count: int = 0;
			
			var trexScore: Number = 0;
			var score: Number = 0;
			var initialScore: Number = 0;
			
			public function ARAS1_10_2( ) 
			{	trace("Running ARAS1");
				gotoAndStop( "mainMenu" );

				backBtn.addEventListener(MouseEvent.CLICK, backTo); 
				startBtn.addEventListener(MouseEvent.CLICK, openGame); 
				instruBtn.addEventListener(MouseEvent.CLICK, openInstru); 
				creditsBtn.addEventListener(MouseEvent.CLICK, openCredits); 
							
				timer.addEventListener(TimerEvent.TIMER, onTimer);
				
				openMenu( );				
			}
			
			function backTo( event: MouseEvent)
			{	openMenu( );
			}
			
			function openMenu( )
			{	trace("Menu");
				gotoAndStop( "mainMenu" );
				
				dino2.frontLeg.play( );
				dino2.backLeg.play( );
				trex2.frontTrex.play( );
				trex2.backTrex.play( );
				trace("Button Pressed");
				
				backBtn.addEventListener(MouseEvent.CLICK, backTo); 
				
				removeEventListener(Event.ENTER_FRAME, dodgeRocks); 
				removeEventListener(Event.ENTER_FRAME, moveRocks);
				
				startBtn.addEventListener(MouseEvent.CLICK, openGame); 
				instruBtn.addEventListener(MouseEvent.CLICK, openInstru);
				creditsBtn.addEventListener(MouseEvent.CLICK, openCredits); 
			}
	
			function openInstru( event: MouseEvent ) 
			{	trace("Instructions");
				gotoAndStop( "instruMenu" );
				dino3.frontLeg.play( );
				dino3.backLeg.play( );
				dino4.frontLeg.play( );
				dino4.backLeg.play( );
				
				backBtn.addEventListener(MouseEvent.CLICK, backTo); 
			}
			
			function openCredits( event: MouseEvent ) 
			{	trace("Credits");
				gotoAndStop( "creditsMenu" );
				backBtn.addEventListener(MouseEvent.CLICK, backTo); 
			}
			
			function openGame( event: MouseEvent ) 
			{	gotoAndStop( "gameplay" );
				trace("Game Started");
				dino.frontLeg.stop( );
				dino.backLeg.stop( );
	
				addEventListener(KeyboardEvent.KEY_DOWN, moveDino); 
				addEventListener(KeyboardEvent.KEY_UP, stopDino);
				
				addEventListener(Event.ENTER_FRAME, addRocks);
				addEventListener(Event.ENTER_FRAME, moveRocks); 
				addEventListener(Event.ENTER_FRAME, dodgeRocks);
				
				addEventListener(Event.ENTER_FRAME, scoreMaker);
				
				backBtn.addEventListener(MouseEvent.CLICK, backTo); 
			}
			
			function onTimer( evt: TimerEvent )
			{	dino.y = dino.y + 100;
				timer.stop( );
			}
						
			function moveDino( evt: KeyboardEvent ) 
			{	dino.frontLeg.play( );
				dino.backLeg.play( );
				
				if( evt.keyCode == Keyboard.RIGHT )  
				{	dino.x = dino.x + 5;
				}
				else if( evt.keyCode == Keyboard.UP)
				{	dino.y = dino.y - 100;
					timer.start( );
				}
				else if( evt.keyCode == Keyboard.LEFT)
				{	dino.x = dino.x - 1;
					dino.frontLeg.stop( );
					dino.backLeg.stop( );
				}
				else if( evt.keyCode == Keyboard.DOWN)
				{	dino.x = dino.x - 1;
					dino.frontLeg.stop( );
					dino.backLeg.stop( );
				}
			}
				
			function stopDino( evt: KeyboardEvent ) 
			{	if( evt.keyCode == Keyboard.RIGHT) 
				{	dino.x = dino.x - 1;
					dino.frontLeg.stop( );
					dino.backLeg.stop( );
				}
				else if( evt.keyCode == Keyboard.UP)
				{	dino.x = dino.x;
				}
				else if( evt.keyCode == Keyboard.LEFT)
				{	dino.x = dino.x;
					dino.frontLeg.stop( );
					dino.backLeg.stop( );
				}
				else if( evt.keyCode == Keyboard.DOWN)
				{	dino.x = dino.x;
					dino.frontLeg.stop( );
					dino.backLeg.stop( );
				}
			}			
			
			function addRocks( event: Event )
			{	if( count == 50 )
				{	var n: Number = Math.random( );
					trace("n= " + n)
					if( n <=0.50 )
					{	trace("Small Rock");
						smallRock.y = 335;
						smallRock.x = 550;
						addChildAt( smallRock , 1 ); 
						list.push( smallRock );
						n = 0;
					}
					else if( n <= 0.85)
					{	trace("Medium Rock");
						medRock.y = 345;
						medRock.x = 550;
						addChildAt( medRock , 1 ); 
						list.push( medRock );
						n = 0;
					}
					else if( n <= 0.99)
					{	trace("Large Rock")
						largeRock.y = 325;
						largeRock.x = 550;
						addChildAt( largeRock , 1 ); 
						list.push( largeRock );
						n = 0;
					}
					count = 0;
				}
				else
				{	count ++;
				}
			}
			
			function scoreMaker( event: Event )
			{	
				if (dino.hitTestObject( smallRock ))
				{ 	trace("Small Hit!" + dino.hitTestObject( smallRock ));
					trexScore += 10;
				}
				else if (dino.hitTestObject( medRock ))
				{ 	trace("Medium Hit!" + dino.hitTestObject( medRock ));
					trexScore += 10;
				}
				else if (dino.hitTestObject( largeRock ))
				{ 	trace("Large Hit!" + dino.hitTestObject( largeRock ));
					trexScore += 10;
				}
				else
				{	initialScore += 1;
				}
			}
			
			function totalScore ( score: int ) : int 
			{ 	return score = initialScore - trexScore ; 
			}
			
			function moveRocks(evt: Event)
			{	for( var i = 0; i < list.length; i++ )
				{	list[i].x = list[i].x - 2;
				}
			}  
			
			function dodgeRocks( evt: Event )
			{	if (dino.hitTestObject( trex ))
				{	gotoAndStop( "gameOver" );
					removeEventListener(Event.ENTER_FRAME, dodgeRocks);
					removeEventListener(Event.ENTER_FRAME, addRocks);
					removeEventListener(Event.ENTER_FRAME, moveRocks);
					removeEventListener(Event.ENTER_FRAME, moveDino);
					removeEventListener(Event.ENTER_FRAME, stopDino);
					
 					dinoBox.text = "Your Score:   " + totalScore( score );
					
					backBtn.addEventListener(MouseEvent.CLICK, backTo); 
				}	
			
				for( var rock: int = 0; rock < list.length; rock++)
				{
					if(dino.hitTestObject( list[rock] ))
					{	dino.x = dino.x - 5; 
					}
					else
					{	dino.x = dino.x;
					}
				}
			}
	}
	
}

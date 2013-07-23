﻿package  {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.TimerEvent;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.filesystem.File;	import flash.media.Camera;	import flash.media.Video;	import flash.utils.Timer;	import be.boulevart.events.FLVRecorderEvent;	import be.boulevart.video.FLVRecorder;	public class Main extends MovieClip {		private var tmr:Timer		private var recorder:FLVRecorder		private var file:File		private var fps:uint = 30;		private var video:Video = new Video(640, 480);		public function Main() {			var startButton:Sprite = new Sprite();				startButton.graphics.beginFill(0x00FF00, 1);				startButton.graphics.drawRect(0, 0, 100, 50);				startButton.graphics.endFill();				startButton.buttonMode = true;				startButton.mouseChildren = false;				startButton.x = 100;				startButton.y = 100;			this.addChild(startButton);			var stopButton:Sprite = new Sprite();				stopButton.graphics.beginFill(0x00FF00, 1);				stopButton.graphics.drawRect(0, 0, 100, 50);				stopButton.graphics.endFill();				stopButton.buttonMode = true;				stopButton.mouseChildren = false;				stopButton.x = 220;				stopButton.y = 100;			this.addChild(stopButton);			startButton.addEventListener(MouseEvent.CLICK, startRecording, false, 0, true);			stopButton.addEventListener(MouseEvent.CLICK, stopRecording, false, 0, true);			var camera:Camera = Camera.getCamera();			camera.setMode(640, 480, 30);			camera.setQuality(0, 50);			video.attachCamera(camera);			this.addChildAt(video,0);			file = File.desktopDirectory.resolvePath("recording.flv");			recorder = FLVRecorder.getInstance();			recorder.setTarget(file,640,480,fps,this.stage);			recorder.enableCompression = true;			tmr = new Timer(1000/fps);			tmr.addEventListener(TimerEvent.TIMER,record)			tmr.addEventListener(TimerEvent.TIMER_COMPLETE, stopRecording);		}		private function record(e:TimerEvent):void{			recorder.captureComponent(video);		}		protected function stopRecording(event:Event):void		{			trace('stop recording');			tmr.stop();			recorder.addEventListener(FLVRecorderEvent.FLV_CREATED, fileMade);			recorder.addEventListener(FLVRecorderEvent.FLV_START_CREATION, startCreatingFLV);			recorder.stopRecording();		}		private function startCreatingFLV(e:FLVRecorderEvent):void{			recorder.addEventListener(FLVRecorderEvent.PROGRESS, onFLVCreationProgress);		}				private function onFLVCreationProgress(e:FLVRecorderEvent):void{			trace("saving progress ", e.progress,1);		}		protected function startRecording(event:MouseEvent):void		{			trace('startRecording');			tmr.start();		}				protected function fileMade(event:Event):void		{			trace("file made");		}	}}
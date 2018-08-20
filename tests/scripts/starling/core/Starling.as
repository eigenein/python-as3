package starling.core
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage3D;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.ui.Multitouch;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import starling.animation.Juggler;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import starling.events.EventDispatcher;
   import starling.events.ResizeEvent;
   import starling.events.TouchProcessor;
   import starling.textures.TextureMemoryManager;
   import starling.utils.MouseMoveHandler;
   import starling.utils.SystemUtil;
   import starling.utils.execute;
   
   [Event(name="context3DCreate",type="starling.events.Event")]
   [Event(name="rootCreated",type="starling.events.Event")]
   [Event(name="fatalError",type="starling.events.Event")]
   public class Starling extends EventDispatcher
   {
      
      public static const VERSION:String = "1.6";
      
      private static const PROGRAM_DATA_NAME:String = "Starling.programs";
      
      private static var sCurrent:Starling;
      
      private static var sHandleLostContext:Boolean;
      
      private static var sContextData:Dictionary = new Dictionary(true);
      
      private static var sAll:Vector.<Starling> = new Vector.<Starling>(0);
       
      
      private var mStage3D:Stage3D;
      
      private var mStage:starling.display.Stage;
      
      private var mRootClass:Class;
      
      private var mRoot:DisplayObject;
      
      private var mJuggler:Juggler;
      
      private var mSupport:RenderSupport;
      
      private var mTouchProcessor:TouchProcessor;
      
      private var mAntiAliasing:int;
      
      private var mSimulateMultitouch:Boolean;
      
      private var mEnableErrorChecking:Boolean;
      
      private var mLastFrameTimestamp:Number;
      
      private var mLeftMouseDown:Boolean;
      
      private var mStatsDisplay:StatsDisplay;
      
      private var mShareContext:Boolean;
      
      private var mProfile:String;
      
      private var mContext:Context3D;
      
      private var mStarted:Boolean;
      
      private var mRendering:Boolean;
      
      private var mSupportHighResolutions:Boolean;
      
      private var mViewPort:Rectangle;
      
      private var mPreviousViewPort:Rectangle;
      
      private var mClippedViewPort:Rectangle;
      
      private var mNativeStage:flash.display.Stage;
      
      private var mNativeOverlay:Sprite;
      
      private var mNativeStageContentScaleFactor:Number;
      
      private var mouseMoveHandler:MouseMoveHandler;
      
      public function Starling(param1:Class, param2:flash.display.Stage, param3:Rectangle = null, param4:Stage3D = null, param5:String = "auto", param6:Object = "baselineConstrained")
      {
         super();
         if(param2 == null)
         {
            throw new ArgumentError("Stage must not be null");
         }
         if(param1 == null)
         {
            throw new ArgumentError("Root class must not be null");
         }
         if(param3 == null)
         {
            param3 = new Rectangle(0,0,param2.stageWidth,param2.stageHeight);
         }
         if(param4 == null)
         {
            param4 = param2.stage3Ds[0];
         }
         SystemUtil.initialize();
         sAll.push(this);
         makeCurrent();
         mRootClass = param1;
         mViewPort = param3;
         mPreviousViewPort = new Rectangle();
         mStage3D = param4;
         mStage = new starling.display.Stage(param3.width,param3.height,param2.color);
         mNativeOverlay = new Sprite();
         mNativeStage = param2;
         mNativeStage.addChild(mNativeOverlay);
         mNativeStageContentScaleFactor = 1;
         mTouchProcessor = new TouchProcessor(mStage);
         mJuggler = new Juggler();
         mAntiAliasing = 0;
         mSimulateMultitouch = false;
         mEnableErrorChecking = false;
         mSupportHighResolutions = false;
         mLastFrameTimestamp = getTimer() / 1000;
         mSupport = new RenderSupport();
         mouseMoveHandler = new MouseMoveHandler(mTouchProcessor);
         sContextData[param4] = new Dictionary();
         sContextData[param4]["Starling.programs"] = new Dictionary();
         param2.scaleMode = "noScale";
         param2.align = "TL";
         var _loc9_:int = 0;
         var _loc8_:* = touchEventTypes;
         for each(var _loc7_ in touchEventTypes)
         {
            param2.addEventListener(_loc7_,onTouch,false,0,true);
         }
         param2.addEventListener("enterFrame",onEnterFrame,false,0,true);
         param2.addEventListener("render",onRender,false,0,true);
         param2.addEventListener("keyDown",onKey,false,0,true);
         param2.addEventListener("keyUp",onKey,false,0,true);
         param2.addEventListener("resize",onResize,false,0,true);
         param2.addEventListener("mouseLeave",onMouseLeave,false,0,true);
         mStage3D.addEventListener("context3DCreate",onContextCreated,false,10,true);
         mStage3D.addEventListener("error",onStage3DError,false,10,true);
         if(mStage3D.context3D && mStage3D.context3D.driverInfo != "Disposed")
         {
            if(param6 == "auto" || param6 is Array)
            {
               throw new ArgumentError("When sharing the context3D, the actual profile has to be supplied");
            }
            mProfile = "profile" in mStage3D.context3D?mStage3D.context3D["profile"]:param6 as String;
            mShareContext = true;
            setTimeout(initialize,1);
         }
         else
         {
            mShareContext = false;
            requestContext3D(param4,param5,param6);
         }
      }
      
      public static function get current() : Starling
      {
         return sCurrent;
      }
      
      public static function get all() : Vector.<Starling>
      {
         return sAll;
      }
      
      public static function get context() : Context3D
      {
         return !!sCurrent?sCurrent.contextInstance:null;
      }
      
      public static function get juggler() : Juggler
      {
         return !!sCurrent?sCurrent.jugglerInstance:null;
      }
      
      public static function get contentScaleFactor() : Number
      {
         return !!sCurrent?sCurrent.contentScaleFactorInstance:1;
      }
      
      public static function get multitouchEnabled() : Boolean
      {
         return Multitouch.inputMode == "touchPoint";
      }
      
      public static function set multitouchEnabled(param1:Boolean) : void
      {
         if(sCurrent)
         {
            throw new IllegalOperationError("\'multitouchEnabled\' must be set before Starling instance is created");
         }
         Multitouch.inputMode = !!param1?"touchPoint":"none";
      }
      
      public static function get handleLostContext() : Boolean
      {
         return sHandleLostContext;
      }
      
      public static function set handleLostContext(param1:Boolean) : void
      {
         if(sCurrent)
         {
            throw new IllegalOperationError("\'handleLostContext\' must be set before Starling instance is created");
         }
         sHandleLostContext = param1;
      }
      
      public function dispose() : void
      {
         stop(true);
         mNativeStage.removeEventListener("enterFrame",onEnterFrame,false);
         mNativeStage.removeEventListener("render",onRender,false);
         mNativeStage.removeEventListener("keyDown",onKey,false);
         mNativeStage.removeEventListener("keyUp",onKey,false);
         mNativeStage.removeEventListener("resize",onResize,false);
         mNativeStage.removeEventListener("mouseLeave",onMouseLeave,false);
         mNativeStage.removeChild(mNativeOverlay);
         mStage3D.removeEventListener("context3DCreate",onContextCreated,false);
         mStage3D.removeEventListener("error",onStage3DError,false);
         var _loc4_:int = 0;
         var _loc3_:* = touchEventTypes;
         for each(var _loc2_ in touchEventTypes)
         {
            mNativeStage.removeEventListener(_loc2_,onTouch,false);
         }
         if(mStage)
         {
            mStage.dispose();
         }
         if(mSupport)
         {
            mSupport.dispose();
         }
         if(mTouchProcessor)
         {
            mTouchProcessor.dispose();
         }
         if(sCurrent == this)
         {
            sCurrent = null;
         }
         if(mContext && !mShareContext)
         {
            execute(mContext.dispose,false);
         }
         var _loc1_:int = sAll.indexOf(this);
         if(_loc1_ != -1)
         {
            sAll.splice(_loc1_,1);
         }
      }
      
      private function requestContext3D(param1:Stage3D, param2:String, param3:Object) : void
      {
         stage3D = param1;
         renderMode = param2;
         profile = param3;
         if(profile == "auto")
         {
            var profiles:Array = ["standard","baselineExtended","baseline","baselineConstrained"];
         }
         else if(profile is String)
         {
            profiles = [profile as String];
         }
         else if(profile is Array)
         {
            profiles = profile as Array;
         }
         else
         {
            throw new ArgumentError("Profile must be of type \'String\' or \'Array\'");
         }
         var requestNextProfile:Function = function():void
         {
            currentProfile = profiles.shift();
            try
            {
               execute(mStage3D.requestContext3D,renderMode,currentProfile);
               return;
            }
            catch(error:Error)
            {
               if(profiles.length != 0)
               {
                  setTimeout(requestNextProfile,1);
               }
               else
               {
                  throw error;
               }
               return;
            }
         };
         var onCreated:Function = function(param1:Event):void
         {
            var _loc2_:Context3D = stage3D.context3D;
            if(renderMode == "auto" && profiles.length != 0 && _loc2_.driverInfo.indexOf("Software") != -1)
            {
               onError(param1);
            }
            else
            {
               mProfile = currentProfile;
               onFinished();
            }
         };
         var onError:Function = function(param1:Event):void
         {
            if(profiles.length != 0)
            {
               param1.stopImmediatePropagation();
               setTimeout(requestNextProfile,1);
            }
            else
            {
               onFinished();
            }
         };
         var onFinished:Function = function():void
         {
            mStage3D.removeEventListener("context3DCreate",onCreated);
            mStage3D.removeEventListener("error",onError);
         };
         mStage3D.addEventListener("context3DCreate",onCreated,false,100);
         mStage3D.addEventListener("error",onError,false,100);
      }
      
      private function initialize() : void
      {
         makeCurrent();
         initializeGraphicsAPI();
         initializeRoot();
         mTouchProcessor.simulateMultitouch = mSimulateMultitouch;
         mLastFrameTimestamp = getTimer() / 1000;
      }
      
      private function initializeGraphicsAPI() : void
      {
         mContext = mStage3D.context3D;
         mContext.enableErrorChecking = mEnableErrorChecking;
         contextData["Starling.programs"] = new Dictionary();
         trace("[Starling] Initialization complete.");
         trace("[Starling] Display Driver:",mContext.driverInfo);
         updateViewPort(true);
         dispatchEventWith("context3DCreate",false,mContext);
      }
      
      private function initializeRoot() : void
      {
         if(mRoot == null)
         {
            mRoot = new mRootClass() as DisplayObject;
            if(mRoot == null)
            {
               throw new Error("Invalid root class: " + mRootClass);
            }
            mStage.addChildAt(mRoot,0);
            dispatchEventWith("rootCreated",false,mRoot);
         }
      }
      
      public function nextFrame() : void
      {
         var _loc1_:Number = getTimer() / 1000;
         var _loc2_:* = Number(_loc1_ - mLastFrameTimestamp);
         mLastFrameTimestamp = _loc1_;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         advanceTime(_loc2_);
         render();
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(!contextValid)
         {
            return;
         }
         makeCurrent();
         if(mStarted && mouseMoveHandler.enabled)
         {
            mouseMoveHandler.advanceTime(mNativeStage,mStage,mViewPort,mLeftMouseDown);
         }
         mTouchProcessor.advanceTime(param1);
         mStage.advanceTime(param1);
         mJuggler.advanceTime(param1);
      }
      
      public function render() : void
      {
         if(!contextValid)
         {
            return;
         }
         makeCurrent();
         updateViewPort();
         mSupport.nextFrame();
         var _loc1_:Number = mViewPort.width / mStage.stageWidth;
         var _loc2_:Number = mViewPort.height / mStage.stageHeight;
         mContext.setDepthTest(false,"always");
         mContext.setCulling("none");
         mSupport.renderTarget = null;
         mSupport.setProjectionMatrix(mViewPort.x < 0?-mViewPort.x / _loc1_:0,mViewPort.y < 0?-mViewPort.y / _loc2_:0,mClippedViewPort.width / _loc1_,mClippedViewPort.height / _loc2_,mStage.stageWidth,mStage.stageHeight,mStage.cameraPosition);
         if(!mShareContext)
         {
            RenderSupport.clear(mStage.color,1);
         }
         mStage.render(mSupport,1);
         mSupport.finishQuadBatch();
         mSupport.finishByteQuadBatch();
         if(mStatsDisplay)
         {
            mStatsDisplay.drawCount = mSupport.drawCount;
         }
         if(!mShareContext)
         {
            mContext.present();
         }
      }
      
      private function updateViewPort(param1:Boolean = false) : void
      {
         if(param1 || mPreviousViewPort.width != mViewPort.width || mPreviousViewPort.height != mViewPort.height || mPreviousViewPort.x != mViewPort.x || mPreviousViewPort.y != mViewPort.y)
         {
            mPreviousViewPort.setTo(mViewPort.x,mViewPort.y,mViewPort.width,mViewPort.height);
            mClippedViewPort = mViewPort.intersection(new Rectangle(0,0,mNativeStage.stageWidth,mNativeStage.stageHeight));
            if(!mShareContext)
            {
               if(mProfile == "baselineConstrained")
               {
                  configureBackBuffer(32,32,mAntiAliasing,false);
               }
               mStage3D.x = mClippedViewPort.x;
               mStage3D.y = mClippedViewPort.y;
               if(mClippedViewPort.width > 0 && mClippedViewPort.height > 0)
               {
                  configureBackBuffer(mClippedViewPort.width,mClippedViewPort.height,mAntiAliasing,false,mSupportHighResolutions);
               }
               if(mSupportHighResolutions && "contentsScaleFactor" in mNativeStage)
               {
                  mNativeStageContentScaleFactor = mNativeStage["contentsScaleFactor"];
               }
               else
               {
                  mNativeStageContentScaleFactor = 1;
               }
            }
         }
      }
      
      private function configureBackBuffer(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean = false) : void
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         try
         {
            _loc7_ = mContext.configureBackBuffer;
            _loc6_ = [param1,param2,param3,param4];
            if(_loc7_.length > 4)
            {
               _loc6_.push(param5);
            }
            _loc7_.apply(mContext,_loc6_);
            return;
         }
         catch(e:Error)
         {
            if(e.errorID == 3669)
            {
               TextureMemoryManager.signal_error.dispatch(3669,param1 + "x" + param2 + " " + mProfile + " shareContext:" + (!!mShareContext?1:0) + " antiAlias:" + param3 + " enableDepthAndStencil:" + (!!param4?1:0) + " wantsBestResolution:" + (!!param5?1:0));
            }
            else
            {
               throw e;
            }
            return;
         }
      }
      
      private function updateNativeOverlay() : void
      {
         mNativeOverlay.x = mViewPort.x;
         mNativeOverlay.y = mViewPort.y;
         mNativeOverlay.scaleX = mViewPort.width / mStage.stageWidth;
         mNativeOverlay.scaleY = mViewPort.height / mStage.stageHeight;
      }
      
      public function stopWithFatalError(param1:String) : void
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0,0.8);
         _loc2_.graphics.drawRect(0,0,mStage.stageWidth,mStage.stageHeight);
         _loc2_.graphics.endFill();
         var _loc3_:TextField = new TextField();
         var _loc4_:TextFormat = new TextFormat("Verdana",14,16777215);
         _loc4_.align = "center";
         _loc3_.defaultTextFormat = _loc4_;
         _loc3_.wordWrap = true;
         _loc3_.width = mStage.stageWidth * 0.75;
         _loc3_.autoSize = "center";
         _loc3_.text = param1;
         _loc3_.x = (mStage.stageWidth - _loc3_.width) / 2;
         _loc3_.y = (mStage.stageHeight - _loc3_.height) / 2;
         _loc3_.background = true;
         _loc3_.backgroundColor = 5570560;
         updateNativeOverlay();
         nativeOverlay.addChild(_loc2_);
         nativeOverlay.addChild(_loc3_);
         stop(true);
         trace("[Starling]",param1);
         dispatchEventWith("fatalError",false,param1);
      }
      
      public function makeCurrent() : void
      {
         sCurrent = this;
      }
      
      public function start() : void
      {
         mRendering = true;
         mStarted = true;
         mLastFrameTimestamp = getTimer() / 1000;
      }
      
      public function stop(param1:Boolean = false) : void
      {
         mStarted = false;
         mRendering = !param1;
      }
      
      private function onStage3DError(param1:ErrorEvent) : void
      {
         var _loc2_:* = null;
         if(param1.errorID == 3702)
         {
            _loc2_ = Capabilities.playerType == "Desktop"?"renderMode":"wmode";
            stopWithFatalError("Context3D not available! Possible reasons: wrong " + _loc2_ + " or missing device support.");
         }
         else
         {
            stopWithFatalError("Stage3D error: " + param1.text);
         }
      }
      
      private function onContextCreated(param1:Event) : void
      {
         if(!Starling.handleLostContext && mContext)
         {
            param1.stopImmediatePropagation();
            stopWithFatalError("The application lost the device context!");
            trace("[Starling] Enable \'Starling.handleLostContext\' to avoid this error.");
         }
         else
         {
            initialize();
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         nativeStage.invalidate();
         var _loc2_:Boolean = true;
         _loc2_ = false;
         var _loc3_:Number = getTimer() / 1000;
         var _loc4_:Number = _loc3_ - mLastFrameTimestamp;
         if(_loc4_ > 1)
         {
            nextFrame();
         }
         if(_loc2_)
         {
            nextFrame();
         }
      }
      
      private function onRender(param1:Event) : void
      {
         if(!mShareContext)
         {
            if(mStarted)
            {
               nextFrame();
            }
            else if(mRendering)
            {
               render();
            }
         }
         updateNativeOverlay();
      }
      
      private function onKey(param1:flash.events.KeyboardEvent) : void
      {
         if(!mStarted)
         {
            return;
         }
         var _loc2_:starling.events.KeyboardEvent = new starling.events.KeyboardEvent(param1.type,param1.charCode,param1.keyCode,param1.keyLocation,param1.ctrlKey,param1.altKey,param1.shiftKey);
         makeCurrent();
         mStage.broadcastEvent(_loc2_);
         if(_loc2_.isDefaultPrevented())
         {
            param1.preventDefault();
         }
      }
      
      private function onResize(param1:Event) : void
      {
         event = param1;
         dispatchResizeEvent = function():void
         {
            makeCurrent();
            removeEventListener("context3DCreate",dispatchResizeEvent);
            mStage.dispatchEvent(new ResizeEvent("resize",stageWidth,stageHeight));
         };
         var stage:flash.display.Stage = event.target as flash.display.Stage;
         var stageWidth:int = stage.stageWidth;
         var stageHeight:int = stage.stageHeight;
         if(contextValid)
         {
            dispatchResizeEvent();
         }
         else
         {
            addEventListener("context3DCreate",dispatchResizeEvent);
         }
      }
      
      private function onMouseLeave(param1:Event) : void
      {
         mTouchProcessor.enqueueMouseLeftStage();
      }
      
      private function onTouch(param1:Event) : void
      {
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc8_:* = null;
         if(!mStarted)
         {
            return;
         }
         var _loc2_:String = null;
         var _loc9_:* = 1;
         var _loc7_:* = 1;
         var _loc10_:* = 1;
         if(param1 is MouseEvent)
         {
            _loc4_ = param1 as MouseEvent;
            _loc5_ = _loc4_.stageX;
            _loc3_ = _loc4_.stageY;
            _loc6_ = 0;
            if(param1.type == "mouseDown")
            {
               mLeftMouseDown = true;
            }
            else if(param1.type == "mouseUp")
            {
               mLeftMouseDown = false;
            }
         }
         else
         {
            _loc8_ = param1 as TouchEvent;
            if(Mouse.supportsCursor && _loc8_.isPrimaryTouchPoint)
            {
               return;
            }
            _loc5_ = _loc8_.stageX;
            _loc3_ = _loc8_.stageY;
            _loc6_ = _loc8_.touchPointID;
            _loc9_ = Number(_loc8_.pressure);
            _loc7_ = Number(_loc8_.sizeX);
            _loc10_ = Number(_loc8_.sizeY);
         }
         var _loc11_:* = param1.type;
         if("touchBegin" !== _loc11_)
         {
            if("touchMove" !== _loc11_)
            {
               if("touchEnd" !== _loc11_)
               {
                  if("mouseDown" !== _loc11_)
                  {
                     if("mouseUp" !== _loc11_)
                     {
                        if("mouseMove" === _loc11_)
                        {
                           mouseMoveHandler.enabled = false;
                           _loc2_ = !!mLeftMouseDown?"moved":"hover";
                        }
                     }
                     else
                     {
                        _loc2_ = "ended";
                     }
                  }
                  else
                  {
                     _loc2_ = "began";
                  }
               }
               else
               {
                  _loc2_ = "ended";
               }
            }
            else
            {
               _loc2_ = "moved";
            }
         }
         else
         {
            _loc2_ = "began";
         }
         _loc5_ = mStage.stageWidth * (_loc5_ - mViewPort.x) / mViewPort.width;
         _loc3_ = mStage.stageHeight * (_loc3_ - mViewPort.y) / mViewPort.height;
         mTouchProcessor.enqueue(_loc6_,_loc2_,_loc5_,_loc3_,_loc9_,_loc7_,_loc10_);
         if(param1.type == "mouseUp")
         {
            mTouchProcessor.enqueue(_loc6_,"hover",_loc5_,_loc3_);
         }
      }
      
      private function get touchEventTypes() : Array
      {
         var _loc1_:Array = [];
         if(multitouchEnabled)
         {
            _loc1_.push("touchBegin","touchMove","touchEnd");
         }
         if(!multitouchEnabled || Mouse.supportsCursor)
         {
            _loc1_.push("mouseDown","mouseMove","mouseUp");
         }
         return _loc1_;
      }
      
      public function registerProgram(param1:String, param2:ByteArray, param3:ByteArray) : Program3D
      {
         deleteProgram(param1);
         var _loc4_:Program3D = mContext.createProgram();
         _loc4_.upload(param2,param3);
         programs[param1] = _loc4_;
         return _loc4_;
      }
      
      public function registerProgramFromSource(param1:String, param2:String, param3:String) : Program3D
      {
         deleteProgram(param1);
         var _loc4_:Program3D = RenderSupport.assembleAgal(param2,param3);
         programs[param1] = _loc4_;
         return _loc4_;
      }
      
      public function deleteProgram(param1:String) : void
      {
         var _loc2_:Program3D = getProgram(param1);
         if(_loc2_)
         {
            _loc2_.dispose();
            delete programs[param1];
         }
      }
      
      public function getProgram(param1:String) : Program3D
      {
         return programs[param1] as Program3D;
      }
      
      public function hasProgram(param1:String) : Boolean
      {
         return param1 in programs;
      }
      
      private function get programs() : Dictionary
      {
         return contextData["Starling.programs"];
      }
      
      public function get isStarted() : Boolean
      {
         return mStarted;
      }
      
      public function get jugglerInstance() : Juggler
      {
         return mJuggler;
      }
      
      public function get contextInstance() : Context3D
      {
         return mContext;
      }
      
      public function get contextData() : Dictionary
      {
         return sContextData[mStage3D] as Dictionary;
      }
      
      public function get backBufferWidth() : int
      {
         return mClippedViewPort.width;
      }
      
      public function get backBufferHeight() : int
      {
         return mClippedViewPort.height;
      }
      
      public function get backBufferPixelsPerPoint() : int
      {
         return mNativeStageContentScaleFactor;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return mSimulateMultitouch;
      }
      
      public function set simulateMultitouch(param1:Boolean) : void
      {
         mSimulateMultitouch = param1;
         if(mContext)
         {
            mTouchProcessor.simulateMultitouch = param1;
         }
      }
      
      public function get enableErrorChecking() : Boolean
      {
         return mEnableErrorChecking;
      }
      
      public function set enableErrorChecking(param1:Boolean) : void
      {
         mEnableErrorChecking = param1;
         if(mContext)
         {
            mContext.enableErrorChecking = param1;
         }
      }
      
      public function get antiAliasing() : int
      {
         return mAntiAliasing;
      }
      
      public function set antiAliasing(param1:int) : void
      {
         if(mAntiAliasing != param1)
         {
            mAntiAliasing = param1;
            if(contextValid)
            {
               updateViewPort(true);
            }
         }
      }
      
      public function get viewPort() : Rectangle
      {
         return mViewPort;
      }
      
      public function set viewPort(param1:Rectangle) : void
      {
         mViewPort = param1.clone();
      }
      
      public function get contentScaleFactorInstance() : Number
      {
         return mViewPort.width * mNativeStageContentScaleFactor / mStage.stageWidth;
      }
      
      public function get nativeOverlay() : Sprite
      {
         return mNativeOverlay;
      }
      
      public function get showStats() : Boolean
      {
         return mStatsDisplay && mStatsDisplay.parent;
      }
      
      public function set showStats(param1:Boolean) : void
      {
         if(param1 == showStats)
         {
            return;
         }
         if(param1)
         {
            if(mStatsDisplay)
            {
               mStage.addChild(mStatsDisplay);
            }
            else
            {
               showStatsAt();
            }
         }
         else
         {
            mStatsDisplay.removeFromParent();
         }
      }
      
      public function showStatsAt(param1:String = "left", param2:String = "top", param3:Number = 1) : void
      {
         hAlign = param1;
         vAlign = param2;
         scale = param3;
         onRootCreated = function():void
         {
            showStatsAt(hAlign,vAlign,scale);
            removeEventListener("rootCreated",onRootCreated);
         };
         if(mContext == null)
         {
            addEventListener("rootCreated",onRootCreated);
         }
         else
         {
            if(mStatsDisplay == null)
            {
               mStatsDisplay = new StatsDisplay();
               mStatsDisplay.touchable = false;
               mStage.addChild(mStatsDisplay);
            }
            var stageWidth:int = mStage.stageWidth;
            var stageHeight:int = mStage.stageHeight;
            var _loc5_:* = scale;
            mStatsDisplay.scaleY = _loc5_;
            mStatsDisplay.scaleX = _loc5_;
            if(hAlign == "left")
            {
               mStatsDisplay.x = 0;
            }
            else if(hAlign == "right")
            {
               mStatsDisplay.x = stageWidth - mStatsDisplay.width;
            }
            else
            {
               mStatsDisplay.x = int((stageWidth - mStatsDisplay.width) / 2);
            }
            if(vAlign == "top")
            {
               mStatsDisplay.y = 0;
            }
            else if(vAlign == "bottom")
            {
               mStatsDisplay.y = stageHeight - mStatsDisplay.height;
            }
            else
            {
               mStatsDisplay.y = int((stageHeight - mStatsDisplay.height) / 2);
            }
         }
      }
      
      public function get stage() : starling.display.Stage
      {
         return mStage;
      }
      
      public function get stage3D() : Stage3D
      {
         return mStage3D;
      }
      
      public function get nativeStage() : flash.display.Stage
      {
         return mNativeStage;
      }
      
      public function get root() : DisplayObject
      {
         return mRoot;
      }
      
      public function get shareContext() : Boolean
      {
         return mShareContext;
      }
      
      public function set shareContext(param1:Boolean) : void
      {
         mShareContext = param1;
      }
      
      public function get profile() : String
      {
         return mProfile;
      }
      
      public function get supportHighResolutions() : Boolean
      {
         return mSupportHighResolutions;
      }
      
      public function set supportHighResolutions(param1:Boolean) : void
      {
         if(mSupportHighResolutions != param1)
         {
            mSupportHighResolutions = param1;
            if(contextValid)
            {
               updateViewPort(true);
            }
         }
      }
      
      public function get touchProcessor() : TouchProcessor
      {
         return mTouchProcessor;
      }
      
      public function set touchProcessor(param1:TouchProcessor) : void
      {
         if(param1 != mTouchProcessor)
         {
            mTouchProcessor.dispose();
            mTouchProcessor = param1;
         }
      }
      
      public function get contextValid() : Boolean
      {
         return mContext && mContext.driverInfo != "Disposed";
      }
   }
}

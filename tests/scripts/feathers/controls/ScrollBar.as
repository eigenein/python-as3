package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.PropertyProxy;
   import feathers.skins.IStyleProvider;
   import feathers.utils.math.clamp;
   import feathers.utils.math.roundToNearest;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   [Event(name="change",type="starling.events.Event")]
   [Event(name="beginInteraction",type="starling.events.Event")]
   [Event(name="endInteraction",type="starling.events.Event")]
   public class ScrollBar extends FeathersControl implements IDirectionalScrollBar
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      protected static const INVALIDATION_FLAG_THUMB_FACTORY:String = "thumbFactory";
      
      protected static const INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY:String = "minimumTrackFactory";
      
      protected static const INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY:String = "maximumTrackFactory";
      
      protected static const INVALIDATION_FLAG_DECREMENT_BUTTON_FACTORY:String = "decrementButtonFactory";
      
      protected static const INVALIDATION_FLAG_INCREMENT_BUTTON_FACTORY:String = "incrementButtonFactory";
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
      
      public static const TRACK_LAYOUT_MODE_SINGLE:String = "single";
      
      public static const TRACK_LAYOUT_MODE_MIN_MAX:String = "minMax";
      
      public static const DEFAULT_CHILD_NAME_MINIMUM_TRACK:String = "feathers-scroll-bar-minimum-track";
      
      public static const DEFAULT_CHILD_NAME_MAXIMUM_TRACK:String = "feathers-scroll-bar-maximum-track";
      
      public static const DEFAULT_CHILD_NAME_THUMB:String = "feathers-scroll-bar-thumb";
      
      public static const DEFAULT_CHILD_NAME_DECREMENT_BUTTON:String = "feathers-scroll-bar-decrement-button";
      
      public static const DEFAULT_CHILD_NAME_INCREMENT_BUTTON:String = "feathers-scroll-bar-increment-button";
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var minimumTrackName:String = "feathers-scroll-bar-minimum-track";
      
      protected var maximumTrackName:String = "feathers-scroll-bar-maximum-track";
      
      protected var thumbName:String = "feathers-scroll-bar-thumb";
      
      protected var decrementButtonName:String = "feathers-scroll-bar-decrement-button";
      
      protected var incrementButtonName:String = "feathers-scroll-bar-increment-button";
      
      protected var thumbOriginalWidth:Number = NaN;
      
      protected var thumbOriginalHeight:Number = NaN;
      
      protected var minimumTrackOriginalWidth:Number = NaN;
      
      protected var minimumTrackOriginalHeight:Number = NaN;
      
      protected var maximumTrackOriginalWidth:Number = NaN;
      
      protected var maximumTrackOriginalHeight:Number = NaN;
      
      protected var decrementButton:Button;
      
      protected var incrementButton:Button;
      
      protected var thumb:Button;
      
      protected var minimumTrack:Button;
      
      protected var maximumTrack:Button;
      
      protected var _direction:String = "horizontal";
      
      protected var _value:Number = 0;
      
      protected var _minimum:Number = 0;
      
      protected var _maximum:Number = 0;
      
      protected var _step:Number = 0;
      
      protected var _page:Number = 0;
      
      protected var _paddingTop:Number = 0;
      
      protected var _paddingRight:Number = 0;
      
      protected var _paddingBottom:Number = 0;
      
      protected var _paddingLeft:Number = 0;
      
      protected var currentRepeatAction:Function;
      
      protected var _repeatTimer:Timer;
      
      protected var _repeatDelay:Number = 0.05;
      
      protected var isDragging:Boolean = false;
      
      public var liveDragging:Boolean = true;
      
      protected var _trackLayoutMode:String = "single";
      
      protected var _minimumTrackFactory:Function;
      
      protected var _customMinimumTrackName:String;
      
      protected var _minimumTrackProperties:PropertyProxy;
      
      protected var _maximumTrackFactory:Function;
      
      protected var _customMaximumTrackName:String;
      
      protected var _maximumTrackProperties:PropertyProxy;
      
      protected var _thumbFactory:Function;
      
      protected var _customThumbName:String;
      
      protected var _thumbProperties:PropertyProxy;
      
      protected var _decrementButtonFactory:Function;
      
      protected var _customDecrementButtonName:String;
      
      protected var _decrementButtonProperties:PropertyProxy;
      
      protected var _incrementButtonFactory:Function;
      
      protected var _customIncrementButtonName:String;
      
      protected var _incrementButtonProperties:PropertyProxy;
      
      protected var _touchPointID:int = -1;
      
      protected var _touchStartX:Number = NaN;
      
      protected var _touchStartY:Number = NaN;
      
      protected var _thumbStartX:Number = NaN;
      
      protected var _thumbStartY:Number = NaN;
      
      protected var _touchValue:Number;
      
      public function ScrollBar()
      {
         super();
         this.addEventListener("removedFromStage",removedFromStageHandler);
      }
      
      protected static function defaultThumbFactory() : Button
      {
         return new Button();
      }
      
      protected static function defaultMinimumTrackFactory() : Button
      {
         return new Button();
      }
      
      protected static function defaultMaximumTrackFactory() : Button
      {
         return new Button();
      }
      
      protected static function defaultDecrementButtonFactory() : Button
      {
         return new Button();
      }
      
      protected static function defaultIncrementButtonFactory() : Button
      {
         return new Button();
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return ScrollBar.globalStyleProvider;
      }
      
      [Inspectable(type="String",enumeration="horizontal,vertical")]
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         if(this._direction == param1)
         {
            return;
         }
         this._direction = param1;
         this.invalidate("data");
         this.invalidate("decrementButtonFactory");
         this.invalidate("incrementButtonFactory");
         this.invalidate("minimumTrackFactory");
         this.invalidate("maximumTrackFactory");
         this.invalidate("thumbFactory");
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         param1 = clamp(param1,this._minimum,this._maximum);
         if(this._value == param1)
         {
            return;
         }
         this._value = param1;
         this.invalidate("data");
         if(this.liveDragging || !this.isDragging)
         {
            this.dispatchEventWith("change");
         }
      }
      
      public function get minimum() : Number
      {
         return this._minimum;
      }
      
      public function set minimum(param1:Number) : void
      {
         if(this._minimum == param1)
         {
            return;
         }
         this._minimum = param1;
         this.invalidate("data");
      }
      
      public function get maximum() : Number
      {
         return this._maximum;
      }
      
      public function set maximum(param1:Number) : void
      {
         if(this._maximum == param1)
         {
            return;
         }
         this._maximum = param1;
         this.invalidate("data");
      }
      
      public function get step() : Number
      {
         return this._step;
      }
      
      public function set step(param1:Number) : void
      {
         this._step = param1;
      }
      
      public function get page() : Number
      {
         return this._page;
      }
      
      public function set page(param1:Number) : void
      {
         if(this._page == param1)
         {
            return;
         }
         this._page = param1;
         this.invalidate("data");
      }
      
      public function get padding() : Number
      {
         return this._paddingTop;
      }
      
      public function set padding(param1:Number) : void
      {
         this.paddingTop = param1;
         this.paddingRight = param1;
         this.paddingBottom = param1;
         this.paddingLeft = param1;
      }
      
      public function get paddingTop() : Number
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         if(this._paddingTop == param1)
         {
            return;
         }
         this._paddingTop = param1;
         this.invalidate("styles");
      }
      
      public function get paddingRight() : Number
      {
         return this._paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         if(this._paddingRight == param1)
         {
            return;
         }
         this._paddingRight = param1;
         this.invalidate("styles");
      }
      
      public function get paddingBottom() : Number
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         if(this._paddingBottom == param1)
         {
            return;
         }
         this._paddingBottom = param1;
         this.invalidate("styles");
      }
      
      public function get paddingLeft() : Number
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         if(this._paddingLeft == param1)
         {
            return;
         }
         this._paddingLeft = param1;
         this.invalidate("styles");
      }
      
      public function get repeatDelay() : Number
      {
         return this._repeatDelay;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         if(this._repeatDelay == param1)
         {
            return;
         }
         this._repeatDelay = param1;
         this.invalidate("styles");
      }
      
      [Inspectable(type="String",enumeration="single,minMax")]
      public function get trackLayoutMode() : String
      {
         return this._trackLayoutMode;
      }
      
      public function set trackLayoutMode(param1:String) : void
      {
         if(this._trackLayoutMode == param1)
         {
            return;
         }
         this._trackLayoutMode = param1;
         this.invalidate("layout");
      }
      
      public function get minimumTrackFactory() : Function
      {
         return this._minimumTrackFactory;
      }
      
      public function set minimumTrackFactory(param1:Function) : void
      {
         if(this._minimumTrackFactory == param1)
         {
            return;
         }
         this._minimumTrackFactory = param1;
         this.invalidate("minimumTrackFactory");
      }
      
      public function get customMinimumTrackName() : String
      {
         return this._customMinimumTrackName;
      }
      
      public function set customMinimumTrackName(param1:String) : void
      {
         if(this._customMinimumTrackName == param1)
         {
            return;
         }
         this._customMinimumTrackName = param1;
         this.invalidate("minimumTrackFactory");
      }
      
      public function get minimumTrackProperties() : Object
      {
         if(!this._minimumTrackProperties)
         {
            this._minimumTrackProperties = PropertyProxy.fromEmpty(minimumTrackProperties_onChange);
         }
         return this._minimumTrackProperties;
      }
      
      public function set minimumTrackProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._minimumTrackProperties == param1)
         {
            return;
         }
         if(!param1)
         {
            param1 = PropertyProxy.fromEmpty();
         }
         if(!PropertyProxy.isInstance(param1))
         {
            _loc2_ = PropertyProxy.fromEmpty();
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
            param1 = _loc2_;
         }
         if(this._minimumTrackProperties)
         {
            this._minimumTrackProperties.removeOnChangeCallback(minimumTrackProperties_onChange);
         }
         this._minimumTrackProperties = PropertyProxy.asInstance(param1);
         if(this._minimumTrackProperties)
         {
            this._minimumTrackProperties.addOnChangeCallback(minimumTrackProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get maximumTrackFactory() : Function
      {
         return this._maximumTrackFactory;
      }
      
      public function set maximumTrackFactory(param1:Function) : void
      {
         if(this._maximumTrackFactory == param1)
         {
            return;
         }
         this._maximumTrackFactory = param1;
         this.invalidate("maximumTrackFactory");
      }
      
      public function get customMaximumTrackName() : String
      {
         return this._customMaximumTrackName;
      }
      
      public function set customMaximumTrackName(param1:String) : void
      {
         if(this._customMaximumTrackName == param1)
         {
            return;
         }
         this._customMaximumTrackName = param1;
         this.invalidate("maximumTrackFactory");
      }
      
      public function get maximumTrackProperties() : Object
      {
         if(!this._maximumTrackProperties)
         {
            this._maximumTrackProperties = PropertyProxy.fromEmpty(maximumTrackProperties_onChange);
         }
         return this._maximumTrackProperties;
      }
      
      public function set maximumTrackProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._maximumTrackProperties == param1)
         {
            return;
         }
         if(!param1)
         {
            param1 = PropertyProxy.fromEmpty();
         }
         if(!PropertyProxy.isInstance(param1))
         {
            _loc2_ = PropertyProxy.fromEmpty();
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
            param1 = _loc2_;
         }
         if(this._maximumTrackProperties)
         {
            this._maximumTrackProperties.removeOnChangeCallback(maximumTrackProperties_onChange);
         }
         this._maximumTrackProperties = PropertyProxy.asInstance(param1);
         if(this._maximumTrackProperties)
         {
            this._maximumTrackProperties.addOnChangeCallback(maximumTrackProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get thumbFactory() : Function
      {
         return this._thumbFactory;
      }
      
      public function set thumbFactory(param1:Function) : void
      {
         if(this._thumbFactory == param1)
         {
            return;
         }
         this._thumbFactory = param1;
         this.invalidate("thumbFactory");
      }
      
      public function get customThumbName() : String
      {
         return this._customThumbName;
      }
      
      public function set customThumbName(param1:String) : void
      {
         if(this._customThumbName == param1)
         {
            return;
         }
         this._customThumbName = param1;
         this.invalidate("thumbFactory");
      }
      
      public function get thumbProperties() : Object
      {
         if(!this._thumbProperties)
         {
            this._thumbProperties = PropertyProxy.fromEmpty(thumbProperties_onChange);
         }
         return this._thumbProperties;
      }
      
      public function set thumbProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._thumbProperties == param1)
         {
            return;
         }
         if(!param1)
         {
            param1 = PropertyProxy.fromEmpty();
         }
         if(!PropertyProxy.isInstance(param1))
         {
            _loc2_ = PropertyProxy.fromEmpty();
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
            param1 = _loc2_;
         }
         if(this._thumbProperties)
         {
            this._thumbProperties.removeOnChangeCallback(thumbProperties_onChange);
         }
         this._thumbProperties = PropertyProxy.asInstance(param1);
         if(this._thumbProperties)
         {
            this._thumbProperties.addOnChangeCallback(thumbProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get decrementButtonFactory() : Function
      {
         return this._decrementButtonFactory;
      }
      
      public function set decrementButtonFactory(param1:Function) : void
      {
         if(this._decrementButtonFactory == param1)
         {
            return;
         }
         this._decrementButtonFactory = param1;
         this.invalidate("decrementButtonFactory");
      }
      
      public function get customDecrementButtonName() : String
      {
         return this._customDecrementButtonName;
      }
      
      public function set customDecrementButtonName(param1:String) : void
      {
         if(this._customDecrementButtonName == param1)
         {
            return;
         }
         this._customDecrementButtonName = param1;
         this.invalidate("decrementButtonFactory");
      }
      
      public function get decrementButtonProperties() : Object
      {
         if(!this._decrementButtonProperties)
         {
            this._decrementButtonProperties = PropertyProxy.fromEmpty(decrementButtonProperties_onChange);
         }
         return this._decrementButtonProperties;
      }
      
      public function set decrementButtonProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._decrementButtonProperties == param1)
         {
            return;
         }
         if(!param1)
         {
            param1 = PropertyProxy.fromEmpty();
         }
         if(!PropertyProxy.isInstance(param1))
         {
            _loc2_ = PropertyProxy.fromEmpty();
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
            param1 = _loc2_;
         }
         if(this._decrementButtonProperties)
         {
            this._decrementButtonProperties.removeOnChangeCallback(decrementButtonProperties_onChange);
         }
         this._decrementButtonProperties = PropertyProxy.asInstance(param1);
         if(this._decrementButtonProperties)
         {
            this._decrementButtonProperties.addOnChangeCallback(decrementButtonProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get incrementButtonFactory() : Function
      {
         return this._incrementButtonFactory;
      }
      
      public function set incrementButtonFactory(param1:Function) : void
      {
         if(this._incrementButtonFactory == param1)
         {
            return;
         }
         this._incrementButtonFactory = param1;
         this.invalidate("incrementButtonFactory");
      }
      
      public function get customIncrementButtonName() : String
      {
         return this._customIncrementButtonName;
      }
      
      public function set customIncrementButtonName(param1:String) : void
      {
         if(this._customIncrementButtonName == param1)
         {
            return;
         }
         this._customIncrementButtonName = param1;
         this.invalidate("incrementButtonFactory");
      }
      
      public function get incrementButtonProperties() : Object
      {
         if(!this._incrementButtonProperties)
         {
            this._incrementButtonProperties = PropertyProxy.fromEmpty(incrementButtonProperties_onChange);
         }
         return this._incrementButtonProperties;
      }
      
      public function set incrementButtonProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._incrementButtonProperties == param1)
         {
            return;
         }
         if(!param1)
         {
            param1 = PropertyProxy.fromEmpty();
         }
         if(!PropertyProxy.isInstance(param1))
         {
            _loc2_ = PropertyProxy.fromEmpty();
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
            param1 = _loc2_;
         }
         if(this._incrementButtonProperties)
         {
            this._incrementButtonProperties.removeOnChangeCallback(incrementButtonProperties_onChange);
         }
         this._incrementButtonProperties = PropertyProxy.asInstance(param1);
         if(this._incrementButtonProperties)
         {
            this._incrementButtonProperties.addOnChangeCallback(incrementButtonProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      override protected function draw() : void
      {
         var _loc10_:Boolean = this.isInvalid("data");
         var _loc11_:Boolean = this.isInvalid("styles");
         var _loc2_:Boolean = this.isInvalid("size");
         var _loc5_:Boolean = this.isInvalid("state");
         var _loc4_:Boolean = this.isInvalid("layout");
         var _loc9_:Boolean = this.isInvalid("thumbFactory");
         var _loc6_:Boolean = this.isInvalid("minimumTrackFactory");
         var _loc3_:Boolean = this.isInvalid("maximumTrackFactory");
         var _loc1_:Boolean = this.isInvalid("incrementButtonFactory");
         var _loc7_:Boolean = this.isInvalid("decrementButtonFactory");
         if(_loc9_)
         {
            this.createThumb();
         }
         if(_loc6_)
         {
            this.createMinimumTrack();
         }
         if(_loc3_ || _loc4_)
         {
            this.createMaximumTrack();
         }
         if(_loc7_)
         {
            this.createDecrementButton();
         }
         if(_loc1_)
         {
            this.createIncrementButton();
         }
         if(_loc9_ || _loc11_)
         {
            this.refreshThumbStyles();
         }
         if(_loc6_ || _loc11_)
         {
            this.refreshMinimumTrackStyles();
         }
         if((_loc3_ || _loc11_ || _loc4_) && this.maximumTrack)
         {
            this.refreshMaximumTrackStyles();
         }
         if(_loc7_ || _loc11_)
         {
            this.refreshDecrementButtonStyles();
         }
         if(_loc1_ || _loc11_)
         {
            this.refreshIncrementButtonStyles();
         }
         var _loc8_:Boolean = this._isEnabled && this._maximum > this._minimum;
         if(_loc10_ || _loc5_ || _loc9_)
         {
            this.thumb.isEnabled = _loc8_;
         }
         if(_loc10_ || _loc5_ || _loc6_)
         {
            this.minimumTrack.isEnabled = _loc8_;
         }
         if((_loc10_ || _loc5_ || _loc3_ || _loc4_) && this.maximumTrack)
         {
            this.maximumTrack.isEnabled = _loc8_;
         }
         if(_loc10_ || _loc5_ || _loc7_)
         {
            this.decrementButton.isEnabled = _loc8_;
         }
         if(_loc10_ || _loc5_ || _loc1_)
         {
            this.incrementButton.isEnabled = _loc8_;
         }
         _loc2_ = this.autoSizeIfNeeded() || _loc2_;
         this.layout();
      }
      
      protected function autoSizeIfNeeded() : Boolean
      {
         if(this.minimumTrackOriginalWidth !== this.minimumTrackOriginalWidth || this.minimumTrackOriginalHeight !== this.minimumTrackOriginalHeight)
         {
            this.minimumTrack.validate();
            this.minimumTrackOriginalWidth = this.minimumTrack.width;
            this.minimumTrackOriginalHeight = this.minimumTrack.height;
         }
         if(this.maximumTrack)
         {
            if(this.maximumTrackOriginalWidth !== this.maximumTrackOriginalWidth || this.maximumTrackOriginalHeight !== this.maximumTrackOriginalHeight)
            {
               this.maximumTrack.validate();
               this.maximumTrackOriginalWidth = this.maximumTrack.width;
               this.maximumTrackOriginalHeight = this.maximumTrack.height;
            }
         }
         if(this.thumbOriginalWidth !== this.thumbOriginalWidth || this.thumbOriginalHeight !== this.thumbOriginalHeight)
         {
            this.thumb.validate();
            this.thumbOriginalWidth = this.thumb.width;
            this.thumbOriginalHeight = this.thumb.height;
         }
         this.decrementButton.validate();
         this.incrementButton.validate();
         var _loc2_:* = this.explicitWidth !== this.explicitWidth;
         var _loc4_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc2_ && !_loc4_)
         {
            return false;
         }
         var _loc1_:Number = this.explicitWidth;
         var _loc3_:Number = this.explicitHeight;
         if(_loc2_)
         {
            if(this._direction == "vertical")
            {
               if(this.maximumTrack)
               {
                  _loc1_ = Math.max(this.minimumTrackOriginalWidth,this.maximumTrackOriginalWidth);
               }
               else
               {
                  _loc1_ = this.minimumTrackOriginalWidth;
               }
            }
            else if(this.maximumTrack)
            {
               _loc1_ = Math.min(this.minimumTrackOriginalWidth,this.maximumTrackOriginalWidth) + this.thumb.width / 2;
            }
            else
            {
               _loc1_ = this.minimumTrackOriginalWidth;
            }
         }
         if(_loc4_)
         {
            if(this._direction == "vertical")
            {
               if(this.maximumTrack)
               {
                  _loc3_ = Math.min(this.minimumTrackOriginalHeight,this.maximumTrackOriginalHeight) + this.thumb.height / 2;
               }
               else
               {
                  _loc3_ = this.minimumTrackOriginalHeight;
               }
            }
            else if(this.maximumTrack)
            {
               _loc3_ = Math.max(this.minimumTrackOriginalHeight,this.maximumTrackOriginalHeight);
            }
            else
            {
               _loc3_ = this.minimumTrackOriginalHeight;
            }
         }
         return this.setSizeInternal(_loc1_,_loc3_,false);
      }
      
      protected function createThumb() : void
      {
         if(this.thumb)
         {
            this.thumb.removeFromParent(true);
            this.thumb = null;
         }
         var _loc1_:Function = this._thumbFactory != null?this._thumbFactory:defaultThumbFactory;
         var _loc2_:String = this._customThumbName != null?this._customThumbName:this.thumbName;
         this.thumb = Button(_loc1_());
         this.thumb.styleNameList.add(_loc2_);
         this.thumb.keepDownStateOnRollOut = true;
         this.thumb.isFocusEnabled = false;
         this.thumb.addEventListener("touch",thumb_touchHandler);
         this.addChild(this.thumb);
      }
      
      protected function createMinimumTrack() : void
      {
         if(this.minimumTrack)
         {
            this.minimumTrack.removeFromParent(true);
            this.minimumTrack = null;
         }
         var _loc1_:Function = this._minimumTrackFactory != null?this._minimumTrackFactory:defaultMinimumTrackFactory;
         var _loc2_:String = this._customMinimumTrackName != null?this._customMinimumTrackName:this.minimumTrackName;
         this.minimumTrack = Button(_loc1_());
         this.minimumTrack.styleNameList.add(_loc2_);
         this.minimumTrack.keepDownStateOnRollOut = true;
         this.minimumTrack.isFocusEnabled = false;
         this.minimumTrack.addEventListener("touch",track_touchHandler);
         this.addChildAt(this.minimumTrack,0);
      }
      
      protected function createMaximumTrack() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this._trackLayoutMode == "minMax")
         {
            if(this.maximumTrack)
            {
               this.maximumTrack.removeFromParent(true);
               this.maximumTrack = null;
            }
            _loc1_ = this._maximumTrackFactory != null?this._maximumTrackFactory:defaultMaximumTrackFactory;
            _loc2_ = this._customMaximumTrackName != null?this._customMaximumTrackName:this.maximumTrackName;
            this.maximumTrack = Button(_loc1_());
            this.maximumTrack.styleNameList.add(_loc2_);
            this.maximumTrack.keepDownStateOnRollOut = true;
            this.maximumTrack.isFocusEnabled = false;
            this.maximumTrack.addEventListener("touch",track_touchHandler);
            this.addChildAt(this.maximumTrack,1);
         }
         else if(this.maximumTrack)
         {
            this.maximumTrack.removeFromParent(true);
            this.maximumTrack = null;
         }
      }
      
      protected function createDecrementButton() : void
      {
         if(this.decrementButton)
         {
            this.decrementButton.removeFromParent(true);
            this.decrementButton = null;
         }
         var _loc1_:Function = this._decrementButtonFactory != null?this._decrementButtonFactory:defaultDecrementButtonFactory;
         var _loc2_:String = this._customDecrementButtonName != null?this._customDecrementButtonName:this.decrementButtonName;
         this.decrementButton = Button(_loc1_());
         this.decrementButton.styleNameList.add(_loc2_);
         this.decrementButton.keepDownStateOnRollOut = true;
         this.decrementButton.isFocusEnabled = false;
         this.decrementButton.addEventListener("touch",decrementButton_touchHandler);
         this.addChild(this.decrementButton);
      }
      
      protected function createIncrementButton() : void
      {
         if(this.incrementButton)
         {
            this.incrementButton.removeFromParent(true);
            this.incrementButton = null;
         }
         var _loc2_:Function = this._incrementButtonFactory != null?this._incrementButtonFactory:defaultIncrementButtonFactory;
         var _loc1_:String = this._customIncrementButtonName != null?this._customIncrementButtonName:this.incrementButtonName;
         this.incrementButton = Button(_loc2_());
         this.incrementButton.styleNameList.add(_loc1_);
         this.incrementButton.keepDownStateOnRollOut = true;
         this.incrementButton.isFocusEnabled = false;
         this.incrementButton.addEventListener("touch",incrementButton_touchHandler);
         this.addChild(this.incrementButton);
      }
      
      protected function refreshThumbStyles() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = this._thumbProperties;
         for(var _loc1_ in this._thumbProperties)
         {
            _loc2_ = this._thumbProperties[_loc1_];
            this.thumb[_loc1_] = _loc2_;
         }
      }
      
      protected function refreshMinimumTrackStyles() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = this._minimumTrackProperties;
         for(var _loc1_ in this._minimumTrackProperties)
         {
            _loc2_ = this._minimumTrackProperties[_loc1_];
            this.minimumTrack[_loc1_] = _loc2_;
         }
      }
      
      protected function refreshMaximumTrackStyles() : void
      {
         var _loc2_:* = null;
         if(!this.maximumTrack)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = this._maximumTrackProperties;
         for(var _loc1_ in this._maximumTrackProperties)
         {
            _loc2_ = this._maximumTrackProperties[_loc1_];
            this.maximumTrack[_loc1_] = _loc2_;
         }
      }
      
      protected function refreshDecrementButtonStyles() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = this._decrementButtonProperties;
         for(var _loc1_ in this._decrementButtonProperties)
         {
            _loc2_ = this._decrementButtonProperties[_loc1_];
            this.decrementButton[_loc1_] = _loc2_;
         }
      }
      
      protected function refreshIncrementButtonStyles() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = this._incrementButtonProperties;
         for(var _loc1_ in this._incrementButtonProperties)
         {
            _loc2_ = this._incrementButtonProperties[_loc1_];
            this.incrementButton[_loc1_] = _loc2_;
         }
      }
      
      protected function layout() : void
      {
         this.layoutStepButtons();
         this.layoutThumb();
         if(this._trackLayoutMode == "minMax")
         {
            this.layoutTrackWithMinMax();
         }
         else
         {
            this.layoutTrackWithSingle();
         }
      }
      
      protected function layoutStepButtons() : void
      {
         if(this._direction == "vertical")
         {
            this.decrementButton.x = (this.actualWidth - this.decrementButton.width) / 2;
            this.decrementButton.y = 0;
            this.incrementButton.x = (this.actualWidth - this.incrementButton.width) / 2;
            this.incrementButton.y = this.actualHeight - this.incrementButton.height;
         }
         else
         {
            this.decrementButton.x = 0;
            this.decrementButton.y = (this.actualHeight - this.decrementButton.height) / 2;
            this.incrementButton.x = this.actualWidth - this.incrementButton.width;
            this.incrementButton.y = (this.actualHeight - this.incrementButton.height) / 2;
         }
         var _loc1_:* = this._maximum != this._minimum;
         this.decrementButton.visible = _loc1_;
         this.incrementButton.visible = _loc1_;
      }
      
      protected function layoutThumb() : void
      {
         var _loc2_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:Number = this._maximum - this._minimum;
         this.thumb.visible = _loc4_ > 0 && this._isEnabled;
         if(!this.thumb.visible)
         {
            return;
         }
         this.thumb.validate();
         var _loc3_:Number = this.actualWidth - this._paddingLeft - this._paddingRight;
         var _loc8_:Number = this.actualHeight - this._paddingTop - this._paddingBottom;
         var _loc1_:* = Number(this._page);
         if(this._page == 0)
         {
            _loc1_ = _loc4_;
         }
         else if(_loc1_ > _loc4_)
         {
            _loc1_ = _loc4_;
         }
         if(this._direction == "vertical")
         {
            _loc8_ = _loc8_ - (this.decrementButton.height + this.incrementButton.height);
            _loc2_ = this.thumb.minHeight > 0?this.thumb.minHeight:Number(this.thumbOriginalHeight);
            this.thumb.width = this.thumbOriginalWidth;
            this.thumb.height = Math.max(_loc2_,_loc8_ * _loc1_ / _loc4_);
            _loc6_ = _loc8_ - this.thumb.height;
            this.thumb.x = this._paddingLeft + (this.actualWidth - this._paddingLeft - this._paddingRight - this.thumb.width) / 2;
            this.thumb.y = this.decrementButton.height + this._paddingTop + Math.max(0,Math.min(_loc6_,_loc6_ * (this._value - this._minimum) / _loc4_));
         }
         else
         {
            _loc3_ = _loc3_ - (this.decrementButton.width + this.decrementButton.width);
            _loc5_ = this.thumb.minWidth > 0?this.thumb.minWidth:Number(this.thumbOriginalWidth);
            this.thumb.width = Math.max(_loc5_,_loc3_ * _loc1_ / _loc4_);
            this.thumb.height = this.thumbOriginalHeight;
            _loc7_ = _loc3_ - this.thumb.width;
            this.thumb.x = this.decrementButton.width + this._paddingLeft + Math.max(0,Math.min(_loc7_,_loc7_ * (this._value - this._minimum) / _loc4_));
            this.thumb.y = this._paddingTop + (this.actualHeight - this._paddingTop - this._paddingBottom - this.thumb.height) / 2;
         }
      }
      
      protected function layoutTrackWithMinMax() : void
      {
         var _loc1_:* = this._maximum != this._minimum;
         if(this._direction == "vertical")
         {
            this.minimumTrack.x = 0;
            if(_loc1_)
            {
               this.minimumTrack.y = this.decrementButton.height;
            }
            else
            {
               this.minimumTrack.y = 0;
            }
            this.minimumTrack.width = this.actualWidth;
            this.minimumTrack.height = this.thumb.y + this.thumb.height / 2 - this.minimumTrack.y;
            this.maximumTrack.x = 0;
            this.maximumTrack.y = this.minimumTrack.y + this.minimumTrack.height;
            this.maximumTrack.width = this.actualWidth;
            if(_loc1_)
            {
               this.maximumTrack.height = this.actualHeight - this.incrementButton.height - this.maximumTrack.y;
            }
            else
            {
               this.maximumTrack.height = this.actualHeight - this.maximumTrack.y;
            }
         }
         else
         {
            if(_loc1_)
            {
               this.minimumTrack.x = this.decrementButton.width;
            }
            else
            {
               this.minimumTrack.x = 0;
            }
            this.minimumTrack.y = 0;
            this.minimumTrack.width = this.thumb.x + this.thumb.width / 2 - this.minimumTrack.x;
            this.minimumTrack.height = this.actualHeight;
            this.maximumTrack.x = this.minimumTrack.x + this.minimumTrack.width;
            this.maximumTrack.y = 0;
            if(_loc1_)
            {
               this.maximumTrack.width = this.actualWidth - this.incrementButton.width - this.maximumTrack.x;
            }
            else
            {
               this.maximumTrack.width = this.actualWidth - this.maximumTrack.x;
            }
            this.maximumTrack.height = this.actualHeight;
         }
         this.minimumTrack.validate();
         this.maximumTrack.validate();
      }
      
      protected function layoutTrackWithSingle() : void
      {
         var _loc1_:* = this._maximum != this._minimum;
         if(this._direction == "vertical")
         {
            this.minimumTrack.x = 0;
            if(_loc1_)
            {
               this.minimumTrack.y = this.decrementButton.height;
            }
            else
            {
               this.minimumTrack.y = 0;
            }
            this.minimumTrack.width = this.actualWidth;
            if(_loc1_)
            {
               this.minimumTrack.height = this.actualHeight - this.minimumTrack.y - this.incrementButton.height;
            }
            else
            {
               this.minimumTrack.height = this.actualHeight - this.minimumTrack.y;
            }
         }
         else
         {
            if(_loc1_)
            {
               this.minimumTrack.x = this.decrementButton.width;
            }
            else
            {
               this.minimumTrack.x = 0;
            }
            this.minimumTrack.y = 0;
            if(_loc1_)
            {
               this.minimumTrack.width = this.actualWidth - this.minimumTrack.x - this.incrementButton.width;
            }
            else
            {
               this.minimumTrack.width = this.actualWidth - this.minimumTrack.x;
            }
            this.minimumTrack.height = this.actualHeight;
         }
         this.minimumTrack.validate();
      }
      
      protected function locationToValue(param1:Point) : Number
      {
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:* = 0;
         if(this._direction == "vertical")
         {
            _loc7_ = this.actualHeight - this.thumb.height - this.decrementButton.height - this.incrementButton.height - this._paddingTop - this._paddingBottom;
            if(_loc7_ > 0)
            {
               _loc3_ = param1.y - this._touchStartY - this._paddingTop;
               _loc6_ = Math.min(Math.max(0,this._thumbStartY + _loc3_ - this.decrementButton.height),_loc7_);
               _loc5_ = Number(_loc6_ / _loc7_);
            }
         }
         else
         {
            _loc8_ = this.actualWidth - this.thumb.width - this.decrementButton.width - this.incrementButton.width - this._paddingLeft - this._paddingRight;
            if(_loc8_ > 0)
            {
               _loc4_ = param1.x - this._touchStartX - this._paddingLeft;
               _loc2_ = Math.min(Math.max(0,this._thumbStartX + _loc4_ - this.decrementButton.width),_loc8_);
               _loc5_ = Number(_loc2_ / _loc8_);
            }
         }
         return this._minimum + _loc5_ * (this._maximum - this._minimum);
      }
      
      protected function decrement() : void
      {
         this.value = this.value - this._step;
      }
      
      protected function increment() : void
      {
         this.value = this.value + this._step;
      }
      
      protected function adjustPage() : void
      {
         var _loc1_:Number = NaN;
         if(this._touchValue < this._value)
         {
            _loc1_ = Math.max(this._touchValue,this._value - this._page);
            if(this._step != 0 && _loc1_ != this._maximum && _loc1_ != this._minimum)
            {
               _loc1_ = roundToNearest(_loc1_,this._step);
            }
            this.value = _loc1_;
         }
         else if(this._touchValue > this._value)
         {
            _loc1_ = Math.min(this._touchValue,this._value + this._page);
            if(this._step != 0 && _loc1_ != this._maximum && _loc1_ != this._minimum)
            {
               _loc1_ = roundToNearest(_loc1_,this._step);
            }
            this.value = _loc1_;
         }
      }
      
      protected function startRepeatTimer(param1:Function) : void
      {
         this.currentRepeatAction = param1;
         if(this._repeatDelay > 0)
         {
            if(!this._repeatTimer)
            {
               this._repeatTimer = new Timer(this._repeatDelay * 1000);
               this._repeatTimer.addEventListener("timer",repeatTimer_timerHandler);
            }
            else
            {
               this._repeatTimer.reset();
               this._repeatTimer.delay = this._repeatDelay * 1000;
            }
            this._repeatTimer.start();
         }
      }
      
      protected function thumbProperties_onChange(param1:PropertyProxy, param2:Object) : void
      {
         this.invalidate("styles");
      }
      
      protected function minimumTrackProperties_onChange(param1:PropertyProxy, param2:Object) : void
      {
         this.invalidate("styles");
      }
      
      protected function maximumTrackProperties_onChange(param1:PropertyProxy, param2:Object) : void
      {
         this.invalidate("styles");
      }
      
      protected function decrementButtonProperties_onChange(param1:PropertyProxy, param2:Object) : void
      {
         this.invalidate("styles");
      }
      
      protected function incrementButtonProperties_onChange(param1:PropertyProxy, param2:Object) : void
      {
         this.invalidate("styles");
      }
      
      protected function removedFromStageHandler(param1:Event) : void
      {
         this._touchPointID = -1;
         if(this._repeatTimer)
         {
            this._repeatTimer.stop();
         }
      }
      
      protected function track_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(!this._isEnabled)
         {
            this._touchPointID = -1;
            return;
         }
         var _loc3_:DisplayObject = DisplayObject(param1.currentTarget);
         if(this._touchPointID >= 0)
         {
            _loc2_ = param1.getTouch(_loc3_,"ended",this._touchPointID);
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = -1;
            if(_repeatTimer != null)
            {
               this._repeatTimer.stop();
            }
            this.dispatchEventWith("endInteraction");
         }
         else
         {
            _loc2_ = param1.getTouch(_loc3_,"began");
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = _loc2_.id;
            this.dispatchEventWith("beginInteraction");
            _loc2_.getLocation(this,HELPER_POINT);
            this._touchStartX = HELPER_POINT.x;
            this._touchStartY = HELPER_POINT.y;
            this._thumbStartX = HELPER_POINT.x;
            this._thumbStartY = HELPER_POINT.y;
            this._touchValue = this.locationToValue(HELPER_POINT);
            this.adjustPage();
            this.startRepeatTimer(this.adjustPage);
         }
      }
      
      protected function thumb_touchHandler(param1:TouchEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         if(!this._isEnabled)
         {
            this._touchPointID = -1;
            return;
         }
         if(this._touchPointID >= 0)
         {
            _loc3_ = param1.getTouch(this.thumb,null,this._touchPointID);
            if(!_loc3_)
            {
               return;
            }
            if(_loc3_.phase == "moved")
            {
               _loc3_.getLocation(this,HELPER_POINT);
               _loc2_ = this.locationToValue(HELPER_POINT);
               if(this._step != 0 && _loc2_ != this._maximum && _loc2_ != this._minimum)
               {
                  _loc2_ = roundToNearest(_loc2_,this._step);
               }
               this.value = _loc2_;
            }
            else if(_loc3_.phase == "ended")
            {
               this._touchPointID = -1;
               this.isDragging = false;
               if(!this.liveDragging)
               {
                  this.dispatchEventWith("change");
               }
               this.dispatchEventWith("endInteraction");
            }
         }
         else
         {
            _loc3_ = param1.getTouch(this.thumb,"began");
            if(!_loc3_)
            {
               return;
            }
            _loc3_.getLocation(this,HELPER_POINT);
            this._touchPointID = _loc3_.id;
            this._thumbStartX = this.thumb.x;
            this._thumbStartY = this.thumb.y;
            this._touchStartX = HELPER_POINT.x;
            this._touchStartY = HELPER_POINT.y;
            this.isDragging = true;
            this.dispatchEventWith("beginInteraction");
         }
      }
      
      protected function decrementButton_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(!this._isEnabled)
         {
            this._touchPointID = -1;
            return;
         }
         if(this._touchPointID >= 0)
         {
            _loc2_ = param1.getTouch(this.decrementButton,"ended",this._touchPointID);
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = -1;
            if(_repeatTimer != null)
            {
               this._repeatTimer.stop();
            }
            this.dispatchEventWith("endInteraction");
         }
         else
         {
            _loc2_ = param1.getTouch(this.decrementButton,"began");
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = _loc2_.id;
            this.dispatchEventWith("beginInteraction");
            this.decrement();
            this.startRepeatTimer(this.decrement);
         }
      }
      
      protected function incrementButton_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(!this._isEnabled)
         {
            this._touchPointID = -1;
            return;
         }
         if(this._touchPointID >= 0)
         {
            _loc2_ = param1.getTouch(this.incrementButton,"ended",this._touchPointID);
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = -1;
            if(_repeatTimer != null)
            {
               this._repeatTimer.stop();
            }
            this.dispatchEventWith("endInteraction");
         }
         else
         {
            _loc2_ = param1.getTouch(this.incrementButton,"began");
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = _loc2_.id;
            this.dispatchEventWith("beginInteraction");
            this.increment();
            this.startRepeatTimer(this.increment);
         }
      }
      
      protected function repeatTimer_timerHandler(param1:TimerEvent) : void
      {
         if(this._repeatTimer.currentCount < 5)
         {
            return;
         }
         this.currentRepeatAction();
      }
   }
}

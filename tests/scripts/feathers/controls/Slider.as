package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.IFocusDisplayObject;
   import feathers.core.PropertyProxy;
   import feathers.events.ExclusiveTouch;
   import feathers.skins.IStyleProvider;
   import feathers.utils.math.clamp;
   import feathers.utils.math.roundToNearest;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.KeyboardEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   [Event(name="change",type="starling.events.Event")]
   [Event(name="beginInteraction",type="starling.events.Event")]
   [Event(name="endInteraction",type="starling.events.Event")]
   public class Slider extends FeathersControl implements IDirectionalScrollBar, IFocusDisplayObject
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      protected static const INVALIDATION_FLAG_THUMB_FACTORY:String = "thumbFactory";
      
      protected static const INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY:String = "minimumTrackFactory";
      
      protected static const INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY:String = "maximumTrackFactory";
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
      
      public static const TRACK_LAYOUT_MODE_SINGLE:String = "single";
      
      public static const TRACK_LAYOUT_MODE_MIN_MAX:String = "minMax";
      
      public static const TRACK_SCALE_MODE_EXACT_FIT:String = "exactFit";
      
      public static const TRACK_SCALE_MODE_DIRECTIONAL:String = "directional";
      
      public static const TRACK_INTERACTION_MODE_TO_VALUE:String = "toValue";
      
      public static const TRACK_INTERACTION_MODE_BY_PAGE:String = "byPage";
      
      public static const DEFAULT_CHILD_NAME_MINIMUM_TRACK:String = "feathers-slider-minimum-track";
      
      public static const DEFAULT_CHILD_NAME_MAXIMUM_TRACK:String = "feathers-slider-maximum-track";
      
      public static const DEFAULT_CHILD_NAME_THUMB:String = "feathers-slider-thumb";
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var minimumTrackName:String = "feathers-slider-minimum-track";
      
      protected var maximumTrackName:String = "feathers-slider-maximum-track";
      
      protected var thumbName:String = "feathers-slider-thumb";
      
      protected var thumb:Button;
      
      protected var minimumTrack:Button;
      
      protected var maximumTrack:Button;
      
      protected var minimumTrackOriginalWidth:Number = NaN;
      
      protected var minimumTrackOriginalHeight:Number = NaN;
      
      protected var maximumTrackOriginalWidth:Number = NaN;
      
      protected var maximumTrackOriginalHeight:Number = NaN;
      
      protected var _direction:String = "horizontal";
      
      protected var _value:Number = 0;
      
      protected var _minimum:Number = 0;
      
      protected var _maximum:Number = 0;
      
      protected var _step:Number = 0;
      
      protected var _page:Number = NaN;
      
      protected var isDragging:Boolean = false;
      
      public var liveDragging:Boolean = true;
      
      protected var _showThumb:Boolean = true;
      
      protected var _minimumPadding:Number = 0;
      
      protected var _maximumPadding:Number = 0;
      
      protected var _trackLayoutMode:String = "single";
      
      protected var _trackScaleMode:String = "directional";
      
      protected var _trackInteractionMode:String = "toValue";
      
      protected var currentRepeatAction:Function;
      
      protected var _repeatTimer:Timer;
      
      protected var _repeatDelay:Number = 0.05;
      
      protected var _minimumTrackFactory:Function;
      
      protected var _customMinimumTrackName:String;
      
      protected var _minimumTrackProperties:PropertyProxy;
      
      protected var _maximumTrackFactory:Function;
      
      protected var _customMaximumTrackName:String;
      
      protected var _maximumTrackProperties:PropertyProxy;
      
      protected var _thumbFactory:Function;
      
      protected var _customThumbName:String;
      
      protected var _thumbProperties:PropertyProxy;
      
      protected var _touchPointID:int = -1;
      
      protected var _touchStartX:Number = NaN;
      
      protected var _touchStartY:Number = NaN;
      
      protected var _thumbStartX:Number = NaN;
      
      protected var _thumbStartY:Number = NaN;
      
      protected var _touchValue:Number;
      
      public function Slider()
      {
         super();
         this.addEventListener("removedFromStage",slider_removedFromStageHandler);
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
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return Slider.globalStyleProvider;
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
         if(this._step != 0 && param1 != this._maximum && param1 != this._minimum)
         {
            param1 = roundToNearest(param1 - this._minimum,this._step) + this._minimum;
         }
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
         if(this._step == param1)
         {
            return;
         }
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
      }
      
      public function get showThumb() : Boolean
      {
         return this._showThumb;
      }
      
      public function set showThumb(param1:Boolean) : void
      {
         if(this._showThumb == param1)
         {
            return;
         }
         this._showThumb = param1;
         this.invalidate("styles");
      }
      
      public function get minimumPadding() : Number
      {
         return this._minimumPadding;
      }
      
      public function set minimumPadding(param1:Number) : void
      {
         if(this._minimumPadding == param1)
         {
            return;
         }
         this._minimumPadding = param1;
         this.invalidate("styles");
      }
      
      public function get maximumPadding() : Number
      {
         return this._maximumPadding;
      }
      
      public function set maximumPadding(param1:Number) : void
      {
         if(this._maximumPadding == param1)
         {
            return;
         }
         this._maximumPadding = param1;
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
         this.invalidate("styles");
      }
      
      [Inspectable(type="String",enumeration="exactFit,directional")]
      public function get trackScaleMode() : String
      {
         return this._trackScaleMode;
      }
      
      public function set trackScaleMode(param1:String) : void
      {
         if(this._trackScaleMode == param1)
         {
            return;
         }
         this._trackScaleMode = param1;
         this.invalidate("styles");
      }
      
      [Inspectable(type="String",enumeration="toValue,byPage")]
      public function get trackInteractionMode() : String
      {
         return this._trackInteractionMode;
      }
      
      public function set trackInteractionMode(param1:String) : void
      {
         this._trackInteractionMode = param1;
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
            this._minimumTrackProperties = PropertyProxy.fromEmpty(childProperties_onChange);
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
            this._minimumTrackProperties.removeOnChangeCallback(childProperties_onChange);
         }
         this._minimumTrackProperties = PropertyProxy.asInstance(param1);
         if(this._minimumTrackProperties)
         {
            this._minimumTrackProperties.addOnChangeCallback(childProperties_onChange);
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
            this._maximumTrackProperties = PropertyProxy.fromEmpty(childProperties_onChange);
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
            this._maximumTrackProperties.removeOnChangeCallback(childProperties_onChange);
         }
         this._maximumTrackProperties = PropertyProxy.asInstance(param1);
         if(this._maximumTrackProperties)
         {
            this._maximumTrackProperties.addOnChangeCallback(childProperties_onChange);
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
            this._thumbProperties = PropertyProxy.fromEmpty(childProperties_onChange);
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
            this._thumbProperties.removeOnChangeCallback(childProperties_onChange);
         }
         this._thumbProperties = PropertyProxy.asInstance(param1);
         if(this._thumbProperties)
         {
            this._thumbProperties.addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      override protected function draw() : void
      {
         var _loc8_:Boolean = this.isInvalid("styles");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc5_:Boolean = this.isInvalid("state");
         var _loc2_:Boolean = this.isInvalid("focus");
         var _loc4_:Boolean = this.isInvalid("layout");
         var _loc7_:Boolean = this.isInvalid("thumbFactory");
         var _loc6_:Boolean = this.isInvalid("minimumTrackFactory");
         var _loc3_:Boolean = this.isInvalid("maximumTrackFactory");
         if(_loc7_)
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
         if(_loc7_ || _loc8_)
         {
            this.refreshThumbStyles();
         }
         if(_loc6_ || _loc8_)
         {
            this.refreshMinimumTrackStyles();
         }
         if((_loc3_ || _loc4_ || _loc8_) && this.maximumTrack)
         {
            this.refreshMaximumTrackStyles();
         }
         if(_loc7_ || _loc5_)
         {
            this.thumb.isEnabled = this._isEnabled;
         }
         if(_loc6_ || _loc5_)
         {
            this.minimumTrack.isEnabled = this._isEnabled;
         }
         if((_loc3_ || _loc4_ || _loc5_) && this.maximumTrack)
         {
            this.maximumTrack.isEnabled = this._isEnabled;
         }
         _loc1_ = this.autoSizeIfNeeded() || _loc1_;
         this.layoutChildren();
         if(_loc1_ || _loc2_)
         {
            this.refreshFocusIndicator();
         }
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
         var _loc2_:* = this.explicitWidth !== this.explicitWidth;
         var _loc4_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc2_ && !_loc4_)
         {
            return false;
         }
         this.thumb.validate();
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
            _loc1_ = Math.max(_loc1_,this.thumb.width);
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
            _loc3_ = Math.max(_loc3_,this.thumb.height);
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
            this.maximumTrack.addEventListener("touch",track_touchHandler);
            this.addChildAt(this.maximumTrack,1);
         }
         else if(this.maximumTrack)
         {
            this.maximumTrack.removeFromParent(true);
            this.maximumTrack = null;
         }
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
         this.thumb.visible = this._showThumb;
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
      
      protected function layoutChildren() : void
      {
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
      
      protected function layoutThumb() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         this.thumb.validate();
         if(this._direction == "vertical")
         {
            _loc1_ = this.actualHeight - this.thumb.height - this._minimumPadding - this._maximumPadding;
            this.thumb.x = (this.actualWidth - this.thumb.width) / 2;
            this.thumb.y = this._minimumPadding + _loc1_ * (1 - (this._value - this._minimum) / (this._maximum - this._minimum));
         }
         else
         {
            _loc2_ = this.actualWidth - this.thumb.width - this._minimumPadding - this._maximumPadding;
            this.thumb.x = this._minimumPadding + _loc2_ * (this._value - this._minimum) / (this._maximum - this._minimum);
            this.thumb.y = (this.actualHeight - this.thumb.height) / 2;
         }
      }
      
      protected function layoutTrackWithMinMax() : void
      {
         if(this._direction == "vertical")
         {
            this.maximumTrack.y = 0;
            this.maximumTrack.height = this.thumb.y + this.thumb.height / 2;
            this.minimumTrack.y = this.maximumTrack.height;
            this.minimumTrack.height = this.actualHeight - this.minimumTrack.y;
            if(this._trackScaleMode == "directional")
            {
               this.maximumTrack.width = NaN;
               this.maximumTrack.validate();
               this.maximumTrack.x = (this.actualWidth - this.maximumTrack.width) / 2;
               this.minimumTrack.width = NaN;
               this.minimumTrack.validate();
               this.minimumTrack.x = (this.actualWidth - this.minimumTrack.width) / 2;
            }
            else
            {
               this.maximumTrack.x = 0;
               this.maximumTrack.width = this.actualWidth;
               this.minimumTrack.x = 0;
               this.minimumTrack.width = this.actualWidth;
               this.minimumTrack.validate();
               this.maximumTrack.validate();
            }
         }
         else
         {
            this.minimumTrack.x = 0;
            this.minimumTrack.width = this.thumb.x + this.thumb.width / 2;
            this.maximumTrack.x = this.minimumTrack.width;
            this.maximumTrack.width = this.actualWidth - this.maximumTrack.x;
            if(this._trackScaleMode == "directional")
            {
               this.minimumTrack.height = NaN;
               this.minimumTrack.validate();
               this.minimumTrack.y = (this.actualHeight - this.minimumTrack.height) / 2;
               this.maximumTrack.height = NaN;
               this.maximumTrack.validate();
               this.maximumTrack.y = (this.actualHeight - this.maximumTrack.height) / 2;
            }
            else
            {
               this.minimumTrack.y = 0;
               this.minimumTrack.height = this.actualHeight;
               this.maximumTrack.y = 0;
               this.maximumTrack.height = this.actualHeight;
               this.minimumTrack.validate();
               this.maximumTrack.validate();
            }
         }
      }
      
      protected function layoutTrackWithSingle() : void
      {
         if(this._trackScaleMode == "directional")
         {
            if(this._direction == "vertical")
            {
               this.minimumTrack.y = 0;
               this.minimumTrack.width = NaN;
               this.minimumTrack.height = this.actualHeight;
               this.minimumTrack.validate();
               this.minimumTrack.x = (this.actualWidth - this.minimumTrack.width) / 2;
            }
            else
            {
               this.minimumTrack.x = 0;
               this.minimumTrack.width = this.actualWidth;
               this.minimumTrack.height = NaN;
               this.minimumTrack.validate();
               this.minimumTrack.y = (this.actualHeight - this.minimumTrack.height) / 2;
            }
         }
         else
         {
            this.minimumTrack.x = 0;
            this.minimumTrack.y = 0;
            this.minimumTrack.width = this.actualWidth;
            this.minimumTrack.height = this.actualHeight;
            this.minimumTrack.validate();
         }
      }
      
      protected function locationToValue(param1:Point) : Number
      {
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._direction == "vertical")
         {
            _loc7_ = this.actualHeight - this.thumb.height - this._minimumPadding - this._maximumPadding;
            _loc3_ = param1.y - this._touchStartY - this._maximumPadding;
            _loc6_ = Math.min(Math.max(0,this._thumbStartY + _loc3_),_loc7_);
            _loc5_ = 1 - _loc6_ / _loc7_;
         }
         else
         {
            _loc8_ = this.actualWidth - this.thumb.width - this._minimumPadding - this._maximumPadding;
            _loc4_ = param1.x - this._touchStartX - this._minimumPadding;
            _loc2_ = Math.min(Math.max(0,this._thumbStartX + _loc4_),_loc8_);
            _loc5_ = _loc2_ / _loc8_;
         }
         return this._minimum + _loc5_ * (this._maximum - this._minimum);
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
      
      protected function adjustPage() : void
      {
         var _loc1_:Number = this._page;
         if(_loc1_ !== _loc1_)
         {
            _loc1_ = this._step;
         }
         if(this._touchValue < this._value)
         {
            this.value = Math.max(this._touchValue,this._value - _loc1_);
         }
         else if(this._touchValue > this._value)
         {
            this.value = Math.min(this._touchValue,this._value + _loc1_);
         }
      }
      
      protected function childProperties_onChange(param1:PropertyProxy, param2:Object) : void
      {
         this.invalidate("styles");
      }
      
      protected function slider_removedFromStageHandler(param1:Event) : void
      {
         this._touchPointID = -1;
         var _loc2_:Boolean = this.isDragging;
         this.isDragging = false;
         if(_loc2_ && !this.liveDragging)
         {
            this.dispatchEventWith("change");
         }
      }
      
      override protected function focusInHandler(param1:Event) : void
      {
         super.focusInHandler(param1);
         this.stage.addEventListener("keyDown",stage_keyDownHandler);
      }
      
      override protected function focusOutHandler(param1:Event) : void
      {
         super.focusOutHandler(param1);
         this.stage.removeEventListener("keyDown",stage_keyDownHandler);
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
            _loc2_ = param1.getTouch(_loc3_,null,this._touchPointID);
            if(!_loc2_)
            {
               return;
            }
            if(!this._showThumb && _loc2_.phase == "moved")
            {
               _loc2_.getLocation(this,HELPER_POINT);
               this.value = this.locationToValue(HELPER_POINT);
            }
            else if(_loc2_.phase == "ended")
            {
               if(this._repeatTimer)
               {
                  this._repeatTimer.stop();
               }
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
            _loc2_ = param1.getTouch(_loc3_,"began");
            if(!_loc2_)
            {
               return;
            }
            _loc2_.getLocation(this,HELPER_POINT);
            this._touchPointID = _loc2_.id;
            if(this._direction == "vertical")
            {
               this._thumbStartX = HELPER_POINT.x;
               this._thumbStartY = Math.min(this.actualHeight - this.thumb.height,Math.max(0,HELPER_POINT.y - this.thumb.height / 2));
            }
            else
            {
               this._thumbStartX = Math.min(this.actualWidth - this.thumb.width,Math.max(0,HELPER_POINT.x - this.thumb.width / 2));
               this._thumbStartY = HELPER_POINT.y;
            }
            this._touchStartX = HELPER_POINT.x;
            this._touchStartY = HELPER_POINT.y;
            this._touchValue = this.locationToValue(HELPER_POINT);
            this.isDragging = true;
            this.dispatchEventWith("beginInteraction");
            if(this._showThumb && this._trackInteractionMode == "byPage")
            {
               this.adjustPage();
               this.startRepeatTimer(this.adjustPage);
            }
            else
            {
               this.value = this._touchValue;
            }
         }
      }
      
      protected function thumb_touchHandler(param1:TouchEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
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
               _loc2_ = ExclusiveTouch.forStage(this.stage);
               _loc4_ = _loc2_.getClaim(this._touchPointID);
               if(_loc4_ != this)
               {
                  if(_loc4_)
                  {
                     return;
                  }
                  _loc2_.claimTouch(this._touchPointID,this);
               }
               _loc3_.getLocation(this,HELPER_POINT);
               this.value = this.locationToValue(HELPER_POINT);
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
      
      protected function stage_keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 36)
         {
            this.value = this._minimum;
            return;
         }
         if(param1.keyCode == 35)
         {
            this.value = this._maximum;
            return;
         }
         var _loc2_:Number = this._page;
         if(_loc2_ !== _loc2_)
         {
            _loc2_ = this._step;
         }
         if(this._direction == "vertical")
         {
            if(param1.keyCode == 38)
            {
               if(param1.shiftKey)
               {
                  this.value = this.value + _loc2_;
               }
               else
               {
                  this.value = this.value + this._step;
               }
            }
            else if(param1.keyCode == 40)
            {
               if(param1.shiftKey)
               {
                  this.value = this.value - _loc2_;
               }
               else
               {
                  this.value = this.value - this._step;
               }
            }
         }
         else if(param1.keyCode == 37)
         {
            if(param1.shiftKey)
            {
               this.value = this.value - _loc2_;
            }
            else
            {
               this.value = this.value - this._step;
            }
         }
         else if(param1.keyCode == 39)
         {
            if(param1.shiftKey)
            {
               this.value = this.value + _loc2_;
            }
            else
            {
               this.value = this.value + this._step;
            }
         }
      }
      
      protected function repeatTimer_timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:ExclusiveTouch = ExclusiveTouch.forStage(this.stage);
         var _loc3_:DisplayObject = _loc2_.getClaim(this._touchPointID);
         if(_loc3_ && _loc3_ != this)
         {
            return;
         }
         if(this._repeatTimer.currentCount < 5)
         {
            return;
         }
         this.currentRepeatAction();
      }
   }
}

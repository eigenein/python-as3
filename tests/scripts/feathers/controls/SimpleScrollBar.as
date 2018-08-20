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
   import starling.display.Quad;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   [Event(name="change",type="starling.events.Event")]
   [Event(name="beginInteraction",type="starling.events.Event")]
   [Event(name="endInteraction",type="starling.events.Event")]
   public class SimpleScrollBar extends FeathersControl implements IDirectionalScrollBar
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      protected static const INVALIDATION_FLAG_THUMB_FACTORY:String = "thumbFactory";
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
      
      public static const DEFAULT_CHILD_NAME_THUMB:String = "feathers-simple-scroll-bar-thumb";
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var thumbName:String = "feathers-simple-scroll-bar-thumb";
      
      protected var thumbOriginalWidth:Number = NaN;
      
      protected var thumbOriginalHeight:Number = NaN;
      
      protected var thumb:Button;
      
      protected var track:Quad;
      
      protected var _direction:String = "horizontal";
      
      public var clampToRange:Boolean = false;
      
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
      
      protected var _thumbFactory:Function;
      
      protected var _customThumbName:String;
      
      protected var _thumbProperties:PropertyProxy;
      
      protected var _touchPointID:int = -1;
      
      protected var _touchStartX:Number = NaN;
      
      protected var _touchStartY:Number = NaN;
      
      protected var _thumbStartX:Number = NaN;
      
      protected var _thumbStartY:Number = NaN;
      
      protected var _touchValue:Number;
      
      public function SimpleScrollBar()
      {
         super();
         this.addEventListener("removedFromStage",removedFromStageHandler);
      }
      
      protected static function defaultThumbFactory() : Button
      {
         return new Button();
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return SimpleScrollBar.globalStyleProvider;
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
         this.invalidate("thumbFactory");
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         if(this.clampToRange)
         {
            param1 = clamp(param1,this._minimum,this._maximum);
         }
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
      
      override protected function initialize() : void
      {
         if(!this.track)
         {
            this.track = new Quad(10,10,16711935);
            this.track.alpha = 0;
            this.track.addEventListener("touch",track_touchHandler);
            this.addChild(this.track);
         }
      }
      
      override protected function draw() : void
      {
         var _loc4_:Boolean = this.isInvalid("data");
         var _loc5_:Boolean = this.isInvalid("styles");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc2_:Boolean = this.isInvalid("state");
         var _loc3_:Boolean = this.isInvalid("thumbFactory");
         if(_loc3_)
         {
            this.createThumb();
         }
         if(_loc3_ || _loc5_)
         {
            this.refreshThumbStyles();
         }
         if(_loc4_ || _loc3_ || _loc2_)
         {
            this.thumb.isEnabled = this._isEnabled && this._maximum > this._minimum;
         }
         _loc1_ = this.autoSizeIfNeeded() || _loc1_;
         this.layout();
      }
      
      protected function autoSizeIfNeeded() : Boolean
      {
         if(this.thumbOriginalWidth !== this.thumbOriginalWidth || this.thumbOriginalHeight !== this.thumbOriginalHeight)
         {
            this.thumb.validate();
            this.thumbOriginalWidth = this.thumb.width;
            this.thumbOriginalHeight = this.thumb.height;
         }
         var _loc3_:* = this.explicitWidth !== this.explicitWidth;
         var _loc5_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc3_ && !_loc5_)
         {
            return false;
         }
         var _loc6_:Number = this._maximum - this._minimum;
         var _loc1_:Number = this._page == 0?_loc6_ / 10:Number(this._page);
         var _loc2_:* = Number(this.explicitWidth);
         var _loc4_:* = Number(this.explicitHeight);
         if(_loc3_)
         {
            if(this._direction == "vertical")
            {
               _loc2_ = Number(this.thumbOriginalWidth);
            }
            else if(_loc6_ > 0)
            {
               _loc2_ = 0;
            }
            else if(_loc1_ == 0)
            {
               _loc2_ = Number(this.thumbOriginalWidth);
            }
            else
            {
               _loc2_ = Number(this.thumbOriginalWidth * _loc6_ / _loc1_);
               if(_loc2_ < this.thumbOriginalWidth)
               {
                  _loc2_ = Number(this.thumbOriginalWidth);
               }
            }
            _loc2_ = Number(_loc2_ + (this._paddingLeft + this._paddingRight));
         }
         if(_loc5_)
         {
            if(this._direction == "vertical")
            {
               if(_loc6_ > 0)
               {
                  _loc4_ = 0;
               }
               else if(_loc1_ == 0)
               {
                  _loc4_ = Number(this.thumbOriginalHeight);
               }
               else
               {
                  _loc4_ = Number(this.thumbOriginalHeight * _loc6_ / _loc1_);
                  if(_loc4_ < this.thumbOriginalHeight)
                  {
                     _loc4_ = Number(this.thumbOriginalHeight);
                  }
               }
            }
            else
            {
               _loc4_ = Number(this.thumbOriginalHeight);
            }
            _loc4_ = Number(_loc4_ + (this._paddingTop + this._paddingBottom));
         }
         return this.setSizeInternal(_loc2_,_loc4_,false);
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
         this.thumb.isFocusEnabled = false;
         this.thumb.keepDownStateOnRollOut = true;
         this.thumb.addEventListener("touch",thumb_touchHandler);
         this.addChild(this.thumb);
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
      
      protected function layout() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:Number = NaN;
         var _loc5_:* = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:* = NaN;
         var _loc13_:* = NaN;
         var _loc11_:Number = NaN;
         var _loc4_:* = NaN;
         this.track.width = this.actualWidth;
         this.track.height = this.actualHeight;
         var _loc6_:Number = this._maximum - this._minimum;
         this.thumb.visible = _loc6_ > 0;
         if(!this.thumb.visible)
         {
            return;
         }
         this.thumb.validate();
         var _loc14_:Number = this.actualWidth - this._paddingLeft - this._paddingRight;
         var _loc12_:Number = this.actualHeight - this._paddingTop - this._paddingBottom;
         var _loc1_:* = Number(this._page);
         if(this._page == 0)
         {
            _loc1_ = _loc6_;
         }
         else if(_loc6_ < _loc1_)
         {
            _loc1_ = _loc6_;
         }
         var _loc15_:* = 0;
         if(this._value < this._minimum)
         {
            _loc15_ = Number(this._minimum - this._value);
         }
         if(this._value > this._maximum)
         {
            _loc15_ = Number(this._value - this._maximum);
         }
         if(this._direction == "vertical")
         {
            this.thumb.width = this.thumbOriginalWidth;
            _loc2_ = this.thumb.minHeight > 0?this.thumb.minHeight:Number(this.thumbOriginalHeight);
            _loc3_ = Number(_loc12_ * _loc1_ / _loc6_);
            _loc9_ = Number(_loc12_ - _loc3_);
            if(_loc9_ > _loc3_)
            {
               _loc9_ = _loc3_;
            }
            _loc9_ = Number(_loc9_ * (_loc15_ / (_loc6_ * _loc3_ / _loc12_)));
            _loc3_ = Number(_loc3_ - _loc9_);
            if(_loc3_ < _loc2_)
            {
               _loc3_ = _loc2_;
            }
            this.thumb.height = _loc3_;
            this.thumb.x = this._paddingLeft + (this.actualWidth - this._paddingLeft - this._paddingRight - this.thumb.width) / 2;
            _loc10_ = _loc12_ - this.thumb.height;
            _loc5_ = Number(_loc10_ * (this._value - this._minimum) / _loc6_);
            if(_loc5_ > _loc10_)
            {
               _loc5_ = _loc10_;
            }
            else if(_loc5_ < 0)
            {
               _loc5_ = 0;
            }
            this.thumb.y = this._paddingTop + _loc5_;
         }
         else
         {
            _loc7_ = this.thumb.minWidth > 0?this.thumb.minWidth:Number(this.thumbOriginalWidth);
            _loc8_ = Number(_loc14_ * _loc1_ / _loc6_);
            _loc13_ = Number(_loc14_ - _loc8_);
            if(_loc13_ > _loc8_)
            {
               _loc13_ = _loc8_;
            }
            _loc13_ = Number(_loc13_ * (_loc15_ / (_loc6_ * _loc8_ / _loc14_)));
            _loc8_ = Number(_loc8_ - _loc13_);
            if(_loc8_ < _loc7_)
            {
               _loc8_ = _loc7_;
            }
            this.thumb.width = _loc8_;
            this.thumb.height = this.thumbOriginalHeight;
            _loc11_ = _loc14_ - this.thumb.width;
            _loc4_ = Number(_loc11_ * (this._value - this._minimum) / _loc6_);
            if(_loc4_ > _loc11_)
            {
               _loc4_ = _loc11_;
            }
            else if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            this.thumb.x = this._paddingLeft + _loc4_;
            this.thumb.y = this._paddingTop + (this.actualHeight - this._paddingTop - this._paddingBottom - this.thumb.height) / 2;
         }
         this.thumb.validate();
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
            _loc7_ = this.actualHeight - this.thumb.height - this._paddingTop - this._paddingBottom;
            if(_loc7_ > 0)
            {
               _loc3_ = param1.y - this._touchStartY - this._paddingTop;
               _loc6_ = Math.min(Math.max(0,this._thumbStartY + _loc3_),_loc7_);
               _loc5_ = Number(_loc6_ / _loc7_);
            }
         }
         else
         {
            _loc8_ = this.actualWidth - this.thumb.width - this._paddingLeft - this._paddingRight;
            if(_loc8_ > 0)
            {
               _loc4_ = param1.x - this._touchStartX - this._paddingLeft;
               _loc2_ = Math.min(Math.max(0,this._thumbStartX + _loc4_),_loc8_);
               _loc5_ = Number(_loc2_ / _loc8_);
            }
         }
         return this._minimum + _loc5_ * (this._maximum - this._minimum);
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
         if(this._touchPointID >= 0)
         {
            _loc2_ = param1.getTouch(this.track,"ended",this._touchPointID);
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = -1;
            this._repeatTimer.stop();
         }
         else
         {
            _loc2_ = param1.getTouch(this.track,"began");
            if(!_loc2_)
            {
               return;
            }
            this._touchPointID = _loc2_.id;
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

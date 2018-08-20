package feathers.controls.renderers
{
   import feathers.controls.ImageLoader;
   import feathers.controls.Scroller;
   import feathers.controls.ToggleButton;
   import feathers.controls.text.BitmapFontTextRenderer;
   import feathers.core.FeathersControl;
   import feathers.core.IFeathersControl;
   import feathers.core.ITextRenderer;
   import feathers.core.IValidating;
   import feathers.core.PropertyProxy;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class BaseDefaultItemRenderer extends ToggleButton
   {
      
      public static const DEFAULT_CHILD_NAME_ICON_LABEL:String = "feathers-item-renderer-icon-label";
      
      public static const DEFAULT_CHILD_NAME_ACCESSORY_LABEL:String = "feathers-item-renderer-accessory-label";
      
      public static const ICON_POSITION_TOP:String = "top";
      
      public static const ICON_POSITION_RIGHT:String = "right";
      
      public static const ICON_POSITION_BOTTOM:String = "bottom";
      
      public static const ICON_POSITION_LEFT:String = "left";
      
      public static const ICON_POSITION_MANUAL:String = "manual";
      
      public static const ICON_POSITION_LEFT_BASELINE:String = "leftBaseline";
      
      public static const ICON_POSITION_RIGHT_BASELINE:String = "rightBaseline";
      
      public static const HORIZONTAL_ALIGN_LEFT:String = "left";
      
      public static const HORIZONTAL_ALIGN_CENTER:String = "center";
      
      public static const HORIZONTAL_ALIGN_RIGHT:String = "right";
      
      public static const VERTICAL_ALIGN_TOP:String = "top";
      
      public static const VERTICAL_ALIGN_MIDDLE:String = "middle";
      
      public static const VERTICAL_ALIGN_BOTTOM:String = "bottom";
      
      public static const ACCESSORY_POSITION_TOP:String = "top";
      
      public static const ACCESSORY_POSITION_RIGHT:String = "right";
      
      public static const ACCESSORY_POSITION_BOTTOM:String = "bottom";
      
      public static const ACCESSORY_POSITION_LEFT:String = "left";
      
      public static const ACCESSORY_POSITION_MANUAL:String = "manual";
      
      public static const LAYOUT_ORDER_LABEL_ACCESSORY_ICON:String = "labelAccessoryIcon";
      
      public static const LAYOUT_ORDER_LABEL_ICON_ACCESSORY:String = "labelIconAccessory";
      
      private static const HELPER_POINT:Point = new Point();
      
      protected static var DOWN_STATE_DELAY_MS:int = 250;
       
      
      protected var iconLabelName:String = "feathers-item-renderer-icon-label";
      
      protected var accessoryLabelName:String = "feathers-item-renderer-accessory-label";
      
      protected var skinLoader:ImageLoader;
      
      protected var iconLoader:ImageLoader;
      
      protected var iconLabel:ITextRenderer;
      
      protected var accessoryLoader:ImageLoader;
      
      protected var accessoryLabel:ITextRenderer;
      
      protected var accessory:DisplayObject;
      
      protected var _skinIsFromItem:Boolean = false;
      
      protected var _iconIsFromItem:Boolean = false;
      
      protected var _accessoryIsFromItem:Boolean = false;
      
      protected var _data:Object;
      
      protected var _owner:Scroller;
      
      protected var _delayedCurrentState:String;
      
      protected var _stateDelayTimer:Timer;
      
      protected var _useStateDelayTimer:Boolean = true;
      
      protected var isSelectableWithoutToggle:Boolean = true;
      
      protected var _itemHasLabel:Boolean = true;
      
      protected var _itemHasIcon:Boolean = true;
      
      protected var _itemHasAccessory:Boolean = true;
      
      protected var _itemHasSkin:Boolean = false;
      
      protected var _itemHasSelectable:Boolean = false;
      
      protected var _itemHasEnabled:Boolean = false;
      
      protected var _accessoryPosition:String = "right";
      
      protected var _layoutOrder:String = "labelIconAccessory";
      
      protected var _accessoryOffsetX:Number = 0;
      
      protected var _accessoryOffsetY:Number = 0;
      
      protected var _accessoryGap:Number = NaN;
      
      protected var _minAccessoryGap:Number = NaN;
      
      protected var accessoryTouchPointID:int = -1;
      
      protected var _stopScrollingOnAccessoryTouch:Boolean = true;
      
      protected var _isSelectableOnAccessoryTouch:Boolean = false;
      
      protected var _delayTextureCreationOnScroll:Boolean = false;
      
      protected var _labelField:String = "label";
      
      protected var _labelFunction:Function;
      
      protected var _iconField:String = "icon";
      
      protected var _iconFunction:Function;
      
      protected var _iconSourceField:String = "iconSource";
      
      protected var _iconSourceFunction:Function;
      
      protected var _iconLabelField:String = "iconLabel";
      
      protected var _iconLabelFunction:Function;
      
      protected var _accessoryField:String = "accessory";
      
      protected var _accessoryFunction:Function;
      
      protected var _accessorySourceField:String = "accessorySource";
      
      protected var _accessorySourceFunction:Function;
      
      protected var _accessoryLabelField:String = "accessoryLabel";
      
      protected var _accessoryLabelFunction:Function;
      
      protected var _skinField:String = "skin";
      
      protected var _skinFunction:Function;
      
      protected var _skinSourceField:String = "skinSource";
      
      protected var _skinSourceFunction:Function;
      
      protected var _selectableField:String = "selectable";
      
      protected var _selectableFunction:Function;
      
      protected var _enabledField:String = "enabled";
      
      protected var _enabledFunction:Function;
      
      protected var _explicitIsToggle:Boolean = false;
      
      protected var _explicitIsEnabled:Boolean = false;
      
      protected var _iconLoaderFactory:Function;
      
      protected var _iconLabelFactory:Function;
      
      protected var _iconLabelProperties:PropertyProxy;
      
      protected var _accessoryLoaderFactory:Function;
      
      protected var _accessoryLabelFactory:Function;
      
      protected var _accessoryLabelProperties:PropertyProxy;
      
      protected var _skinLoaderFactory:Function;
      
      protected var _ignoreAccessoryResizes:Boolean = false;
      
      public function BaseDefaultItemRenderer()
      {
         _iconLoaderFactory = defaultLoaderFactory;
         _accessoryLoaderFactory = defaultLoaderFactory;
         _skinLoaderFactory = defaultLoaderFactory;
         super();
         this.isFocusEnabled = false;
         this.isQuickHitAreaEnabled = false;
         this.addEventListener("triggered",itemRenderer_triggeredHandler);
      }
      
      protected static function defaultLoaderFactory() : ImageLoader
      {
         return new ImageLoader();
      }
      
      override public function set defaultIcon(param1:DisplayObject) : void
      {
         if(this._iconSelector.defaultValue == param1)
         {
            return;
         }
         this.replaceIcon(null);
         this._iconIsFromItem = false;
         .super.defaultIcon = param1;
      }
      
      override public function set defaultSkin(param1:DisplayObject) : void
      {
         if(this._skinSelector.defaultValue == param1)
         {
            return;
         }
         this.replaceSkin(null);
         this._skinIsFromItem = false;
         .super.defaultSkin = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
         this.invalidate("data");
      }
      
      public function get useStateDelayTimer() : Boolean
      {
         return this._useStateDelayTimer;
      }
      
      public function set useStateDelayTimer(param1:Boolean) : void
      {
         this._useStateDelayTimer = param1;
      }
      
      public function get itemHasLabel() : Boolean
      {
         return this._itemHasLabel;
      }
      
      public function set itemHasLabel(param1:Boolean) : void
      {
         if(this._itemHasLabel == param1)
         {
            return;
         }
         this._itemHasLabel = param1;
         this.invalidate("data");
      }
      
      public function get itemHasIcon() : Boolean
      {
         return this._itemHasIcon;
      }
      
      public function set itemHasIcon(param1:Boolean) : void
      {
         if(this._itemHasIcon == param1)
         {
            return;
         }
         this._itemHasIcon = param1;
         this.invalidate("data");
      }
      
      public function get itemHasAccessory() : Boolean
      {
         return this._itemHasAccessory;
      }
      
      public function set itemHasAccessory(param1:Boolean) : void
      {
         if(this._itemHasAccessory == param1)
         {
            return;
         }
         this._itemHasAccessory = param1;
         this.invalidate("data");
      }
      
      public function get itemHasSkin() : Boolean
      {
         return this._itemHasSkin;
      }
      
      public function set itemHasSkin(param1:Boolean) : void
      {
         if(this._itemHasSkin == param1)
         {
            return;
         }
         this._itemHasSkin = param1;
         this.invalidate("data");
      }
      
      public function get itemHasSelectable() : Boolean
      {
         return this._itemHasSelectable;
      }
      
      public function set itemHasSelectable(param1:Boolean) : void
      {
         if(this._itemHasSelectable == param1)
         {
            return;
         }
         this._itemHasSelectable = param1;
         this.invalidate("data");
      }
      
      public function get itemHasEnabled() : Boolean
      {
         return this._itemHasEnabled;
      }
      
      public function set itemHasEnabled(param1:Boolean) : void
      {
         if(this._itemHasEnabled == param1)
         {
            return;
         }
         this._itemHasEnabled = param1;
         this.invalidate("data");
      }
      
      [Inspectable(type="String",enumeration="top,right,bottom,left,manual")]
      public function get accessoryPosition() : String
      {
         return this._accessoryPosition;
      }
      
      public function set accessoryPosition(param1:String) : void
      {
         if(this._accessoryPosition == param1)
         {
            return;
         }
         this._accessoryPosition = param1;
         this.invalidate("styles");
      }
      
      [Inspectable(type="String",enumeration="labelIconAccessory,labelAccessoryIcon")]
      public function get layoutOrder() : String
      {
         return this._layoutOrder;
      }
      
      public function set layoutOrder(param1:String) : void
      {
         if(this._layoutOrder == param1)
         {
            return;
         }
         this._layoutOrder = param1;
         this.invalidate("styles");
      }
      
      public function get accessoryOffsetX() : Number
      {
         return this._accessoryOffsetX;
      }
      
      public function set accessoryOffsetX(param1:Number) : void
      {
         if(this._accessoryOffsetX == param1)
         {
            return;
         }
         this._accessoryOffsetX = param1;
         this.invalidate("styles");
      }
      
      public function get accessoryOffsetY() : Number
      {
         return this._accessoryOffsetY;
      }
      
      public function set accessoryOffsetY(param1:Number) : void
      {
         if(this._accessoryOffsetY == param1)
         {
            return;
         }
         this._accessoryOffsetY = param1;
         this.invalidate("styles");
      }
      
      public function get accessoryGap() : Number
      {
         return this._accessoryGap;
      }
      
      public function set accessoryGap(param1:Number) : void
      {
         if(this._accessoryGap == param1)
         {
            return;
         }
         this._accessoryGap = param1;
         this.invalidate("styles");
      }
      
      public function get minAccessoryGap() : Number
      {
         return this._minAccessoryGap;
      }
      
      public function set minAccessoryGap(param1:Number) : void
      {
         if(this._minAccessoryGap == param1)
         {
            return;
         }
         this._minAccessoryGap = param1;
         this.invalidate("styles");
      }
      
      override protected function set currentState(param1:String) : void
      {
         if(this._isEnabled && !this._isToggle && (!this.isSelectableWithoutToggle || this._itemHasSelectable && !this.itemToSelectable(this._data)))
         {
            param1 = "up";
         }
         if(this._useStateDelayTimer)
         {
            if(this._stateDelayTimer && this._stateDelayTimer.running)
            {
               this._delayedCurrentState = param1;
               return;
            }
            if(param1 == "down")
            {
               if(this._currentState == param1)
               {
                  return;
               }
               this._delayedCurrentState = param1;
               if(this._stateDelayTimer)
               {
                  this._stateDelayTimer.reset();
               }
               else
               {
                  this._stateDelayTimer = new Timer(DOWN_STATE_DELAY_MS,1);
                  this._stateDelayTimer.addEventListener("timerComplete",stateDelayTimer_timerCompleteHandler);
               }
               this._stateDelayTimer.start();
               return;
            }
         }
         .super.currentState = param1;
      }
      
      public function get stopScrollingOnAccessoryTouch() : Boolean
      {
         return this._stopScrollingOnAccessoryTouch;
      }
      
      public function set stopScrollingOnAccessoryTouch(param1:Boolean) : void
      {
         this._stopScrollingOnAccessoryTouch = param1;
      }
      
      public function get isSelectableOnAccessoryTouch() : Boolean
      {
         return this._isSelectableOnAccessoryTouch;
      }
      
      public function set isSelectableOnAccessoryTouch(param1:Boolean) : void
      {
         this._isSelectableOnAccessoryTouch = param1;
      }
      
      public function get delayTextureCreationOnScroll() : Boolean
      {
         return this._delayTextureCreationOnScroll;
      }
      
      public function set delayTextureCreationOnScroll(param1:Boolean) : void
      {
         this._delayTextureCreationOnScroll = param1;
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      public function set labelField(param1:String) : void
      {
         if(this._labelField == param1)
         {
            return;
         }
         this._labelField = param1;
         this.invalidate("data");
      }
      
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      public function set labelFunction(param1:Function) : void
      {
         if(this._labelFunction == param1)
         {
            return;
         }
         this._labelFunction = param1;
         this.invalidate("data");
      }
      
      public function get iconField() : String
      {
         return this._iconField;
      }
      
      public function set iconField(param1:String) : void
      {
         if(this._iconField == param1)
         {
            return;
         }
         this._iconField = param1;
         this.invalidate("data");
      }
      
      public function get iconFunction() : Function
      {
         return this._iconFunction;
      }
      
      public function set iconFunction(param1:Function) : void
      {
         if(this._iconFunction == param1)
         {
            return;
         }
         this._iconFunction = param1;
         this.invalidate("data");
      }
      
      public function get iconSourceField() : String
      {
         return this._iconSourceField;
      }
      
      public function set iconSourceField(param1:String) : void
      {
         if(this._iconSourceField == param1)
         {
            return;
         }
         this._iconSourceField = param1;
         this.invalidate("data");
      }
      
      public function get iconSourceFunction() : Function
      {
         return this._iconSourceFunction;
      }
      
      public function set iconSourceFunction(param1:Function) : void
      {
         if(this._iconSourceFunction == param1)
         {
            return;
         }
         this._iconSourceFunction = param1;
         this.invalidate("data");
      }
      
      public function get iconLabelField() : String
      {
         return this._iconLabelField;
      }
      
      public function set iconLabelField(param1:String) : void
      {
         if(this._iconLabelField == param1)
         {
            return;
         }
         this._iconLabelField = param1;
         this.invalidate("data");
      }
      
      public function get iconLabelFunction() : Function
      {
         return this._iconLabelFunction;
      }
      
      public function set iconLabelFunction(param1:Function) : void
      {
         if(this._iconLabelFunction == param1)
         {
            return;
         }
         this._iconLabelFunction = param1;
         this.invalidate("data");
      }
      
      public function get accessoryField() : String
      {
         return this._accessoryField;
      }
      
      public function set accessoryField(param1:String) : void
      {
         if(this._accessoryField == param1)
         {
            return;
         }
         this._accessoryField = param1;
         this.invalidate("data");
      }
      
      public function get accessoryFunction() : Function
      {
         return this._accessoryFunction;
      }
      
      public function set accessoryFunction(param1:Function) : void
      {
         if(this._accessoryFunction == param1)
         {
            return;
         }
         this._accessoryFunction = param1;
         this.invalidate("data");
      }
      
      public function get accessorySourceField() : String
      {
         return this._accessorySourceField;
      }
      
      public function set accessorySourceField(param1:String) : void
      {
         if(this._accessorySourceField == param1)
         {
            return;
         }
         this._accessorySourceField = param1;
         this.invalidate("data");
      }
      
      public function get accessorySourceFunction() : Function
      {
         return this._accessorySourceFunction;
      }
      
      public function set accessorySourceFunction(param1:Function) : void
      {
         if(this._accessorySourceFunction == param1)
         {
            return;
         }
         this._accessorySourceFunction = param1;
         this.invalidate("data");
      }
      
      public function get accessoryLabelField() : String
      {
         return this._accessoryLabelField;
      }
      
      public function set accessoryLabelField(param1:String) : void
      {
         if(this._accessoryLabelField == param1)
         {
            return;
         }
         this._accessoryLabelField = param1;
         this.invalidate("data");
      }
      
      public function get accessoryLabelFunction() : Function
      {
         return this._accessoryLabelFunction;
      }
      
      public function set accessoryLabelFunction(param1:Function) : void
      {
         if(this._accessoryLabelFunction == param1)
         {
            return;
         }
         this._accessoryLabelFunction = param1;
         this.invalidate("data");
      }
      
      public function get skinField() : String
      {
         return this._skinField;
      }
      
      public function set skinField(param1:String) : void
      {
         if(this._skinField == param1)
         {
            return;
         }
         this._skinField = param1;
         this.invalidate("data");
      }
      
      public function get skinFunction() : Function
      {
         return this._skinFunction;
      }
      
      public function set skinFunction(param1:Function) : void
      {
         if(this._skinFunction == param1)
         {
            return;
         }
         this._skinFunction = param1;
         this.invalidate("data");
      }
      
      public function get skinSourceField() : String
      {
         return this._skinSourceField;
      }
      
      public function set skinSourceField(param1:String) : void
      {
         if(this._iconSourceField == param1)
         {
            return;
         }
         this._skinSourceField = param1;
         this.invalidate("data");
      }
      
      public function get skinSourceFunction() : Function
      {
         return this._skinSourceFunction;
      }
      
      public function set skinSourceFunction(param1:Function) : void
      {
         if(this._skinSourceFunction == param1)
         {
            return;
         }
         this._skinSourceFunction = param1;
         this.invalidate("data");
      }
      
      public function get selectableField() : String
      {
         return this._selectableField;
      }
      
      public function set selectableField(param1:String) : void
      {
         if(this._selectableField == param1)
         {
            return;
         }
         this._selectableField = param1;
         this.invalidate("data");
      }
      
      public function get selectableFunction() : Function
      {
         return this._selectableFunction;
      }
      
      public function set selectableFunction(param1:Function) : void
      {
         if(this._selectableFunction == param1)
         {
            return;
         }
         this._selectableFunction = param1;
         this.invalidate("data");
      }
      
      public function get enabledField() : String
      {
         return this._enabledField;
      }
      
      public function set enabledField(param1:String) : void
      {
         if(this._enabledField == param1)
         {
            return;
         }
         this._enabledField = param1;
         this.invalidate("data");
      }
      
      public function get enabledFunction() : Function
      {
         return this._enabledFunction;
      }
      
      public function set enabledFunction(param1:Function) : void
      {
         if(this._enabledFunction == param1)
         {
            return;
         }
         this._enabledFunction = param1;
         this.invalidate("data");
      }
      
      override public function set isToggle(param1:Boolean) : void
      {
         if(this._explicitIsToggle == param1)
         {
            return;
         }
         .super.isToggle = param1;
         this._explicitIsToggle = param1;
         this.invalidate("data");
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         if(this._explicitIsEnabled == param1)
         {
            return;
         }
         this._explicitIsEnabled = param1;
         .super.isEnabled = param1;
         this.invalidate("data");
         this.invalidate("state");
      }
      
      public function get iconLoaderFactory() : Function
      {
         return this._iconLoaderFactory;
      }
      
      public function set iconLoaderFactory(param1:Function) : void
      {
         if(this._iconLoaderFactory == param1)
         {
            return;
         }
         this._iconLoaderFactory = param1;
         this._iconIsFromItem = false;
         this.replaceIcon(null);
         this.invalidate("data");
      }
      
      public function get iconLabelFactory() : Function
      {
         return this._iconLabelFactory;
      }
      
      public function set iconLabelFactory(param1:Function) : void
      {
         if(this._iconLabelFactory == param1)
         {
            return;
         }
         this._iconLabelFactory = param1;
         this._iconIsFromItem = false;
         this.replaceIcon(null);
         this.invalidate("data");
      }
      
      public function get iconLabelProperties() : Object
      {
         if(!this._iconLabelProperties)
         {
            this._iconLabelProperties = PropertyProxy.fromEmpty(childProperties_onChange);
         }
         return this._iconLabelProperties;
      }
      
      public function set iconLabelProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._iconLabelProperties == param1)
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
         if(this._iconLabelProperties)
         {
            this._iconLabelProperties.removeOnChangeCallback(childProperties_onChange);
         }
         this._iconLabelProperties = PropertyProxy.asInstance(param1);
         if(this._iconLabelProperties)
         {
            this._iconLabelProperties.addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get accessoryLoaderFactory() : Function
      {
         return this._accessoryLoaderFactory;
      }
      
      public function set accessoryLoaderFactory(param1:Function) : void
      {
         if(this._accessoryLoaderFactory == param1)
         {
            return;
         }
         this._accessoryLoaderFactory = param1;
         this._accessoryIsFromItem = false;
         this.replaceAccessory(null);
         this.invalidate("data");
      }
      
      public function get accessoryLabelFactory() : Function
      {
         return this._accessoryLabelFactory;
      }
      
      public function set accessoryLabelFactory(param1:Function) : void
      {
         if(this._accessoryLabelFactory == param1)
         {
            return;
         }
         this._accessoryLabelFactory = param1;
         this._accessoryIsFromItem = false;
         this.replaceAccessory(null);
         this.invalidate("data");
      }
      
      public function get accessoryLabelProperties() : Object
      {
         if(!this._accessoryLabelProperties)
         {
            this._accessoryLabelProperties = PropertyProxy.fromEmpty(childProperties_onChange);
         }
         return this._accessoryLabelProperties;
      }
      
      public function set accessoryLabelProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._accessoryLabelProperties == param1)
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
         if(this._accessoryLabelProperties)
         {
            this._accessoryLabelProperties.removeOnChangeCallback(childProperties_onChange);
         }
         this._accessoryLabelProperties = PropertyProxy.asInstance(param1);
         if(this._accessoryLabelProperties)
         {
            this._accessoryLabelProperties.addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get skinLoaderFactory() : Function
      {
         return this._skinLoaderFactory;
      }
      
      public function set skinLoaderFactory(param1:Function) : void
      {
         if(this._skinLoaderFactory == param1)
         {
            return;
         }
         this._skinLoaderFactory = param1;
         this._skinIsFromItem = false;
         this.replaceSkin(null);
         this.invalidate("data");
      }
      
      override public function dispose() : void
      {
         if(this._iconIsFromItem)
         {
            this.replaceIcon(null);
         }
         if(this._accessoryIsFromItem)
         {
            this.replaceAccessory(null);
         }
         if(this._skinIsFromItem)
         {
            this.replaceSkin(null);
         }
         if(this._stateDelayTimer)
         {
            if(this._stateDelayTimer.running)
            {
               this._stateDelayTimer.stop();
            }
            this._stateDelayTimer.removeEventListener("timerComplete",stateDelayTimer_timerCompleteHandler);
            this._stateDelayTimer = null;
         }
         super.dispose();
      }
      
      public function itemToLabel(param1:Object) : String
      {
         var _loc2_:* = null;
         if(this._labelFunction != null)
         {
            _loc2_ = this._labelFunction(param1);
            if(_loc2_ is String)
            {
               return _loc2_ as String;
            }
            return _loc2_.toString();
         }
         if(this._labelField != null && param1 && param1.hasOwnProperty(this._labelField))
         {
            _loc2_ = param1[this._labelField];
            if(_loc2_ is String)
            {
               return _loc2_ as String;
            }
            return _loc2_.toString();
         }
         if(param1 is String)
         {
            return param1 as String;
         }
         if(param1)
         {
            return param1.toString();
         }
         return "";
      }
      
      protected function itemToIcon(param1:Object) : DisplayObject
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(this._iconSourceFunction != null)
         {
            _loc2_ = this._iconSourceFunction(param1);
            this.refreshIconSource(_loc2_);
            return this.iconLoader;
         }
         if(this._iconSourceField != null && param1 && param1.hasOwnProperty(this._iconSourceField))
         {
            _loc2_ = param1[this._iconSourceField];
            this.refreshIconSource(_loc2_);
            return this.iconLoader;
         }
         if(this._iconLabelFunction != null)
         {
            _loc3_ = this._iconLabelFunction(param1);
            if(_loc3_ is String)
            {
               this.refreshIconLabel(_loc3_ as String);
            }
            else
            {
               this.refreshIconLabel(_loc3_.toString());
            }
            return DisplayObject(this.iconLabel);
         }
         if(this._iconLabelField != null && param1 && param1.hasOwnProperty(this._iconLabelField))
         {
            _loc3_ = param1[this._iconLabelField];
            if(_loc3_ is String)
            {
               this.refreshIconLabel(_loc3_ as String);
            }
            else
            {
               this.refreshIconLabel(_loc3_.toString());
            }
            return DisplayObject(this.iconLabel);
         }
         if(this._iconFunction != null)
         {
            return this._iconFunction(param1) as DisplayObject;
         }
         if(this._iconField != null && param1 && param1.hasOwnProperty(this._iconField))
         {
            return param1[this._iconField] as DisplayObject;
         }
         return null;
      }
      
      protected function itemToAccessory(param1:Object) : DisplayObject
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(this._accessorySourceFunction != null)
         {
            _loc2_ = this._accessorySourceFunction(param1);
            this.refreshAccessorySource(_loc2_);
            return this.accessoryLoader;
         }
         if(this._accessorySourceField != null && param1 && param1.hasOwnProperty(this._accessorySourceField))
         {
            _loc2_ = param1[this._accessorySourceField];
            this.refreshAccessorySource(_loc2_);
            return this.accessoryLoader;
         }
         if(this._accessoryLabelFunction != null)
         {
            _loc3_ = this._accessoryLabelFunction(param1);
            if(_loc3_ is String)
            {
               this.refreshAccessoryLabel(_loc3_ as String);
            }
            else
            {
               this.refreshAccessoryLabel(_loc3_.toString());
            }
            return DisplayObject(this.accessoryLabel);
         }
         if(this._accessoryLabelField != null && param1 && param1.hasOwnProperty(this._accessoryLabelField))
         {
            _loc3_ = param1[this._accessoryLabelField];
            if(_loc3_ is String)
            {
               this.refreshAccessoryLabel(_loc3_ as String);
            }
            else
            {
               this.refreshAccessoryLabel(_loc3_.toString());
            }
            return DisplayObject(this.accessoryLabel);
         }
         if(this._accessoryFunction != null)
         {
            return this._accessoryFunction(param1) as DisplayObject;
         }
         if(this._accessoryField != null && param1 && param1.hasOwnProperty(this._accessoryField))
         {
            return param1[this._accessoryField] as DisplayObject;
         }
         return null;
      }
      
      protected function itemToSkin(param1:Object) : DisplayObject
      {
         var _loc2_:* = null;
         if(this._skinSourceFunction != null)
         {
            _loc2_ = this._skinSourceFunction(param1);
            this.refreshSkinSource(_loc2_);
            return this.skinLoader;
         }
         if(this._skinSourceField != null && param1 && param1.hasOwnProperty(this._skinSourceField))
         {
            _loc2_ = param1[this._skinSourceField];
            this.refreshSkinSource(_loc2_);
            return this.skinLoader;
         }
         if(this._skinFunction != null)
         {
            return this._skinFunction(param1) as DisplayObject;
         }
         if(this._skinField != null && param1 && param1.hasOwnProperty(this._skinField))
         {
            return param1[this._skinField] as DisplayObject;
         }
         return null;
      }
      
      protected function itemToSelectable(param1:Object) : Boolean
      {
         if(this._selectableFunction != null)
         {
            return this._selectableFunction(param1);
         }
         if(this._selectableField != null && param1 && param1.hasOwnProperty(this._selectableField))
         {
            return param1[this._selectableField] != null;
         }
         return true;
      }
      
      protected function itemToEnabled(param1:Object) : Boolean
      {
         if(this._enabledFunction != null)
         {
            return this._enabledFunction(param1);
         }
         if(this._enabledField != null && param1 && param1.hasOwnProperty(this._enabledField))
         {
            return param1[this._enabledField] != null;
         }
         return true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = this.isInvalid("state");
         var _loc2_:Boolean = this.isInvalid("data");
         var _loc3_:Boolean = this.isInvalid("styles");
         if(_loc2_)
         {
            this.commitData();
         }
         if(_loc1_ || _loc2_ || _loc3_)
         {
            this.refreshAccessory();
         }
         super.draw();
      }
      
      override protected function autoSizeIfNeeded() : Boolean
      {
         var _loc2_:* = this.explicitWidth !== this.explicitWidth;
         var _loc5_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc2_ && !_loc5_)
         {
            return false;
         }
         var _loc4_:Boolean = this._ignoreAccessoryResizes;
         this._ignoreAccessoryResizes = true;
         this.refreshMaxLabelWidth(true);
         if(this.labelTextRenderer)
         {
            this.labelTextRenderer.measureText(HELPER_POINT);
         }
         else
         {
            HELPER_POINT.setTo(0,0);
         }
         var _loc1_:* = Number(this.explicitWidth);
         if(_loc2_)
         {
            if(this._label)
            {
               _loc1_ = Number(HELPER_POINT.x);
            }
            if(this._layoutOrder == "labelAccessoryIcon")
            {
               _loc1_ = Number(this.addAccessoryWidth(_loc1_));
               _loc1_ = Number(this.addIconWidth(_loc1_));
            }
            else
            {
               _loc1_ = Number(this.addIconWidth(_loc1_));
               _loc1_ = Number(this.addAccessoryWidth(_loc1_));
            }
            _loc1_ = Number(_loc1_ + (this._paddingLeft + this._paddingRight));
            if(_loc1_ !== _loc1_)
            {
               _loc1_ = Number(this._originalSkinWidth);
               if(_loc1_ !== _loc1_)
               {
                  _loc1_ = 0;
               }
            }
            else if(this._originalSkinWidth === this._originalSkinWidth)
            {
               if(this._originalSkinWidth > _loc1_)
               {
                  _loc1_ = Number(this._originalSkinWidth);
               }
            }
         }
         var _loc3_:* = Number(this.explicitHeight);
         if(_loc5_)
         {
            if(this._label)
            {
               _loc3_ = Number(HELPER_POINT.y);
            }
            if(this._layoutOrder == "labelAccessoryIcon")
            {
               _loc3_ = Number(this.addAccessoryHeight(_loc3_));
               _loc3_ = Number(this.addIconHeight(_loc3_));
            }
            else
            {
               _loc3_ = Number(this.addIconHeight(_loc3_));
               _loc3_ = Number(this.addAccessoryHeight(_loc3_));
            }
            _loc3_ = Number(_loc3_ + (this._paddingTop + this._paddingBottom));
            if(_loc3_ !== _loc3_)
            {
               _loc3_ = Number(this._originalSkinHeight);
               if(_loc3_ !== _loc3_)
               {
                  _loc3_ = 0;
               }
            }
            else if(this._originalSkinHeight === this._originalSkinHeight)
            {
               if(this._originalSkinHeight > _loc3_)
               {
                  _loc3_ = Number(this._originalSkinHeight);
               }
            }
         }
         this._ignoreAccessoryResizes = _loc4_;
         return this.setSizeInternal(_loc1_,_loc3_,false);
      }
      
      protected function addIconWidth(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(!this.currentIcon)
         {
            return param1;
         }
         var _loc3_:Number = this.currentIcon.width;
         if(_loc3_ !== _loc3_)
         {
            return param1;
         }
         var _loc2_:* = param1 === param1;
         if(!_loc2_)
         {
            param1 = 0;
         }
         if(this._iconPosition == "left" || this._iconPosition == "leftBaseline" || this._iconPosition == "right" || this._iconPosition == "rightBaseline")
         {
            if(_loc2_)
            {
               _loc4_ = this._gap;
               if(this._gap == Infinity)
               {
                  _loc4_ = this._minGap;
               }
               param1 = Number(param1 + _loc4_);
            }
            param1 = Number(param1 + _loc3_);
         }
         else if(_loc3_ > param1)
         {
            param1 = _loc3_;
         }
         return param1;
      }
      
      protected function addAccessoryWidth(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(!this.accessory)
         {
            return param1;
         }
         var _loc3_:Number = this.accessory.width;
         if(_loc3_ !== _loc3_)
         {
            return param1;
         }
         var _loc2_:* = param1 === param1;
         if(!_loc2_)
         {
            param1 = 0;
         }
         if(this._accessoryPosition == "left" || this._accessoryPosition == "right")
         {
            if(_loc2_)
            {
               _loc4_ = this._accessoryGap;
               this.doNothing();
               if(_loc4_ !== _loc4_)
               {
                  _loc4_ = this._gap;
               }
               if(_loc4_ == Infinity)
               {
                  if(this._minAccessoryGap !== this._minAccessoryGap)
                  {
                     _loc4_ = this._minGap;
                  }
                  else
                  {
                     _loc4_ = this._minAccessoryGap;
                  }
               }
               param1 = Number(param1 + _loc4_);
            }
            param1 = Number(param1 + _loc3_);
         }
         else if(_loc3_ > param1)
         {
            param1 = _loc3_;
         }
         return param1;
      }
      
      protected function addIconHeight(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(!this.currentIcon)
         {
            return param1;
         }
         var _loc3_:Number = this.currentIcon.height;
         if(_loc3_ !== _loc3_)
         {
            return param1;
         }
         var _loc2_:* = param1 === param1;
         if(!_loc2_)
         {
            param1 = 0;
         }
         if(this._iconPosition == "top" || this._iconPosition == "bottom")
         {
            if(_loc2_)
            {
               _loc4_ = this._gap;
               if(this._gap == Infinity)
               {
                  _loc4_ = this._minGap;
               }
               param1 = Number(param1 + _loc4_);
            }
            param1 = Number(param1 + _loc3_);
         }
         else if(_loc3_ > param1)
         {
            param1 = _loc3_;
         }
         return param1;
      }
      
      protected function addAccessoryHeight(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         if(!this.accessory)
         {
            return param1;
         }
         var _loc4_:Number = this.accessory.height;
         if(_loc4_ !== _loc4_)
         {
            return param1;
         }
         var _loc2_:* = param1 === param1;
         if(!_loc2_)
         {
            param1 = 0;
         }
         if(this._accessoryPosition == "top" || this._accessoryPosition == "bottom")
         {
            if(_loc2_)
            {
               _loc3_ = this._accessoryGap;
               this.doNothing();
               if(_loc3_ !== _loc3_)
               {
                  _loc3_ = this._gap;
               }
               if(_loc3_ == Infinity)
               {
                  if(this._minAccessoryGap != this._minAccessoryGap)
                  {
                     _loc3_ = this._minGap;
                  }
                  else
                  {
                     _loc3_ = this._minAccessoryGap;
                  }
               }
               param1 = Number(param1 + _loc3_);
            }
            param1 = Number(param1 + _loc4_);
         }
         else if(_loc4_ > param1)
         {
            param1 = _loc4_;
         }
         return param1;
      }
      
      protected function doNothing() : void
      {
      }
      
      protected function commitData() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(this._data && this._owner)
         {
            if(this._itemHasLabel)
            {
               this._label = this.itemToLabel(this._data);
            }
            if(this._itemHasSkin)
            {
               _loc1_ = this.itemToSkin(this._data);
               this._skinIsFromItem = _loc1_ != null;
               this.replaceSkin(_loc1_);
            }
            else if(this._skinIsFromItem)
            {
               this._skinIsFromItem = false;
               this.replaceSkin(null);
            }
            if(this._itemHasIcon)
            {
               _loc3_ = this.itemToIcon(this._data);
               this._iconIsFromItem = _loc3_ != null;
               this.replaceIcon(_loc3_);
            }
            else if(this._iconIsFromItem)
            {
               this._iconIsFromItem = false;
               this.replaceIcon(null);
            }
            if(this._itemHasAccessory)
            {
               _loc2_ = this.itemToAccessory(this._data);
               this._accessoryIsFromItem = _loc2_ != null;
               this.replaceAccessory(_loc2_);
            }
            else if(this._accessoryIsFromItem)
            {
               this._accessoryIsFromItem = false;
               this.replaceAccessory(null);
            }
            if(this._itemHasSelectable)
            {
               this._isToggle = this._explicitIsToggle && this.itemToSelectable(this._data);
            }
            else
            {
               this._isToggle = this._explicitIsToggle;
            }
            if(this._itemHasEnabled)
            {
               this.refreshIsEnabled(this._explicitIsEnabled && this.itemToEnabled(this._data));
            }
            else
            {
               this.refreshIsEnabled(this._explicitIsEnabled);
            }
         }
         else
         {
            if(this._itemHasLabel)
            {
               this._label = "";
            }
            if(this._itemHasIcon || this._iconIsFromItem)
            {
               this._iconIsFromItem = false;
               this.replaceIcon(null);
            }
            if(this._itemHasSkin || this._skinIsFromItem)
            {
               this._skinIsFromItem = false;
               this.replaceSkin(null);
            }
            if(this._itemHasAccessory || this._accessoryIsFromItem)
            {
               this._accessoryIsFromItem = false;
               this.replaceAccessory(null);
            }
            if(this._itemHasSelectable)
            {
               this._isToggle = this._explicitIsToggle;
            }
            if(this._itemHasEnabled)
            {
               this.refreshIsEnabled(this._explicitIsEnabled);
            }
         }
      }
      
      protected function refreshIsEnabled(param1:Boolean) : void
      {
         if(this._isEnabled == param1)
         {
            return;
         }
         this._isEnabled = param1;
         if(!this._isEnabled)
         {
            this.touchable = false;
            this._currentState = "disabled";
            this.touchPointID = -1;
         }
         else
         {
            if(this._currentState == "disabled")
            {
               this._currentState = "up";
            }
            this.touchable = true;
         }
         this.setInvalidationFlag("state");
      }
      
      protected function replaceIcon(param1:DisplayObject) : void
      {
         if(this.iconLoader && this.iconLoader != param1)
         {
            this.iconLoader.removeEventListener("complete",loader_completeOrErrorHandler);
            this.iconLoader.removeEventListener("error",loader_completeOrErrorHandler);
            this.iconLoader.dispose();
            this.iconLoader = null;
         }
         if(this.iconLabel && param1 is ITextRenderer && this.iconLabel != param1 as ITextRenderer)
         {
            this.iconLabel.dispose();
            this.iconLabel = null;
         }
         if(this._itemHasIcon && this.currentIcon && this.currentIcon != param1 && this.currentIcon.parent == this)
         {
            this.currentIcon.removeFromParent(false);
            this.currentIcon = null;
         }
         if(this._iconSelector.defaultValue != param1)
         {
            this._iconSelector.defaultValue = param1;
            this._stateToIconFunction = null;
            this.setInvalidationFlag("styles");
         }
         if(this.iconLoader)
         {
            this.iconLoader.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
         }
      }
      
      protected function replaceAccessory(param1:DisplayObject) : void
      {
         if(this.accessory == param1)
         {
            return;
         }
         if(this.accessory)
         {
            this.accessory.removeEventListener("resize",accessory_resizeHandler);
            this.accessory.removeEventListener("touch",accessory_touchHandler);
            if(this.accessory.parent == this)
            {
               this.accessory.removeFromParent(false);
            }
         }
         if(this.accessoryLabel && DisplayObject(this.accessoryLabel) != param1)
         {
            this.accessoryLabel.dispose();
            this.accessoryLabel = null;
         }
         if(this.accessoryLoader && this.accessoryLoader != param1)
         {
            this.accessoryLoader.removeEventListener("complete",loader_completeOrErrorHandler);
            this.accessoryLoader.removeEventListener("error",loader_completeOrErrorHandler);
            this.accessoryLoader.dispose();
            this.accessoryLoader = null;
         }
         this.accessory = param1;
         if(this.accessory)
         {
            if(this.accessory is IFeathersControl)
            {
               if(!(this.accessory is BitmapFontTextRenderer))
               {
                  this.accessory.addEventListener("touch",accessory_touchHandler);
               }
               this.accessory.addEventListener("resize",accessory_resizeHandler);
            }
            this.addChild(this.accessory);
         }
         if(this.accessoryLoader)
         {
            this.accessoryLoader.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
         }
      }
      
      protected function replaceSkin(param1:DisplayObject) : void
      {
         if(this.skinLoader && this.skinLoader != param1)
         {
            this.skinLoader.removeEventListener("complete",loader_completeOrErrorHandler);
            this.skinLoader.removeEventListener("error",loader_completeOrErrorHandler);
            this.skinLoader.dispose();
            this.skinLoader = null;
         }
         if(this._itemHasSkin && this.currentSkin && this.currentSkin != param1 && this.currentSkin.parent == this)
         {
            this.currentSkin.removeFromParent(false);
            this.currentSkin = null;
         }
         if(this._skinSelector.defaultValue != param1)
         {
            this._skinSelector.defaultValue = param1;
            this._stateToSkinFunction = null;
            this.setInvalidationFlag("styles");
         }
         if(this.skinLoader)
         {
            this.skinLoader.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
         }
      }
      
      override protected function refreshIcon() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         super.refreshIcon();
         if(this.iconLabel)
         {
            _loc1_ = DisplayObject(this.iconLabel);
            var _loc5_:int = 0;
            var _loc4_:* = this._iconLabelProperties;
            for(var _loc2_ in this._iconLabelProperties)
            {
               _loc3_ = this._iconLabelProperties[_loc2_];
               _loc1_[_loc2_] = _loc3_;
            }
         }
      }
      
      protected function refreshAccessory() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         if(this.accessory is IFeathersControl)
         {
            IFeathersControl(this.accessory).isEnabled = this._isEnabled;
         }
         if(this.accessoryLabel)
         {
            _loc1_ = DisplayObject(this.accessoryLabel);
            var _loc5_:int = 0;
            var _loc4_:* = this._accessoryLabelProperties;
            for(var _loc2_ in this._accessoryLabelProperties)
            {
               _loc3_ = this._accessoryLabelProperties[_loc2_];
               _loc1_[_loc2_] = _loc3_;
            }
         }
      }
      
      protected function refreshIconSource(param1:Object) : void
      {
         if(!this.iconLoader)
         {
            this.iconLoader = this._iconLoaderFactory();
            this.iconLoader.addEventListener("complete",loader_completeOrErrorHandler);
            this.iconLoader.addEventListener("error",loader_completeOrErrorHandler);
         }
         this.iconLoader.source = param1;
      }
      
      protected function refreshIconLabel(param1:String) : void
      {
         var _loc2_:* = null;
         if(!this.iconLabel)
         {
            _loc2_ = this._iconLabelFactory != null?this._iconLabelFactory:FeathersControl.defaultTextRendererFactory;
            this.iconLabel = ITextRenderer(_loc2_());
            this.iconLabel.styleNameList.add(this.iconLabelName);
         }
         this.iconLabel.text = param1;
      }
      
      protected function refreshAccessorySource(param1:Object) : void
      {
         if(!this.accessoryLoader)
         {
            this.accessoryLoader = this._accessoryLoaderFactory();
            this.accessoryLoader.addEventListener("complete",loader_completeOrErrorHandler);
            this.accessoryLoader.addEventListener("error",loader_completeOrErrorHandler);
         }
         this.accessoryLoader.source = param1;
      }
      
      protected function refreshAccessoryLabel(param1:String) : void
      {
         var _loc2_:* = null;
         if(!this.accessoryLabel)
         {
            _loc2_ = this._accessoryLabelFactory != null?this._accessoryLabelFactory:FeathersControl.defaultTextRendererFactory;
            this.accessoryLabel = ITextRenderer(_loc2_());
            this.accessoryLabel.styleNameList.add(this.accessoryLabelName);
         }
         this.accessoryLabel.text = param1;
      }
      
      protected function refreshSkinSource(param1:Object) : void
      {
         if(!this.skinLoader)
         {
            this.skinLoader = this._skinLoaderFactory();
            this.skinLoader.addEventListener("complete",loader_completeOrErrorHandler);
            this.skinLoader.addEventListener("error",loader_completeOrErrorHandler);
         }
         this.skinLoader.source = param1;
      }
      
      override protected function layoutContent() : void
      {
         var _loc1_:* = null;
         var _loc6_:* = null;
         var _loc5_:Boolean = this._ignoreAccessoryResizes;
         this._ignoreAccessoryResizes = true;
         this.refreshMaxLabelWidth(false);
         if(this._label && this.labelTextRenderer)
         {
            this.labelTextRenderer.validate();
            _loc1_ = DisplayObject(this.labelTextRenderer);
         }
         var _loc2_:Boolean = this.currentIcon && this._iconPosition != "manual";
         var _loc3_:Boolean = this.accessory && this._accessoryPosition != "manual";
         var _loc4_:Number = this._accessoryGap;
         if(_loc4_ !== _loc4_)
         {
            _loc4_ = this._gap;
         }
         if(this._label && this.labelTextRenderer && _loc2_ && _loc3_)
         {
            this.positionSingleChild(_loc1_);
            if(this._layoutOrder == "labelAccessoryIcon")
            {
               this.positionRelativeToOthers(this.accessory,_loc1_,null,this._accessoryPosition,_loc4_,null,0);
               _loc6_ = this._iconPosition;
               if(_loc6_ == "leftBaseline")
               {
                  _loc6_ = "left";
               }
               else if(_loc6_ == "rightBaseline")
               {
                  _loc6_ = "right";
               }
               this.positionRelativeToOthers(this.currentIcon,_loc1_,this.accessory,_loc6_,this._gap,this._accessoryPosition,_loc4_);
            }
            else
            {
               this.positionLabelAndIcon();
               this.positionRelativeToOthers(this.accessory,_loc1_,this.currentIcon,this._accessoryPosition,_loc4_,this._iconPosition,this._gap);
            }
         }
         else if(this._label && this.labelTextRenderer)
         {
            this.positionSingleChild(_loc1_);
            if(_loc2_)
            {
               this.positionLabelAndIcon();
            }
            else if(_loc3_)
            {
               this.positionRelativeToOthers(this.accessory,_loc1_,null,this._accessoryPosition,_loc4_,null,0);
            }
         }
         else if(_loc2_)
         {
            this.positionSingleChild(this.currentIcon);
            if(_loc3_)
            {
               this.positionRelativeToOthers(this.accessory,this.currentIcon,null,this._accessoryPosition,_loc4_,null,0);
            }
         }
         else if(_loc3_)
         {
            this.positionSingleChild(this.accessory);
         }
         if(this.accessory)
         {
            if(!_loc3_)
            {
               this.accessory.x = this._paddingLeft;
               this.accessory.y = this._paddingTop;
            }
            this.accessory.x = this.accessory.x + this._accessoryOffsetX;
            this.accessory.y = this.accessory.y + this._accessoryOffsetY;
         }
         if(this.currentIcon)
         {
            if(!_loc2_)
            {
               this.currentIcon.x = this._paddingLeft;
               this.currentIcon.y = this._paddingTop;
            }
            this.currentIcon.x = this.currentIcon.x + this._iconOffsetX;
            this.currentIcon.y = this.currentIcon.y + this._iconOffsetY;
         }
         if(this._label && this.labelTextRenderer)
         {
            this.labelTextRenderer.x = this.labelTextRenderer.x + this._labelOffsetX;
            this.labelTextRenderer.y = this.labelTextRenderer.y + this._labelOffsetY;
         }
         this._ignoreAccessoryResizes = _loc5_;
      }
      
      override protected function refreshMaxLabelWidth(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc3_:* = Number(this.actualWidth);
         if(param1)
         {
            _loc3_ = Number(this.explicitWidth);
            if(_loc3_ !== _loc3_)
            {
               _loc3_ = Number(this._maxWidth);
            }
         }
         _loc3_ = Number(_loc3_ - (this._paddingLeft + this._paddingRight));
         var _loc5_:Number = this._gap;
         if(_loc5_ == Infinity)
         {
            _loc5_ = this._minGap;
         }
         var _loc4_:Number = this._accessoryGap;
         if(_loc4_ !== _loc4_)
         {
            _loc4_ = this._gap;
         }
         if(_loc4_ == Infinity)
         {
            _loc4_ = this._minAccessoryGap;
            if(_loc4_ !== _loc4_)
            {
               _loc4_ = this._minGap;
            }
         }
         var _loc6_:Boolean = this.currentIcon && (this._iconPosition == "left" || this._iconPosition == "leftBaseline" || this._iconPosition == "right" || this._iconPosition == "rightBaseline");
         var _loc7_:Boolean = this.accessory && (this._accessoryPosition == "left" || this._accessoryPosition == "right");
         if(this.accessoryLabel)
         {
            _loc2_ = _loc6_ && (_loc7_ || this._layoutOrder == "labelAccessoryIcon");
            if(this.iconLabel)
            {
               this.iconLabel.maxWidth = _loc3_ - _loc5_;
               if(this.iconLabel.maxWidth < 0)
               {
                  this.iconLabel.maxWidth = 0;
               }
            }
            if(this.currentIcon is IValidating)
            {
               IValidating(this.currentIcon).validate();
            }
            if(_loc2_)
            {
               _loc3_ = Number(_loc3_ - (this.currentIcon.width + _loc5_));
            }
            if(_loc7_)
            {
               _loc3_ = Number(_loc3_ - _loc4_);
            }
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            this.accessoryLabel.maxWidth = _loc3_;
            if(this.currentIcon && !_loc2_)
            {
               _loc3_ = Number(_loc3_ - (this.currentIcon.width + _loc5_));
            }
            if(this.accessory is IValidating)
            {
               IValidating(this.accessory).validate();
            }
            if(_loc7_)
            {
               _loc3_ = Number(_loc3_ - this.accessory.width);
            }
         }
         else if(this.iconLabel)
         {
            _loc8_ = _loc7_ && (_loc6_ || this._layoutOrder == "labelIconAccessory");
            if(this.accessory is IValidating)
            {
               IValidating(this.accessory).validate();
            }
            if(_loc8_)
            {
               _loc3_ = Number(_loc3_ - (_loc4_ + this.accessory.width));
            }
            if(_loc6_)
            {
               _loc3_ = Number(_loc3_ - _loc5_);
            }
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            this.iconLabel.maxWidth = _loc3_;
            if(this.accessory && !_loc8_)
            {
               _loc3_ = Number(_loc3_ - (_loc4_ + this.accessory.width));
            }
            if(this.currentIcon is IValidating)
            {
               IValidating(this.currentIcon).validate();
            }
            if(_loc6_)
            {
               _loc3_ = Number(_loc3_ - this.currentIcon.width);
            }
         }
         else
         {
            if(this.currentIcon is IValidating)
            {
               IValidating(this.currentIcon).validate();
            }
            if(_loc6_)
            {
               _loc3_ = Number(_loc3_ - (_loc5_ + this.currentIcon.width));
            }
            if(this.accessory is IValidating)
            {
               IValidating(this.accessory).validate();
            }
            if(_loc7_)
            {
               _loc3_ = Number(_loc3_ - (_loc4_ + this.accessory.width));
            }
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(this.labelTextRenderer)
         {
            this.labelTextRenderer.maxWidth = _loc3_;
         }
      }
      
      protected function positionRelativeToOthers(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject, param4:String, param5:Number, param6:String, param7:Number) : void
      {
         var _loc15_:Number = !!param3?Math.min(param2.x,param3.x):Number(param2.x);
         var _loc14_:Number = !!param3?Math.min(param2.y,param3.y):Number(param2.y);
         var _loc8_:Number = !!param3?Math.max(param2.x + param2.width,param3.x + param3.width) - _loc15_:Number(param2.width);
         var _loc11_:Number = !!param3?Math.max(param2.y + param2.height,param3.y + param3.height) - _loc14_:Number(param2.height);
         var _loc13_:* = _loc15_;
         var _loc12_:* = _loc14_;
         if(param4 == "top")
         {
            if(param5 == Infinity)
            {
               param1.y = this._paddingTop;
               _loc12_ = Number(this.actualHeight - this._paddingBottom - _loc11_);
            }
            else
            {
               if(this._verticalAlign == "top")
               {
                  _loc12_ = Number(_loc12_ + (param1.height + param5));
               }
               else if(this._verticalAlign == "middle")
               {
                  _loc12_ = Number(_loc12_ + Math.round((param1.height + param5) / 2));
               }
               if(param3)
               {
                  _loc12_ = Number(Math.max(_loc12_,this._paddingTop + param1.height + param5));
               }
               param1.y = _loc12_ - param1.height - param5;
            }
         }
         else if(param4 == "right")
         {
            if(param5 == Infinity)
            {
               _loc13_ = Number(this._paddingLeft);
               param1.x = this.actualWidth - this._paddingRight - param1.width;
            }
            else
            {
               if(this._horizontalAlign == "right")
               {
                  _loc13_ = Number(_loc13_ - (param1.width + param5));
               }
               else if(this._horizontalAlign == "center")
               {
                  _loc13_ = Number(_loc13_ - Math.round((param1.width + param5) / 2));
               }
               if(param3)
               {
                  _loc13_ = Number(Math.min(_loc13_,this.actualWidth - this._paddingRight - param1.width - _loc8_ - param5));
               }
               param1.x = _loc13_ + _loc8_ + param5;
            }
         }
         else if(param4 == "bottom")
         {
            if(param5 == Infinity)
            {
               _loc12_ = Number(this._paddingTop);
               param1.y = this.actualHeight - this._paddingBottom - param1.height;
            }
            else
            {
               if(this._verticalAlign == "bottom")
               {
                  _loc12_ = Number(_loc12_ - (param1.height + param5));
               }
               else if(this._verticalAlign == "middle")
               {
                  _loc12_ = Number(_loc12_ - Math.round((param1.height + param5) / 2));
               }
               if(param3)
               {
                  _loc12_ = Number(Math.min(_loc12_,this.actualHeight - this._paddingBottom - param1.height - _loc11_ - param5));
               }
               param1.y = _loc12_ + _loc11_ + param5;
            }
         }
         else if(param4 == "left")
         {
            if(param5 == Infinity)
            {
               param1.x = this._paddingLeft;
               _loc13_ = Number(this.actualWidth - this._paddingRight - _loc8_);
            }
            else
            {
               if(this._horizontalAlign == "left")
               {
                  _loc13_ = Number(_loc13_ + (param5 + param1.width));
               }
               else if(this._horizontalAlign == "center")
               {
                  _loc13_ = Number(_loc13_ + Math.round((param5 + param1.width) / 2));
               }
               if(param3)
               {
                  _loc13_ = Number(Math.max(_loc13_,this._paddingLeft + param1.width + param5));
               }
               param1.x = _loc13_ - param5 - param1.width;
            }
         }
         var _loc9_:Number = _loc13_ - _loc15_;
         var _loc10_:Number = _loc12_ - _loc14_;
         if(!param3 || param7 != Infinity || !(param4 == "top" && param6 == "top" || param4 == "right" && param6 == "right" || param4 == "bottom" && param6 == "bottom" || param4 == "left" && param6 == "left"))
         {
            param2.x = param2.x + _loc9_;
            param2.y = param2.y + _loc10_;
         }
         if(param3)
         {
            if(param7 != Infinity || !(param4 == "left" && param6 == "right" || param4 == "right" && param6 == "left" || param4 == "top" && param6 == "bottom" || param4 == "bottom" && param6 == "top"))
            {
               param3.x = param3.x + _loc9_;
               param3.y = param3.y + _loc10_;
            }
            if(param5 == Infinity && param7 == Infinity)
            {
               if(param4 == "right" && param6 == "left")
               {
                  param2.x = param3.x + Math.round((param1.x - param3.x + param3.width - param2.width) / 2);
               }
               else if(param4 == "left" && param6 == "right")
               {
                  param2.x = param1.x + Math.round((param3.x - param1.x + param1.width - param2.width) / 2);
               }
               else if(param4 == "right" && param6 == "right")
               {
                  param3.x = param2.x + Math.round((param1.x - param2.x + param2.width - param3.width) / 2);
               }
               else if(param4 == "left" && param6 == "left")
               {
                  param3.x = param1.x + Math.round((param2.x - param1.x + param1.width - param3.width) / 2);
               }
               else if(param4 == "bottom" && param6 == "top")
               {
                  param2.y = param3.y + Math.round((param1.y - param3.y + param3.height - param2.height) / 2);
               }
               else if(param4 == "top" && param6 == "bottom")
               {
                  param2.y = param1.y + Math.round((param3.y - param1.y + param1.height - param2.height) / 2);
               }
               else if(param4 == "bottom" && param6 == "bottom")
               {
                  param3.y = param2.y + Math.round((param1.y - param2.y + param2.height - param3.height) / 2);
               }
               else if(param4 == "top" && param6 == "top")
               {
                  param3.y = param1.y + Math.round((param2.y - param1.y + param1.height - param3.height) / 2);
               }
            }
         }
         if(param4 == "left" || param4 == "right")
         {
            if(this._verticalAlign == "top")
            {
               param1.y = this._paddingTop;
            }
            else if(this._verticalAlign == "bottom")
            {
               param1.y = this.actualHeight - this._paddingBottom - param1.height;
            }
            else
            {
               param1.y = this._paddingTop + Math.round((this.actualHeight - this._paddingTop - this._paddingBottom - param1.height) / 2);
            }
         }
         else if(param4 == "top" || param4 == "bottom")
         {
            if(this._horizontalAlign == "left")
            {
               param1.x = this._paddingLeft;
            }
            else if(this._horizontalAlign == "right")
            {
               param1.x = this.actualWidth - this._paddingRight - param1.width;
            }
            else
            {
               param1.x = this._paddingLeft + Math.round((this.actualWidth - this._paddingLeft - this._paddingRight - param1.width) / 2);
            }
         }
      }
      
      protected function owner_scrollStartHandler(param1:Event) : void
      {
         if(this._delayTextureCreationOnScroll)
         {
            if(this.accessoryLoader)
            {
               this.accessoryLoader.delayTextureCreation = true;
            }
            if(this.iconLoader)
            {
               this.iconLoader.delayTextureCreation = true;
            }
         }
         if(this.touchPointID < 0 && this.accessoryTouchPointID < 0)
         {
            return;
         }
         this.resetTouchState();
         if(this._stateDelayTimer && this._stateDelayTimer.running)
         {
            this._stateDelayTimer.stop();
         }
         this._delayedCurrentState = null;
         if(this.accessoryTouchPointID >= 0)
         {
            this._owner.stopScrolling();
         }
      }
      
      protected function owner_scrollCompleteHandler(param1:Event) : void
      {
         if(this._delayTextureCreationOnScroll)
         {
            if(this.accessoryLoader)
            {
               this.accessoryLoader.delayTextureCreation = false;
            }
            if(this.iconLoader)
            {
               this.iconLoader.delayTextureCreation = false;
            }
         }
      }
      
      override protected function button_removedFromStageHandler(param1:Event) : void
      {
         super.button_removedFromStageHandler(param1);
         this.accessoryTouchPointID = -1;
      }
      
      protected function itemRenderer_triggeredHandler(param1:Event) : void
      {
         if(this._isToggle || !this.isSelectableWithoutToggle || this._itemHasSelectable && !this.itemToSelectable(this._data))
         {
            return;
         }
         this.isSelected = true;
      }
      
      protected function stateDelayTimer_timerCompleteHandler(param1:TimerEvent) : void
      {
         .super.currentState = this._delayedCurrentState;
         this._delayedCurrentState = null;
      }
      
      override protected function button_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(this.accessory && !this._isSelectableOnAccessoryTouch && this.accessory != DisplayObject(this.accessoryLabel) && this.accessory != this.accessoryLoader && this.touchPointID < 0)
         {
            _loc2_ = param1.getTouch(this.accessory);
            if(_loc2_)
            {
               this.currentState = "up";
               return;
            }
         }
         super.button_touchHandler(param1);
      }
      
      protected function accessory_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(!this._isEnabled)
         {
            this.accessoryTouchPointID = -1;
            return;
         }
         if(!this._stopScrollingOnAccessoryTouch || this.accessory == DisplayObject(this.accessoryLabel) || this.accessory == this.accessoryLoader)
         {
            return;
         }
         if(this.accessoryTouchPointID >= 0)
         {
            _loc2_ = param1.getTouch(this.accessory,"ended",this.accessoryTouchPointID);
            if(!_loc2_)
            {
               return;
            }
            this.accessoryTouchPointID = -1;
         }
         else
         {
            _loc2_ = param1.getTouch(this.accessory,"began");
            if(!_loc2_)
            {
               return;
            }
            this.accessoryTouchPointID = _loc2_.id;
         }
      }
      
      protected function accessory_resizeHandler(param1:Event) : void
      {
         if(this._ignoreAccessoryResizes)
         {
            return;
         }
         this.invalidate("size");
      }
      
      protected function loader_completeOrErrorHandler(param1:Event) : void
      {
         this.invalidate("size");
      }
   }
}

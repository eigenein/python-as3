package feathers.controls
{
   import feathers.controls.renderers.DefaultListItemRenderer;
   import feathers.controls.supportClasses.ListDataViewPort;
   import feathers.core.IFocusDisplayObject;
   import feathers.core.PropertyProxy;
   import feathers.data.ListCollection;
   import feathers.layout.ILayout;
   import feathers.layout.VerticalLayout;
   import feathers.skins.IStyleProvider;
   import flash.geom.Point;
   import starling.events.Event;
   import starling.events.KeyboardEvent;
   
   [Event(name="change",type="starling.events.Event")]
   [Event(name="rendererAdd",type="starling.events.Event")]
   [Event(name="rendererRemove",type="starling.events.Event")]
   public class List extends Scroller implements IFocusDisplayObject
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      public static const SCROLL_POLICY_AUTO:String = "auto";
      
      public static const SCROLL_POLICY_ON:String = "on";
      
      public static const SCROLL_POLICY_OFF:String = "off";
      
      public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String = "float";
      
      public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String = "fixed";
      
      public static const SCROLL_BAR_DISPLAY_MODE_NONE:String = "none";
      
      public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String = "right";
      
      public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String = "left";
      
      public static const INTERACTION_MODE_TOUCH:String = "touch";
      
      public static const INTERACTION_MODE_MOUSE:String = "mouse";
      
      public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String = "touchAndScrollBars";
      
      public static const DECELERATION_RATE_NORMAL:Number = 0.998;
      
      public static const DECELERATION_RATE_FAST:Number = 0.99;
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var dataViewPort:ListDataViewPort;
      
      protected var _layout:ILayout;
      
      protected var _dataProvider:ListCollection;
      
      protected var _isSelectable:Boolean = true;
      
      protected var _selectedIndex:int = -1;
      
      protected var _allowMultipleSelection:Boolean = false;
      
      protected var _selectedIndices:ListCollection;
      
      protected var _itemRendererType:Class;
      
      protected var _itemRendererFactory:Function;
      
      protected var _typicalItem:Object = null;
      
      protected var _itemRendererName:String;
      
      protected var _itemRendererProperties:PropertyProxy;
      
      protected var pendingItemIndex:int = -1;
      
      public function List()
      {
         _selectedIndices = new ListCollection(new Vector.<int>(0));
         _itemRendererType = DefaultListItemRenderer;
         super();
         this._selectedIndices.addEventListener("change",selectedIndices_changeHandler);
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return List.globalStyleProvider;
      }
      
      override public function get isFocusEnabled() : Boolean
      {
         return this._isSelectable && this._isEnabled && this._isFocusEnabled;
      }
      
      public function get layout() : ILayout
      {
         return this._layout;
      }
      
      public function set layout(param1:ILayout) : void
      {
         if(this._layout == param1)
         {
            return;
         }
         this._layout = param1;
         this.invalidate("layout");
      }
      
      public function get dataProvider() : ListCollection
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:ListCollection) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         if(this._dataProvider)
         {
            this._dataProvider.removeEventListener("reset",dataProvider_resetHandler);
            this._dataProvider.removeEventListener("change",dataProvider_changeHandler);
         }
         this._dataProvider = param1;
         if(this._dataProvider)
         {
            this._dataProvider.addEventListener("reset",dataProvider_resetHandler);
            this._dataProvider.addEventListener("change",dataProvider_changeHandler);
         }
         this.horizontalScrollPosition = 0;
         this.verticalScrollPosition = 0;
         this.selectedIndex = -1;
         this.invalidate("data");
      }
      
      public function get isSelectable() : Boolean
      {
         return this._isSelectable;
      }
      
      public function set isSelectable(param1:Boolean) : void
      {
         if(this._isSelectable == param1)
         {
            return;
         }
         this._isSelectable = param1;
         if(!this._isSelectable)
         {
            this.selectedIndex = -1;
         }
         this.invalidate("selected");
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this._selectedIndex == param1)
         {
            return;
         }
         if(param1 >= 0)
         {
            this._selectedIndices.data = new <int>[param1];
         }
         else
         {
            this._selectedIndices.removeAll();
         }
         this.invalidate("selected");
      }
      
      public function get selectedItem() : Object
      {
         if(!this._dataProvider || this._selectedIndex < 0 || this._selectedIndex >= this._dataProvider.length)
         {
            return null;
         }
         return this._dataProvider.getItemAt(this._selectedIndex);
      }
      
      public function set selectedItem(param1:Object) : void
      {
         if(!this._dataProvider)
         {
            this.selectedIndex = -1;
            return;
         }
         this.selectedIndex = this._dataProvider.getItemIndex(param1);
      }
      
      public function get allowMultipleSelection() : Boolean
      {
         return this._allowMultipleSelection;
      }
      
      public function set allowMultipleSelection(param1:Boolean) : void
      {
         if(this._allowMultipleSelection == param1)
         {
            return;
         }
         this._allowMultipleSelection = param1;
         this.invalidate("selected");
      }
      
      public function get selectedIndices() : Vector.<int>
      {
         return this._selectedIndices.data as Vector.<int>;
      }
      
      public function set selectedIndices(param1:Vector.<int>) : void
      {
         var _loc2_:Vector.<int> = this._selectedIndices.data as Vector.<int>;
         if(_loc2_ == param1)
         {
            return;
         }
         if(!param1)
         {
            if(this._selectedIndices.length == 0)
            {
               return;
            }
            this._selectedIndices.removeAll();
         }
         else
         {
            if(!this._allowMultipleSelection && param1.length > 0)
            {
               param1.length = 1;
            }
            this._selectedIndices.data = param1;
         }
         this.invalidate("selected");
      }
      
      public function get selectedItems() : Vector.<Object>
      {
         return this.getSelectedItems(new Vector.<Object>(0));
      }
      
      public function set selectedItems(param1:Vector.<Object>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(!param1 || !this._dataProvider)
         {
            this.selectedIndex = -1;
            return;
         }
         var _loc2_:Vector.<int> = new Vector.<int>(0);
         var _loc6_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc3_ = param1[_loc4_];
            _loc5_ = this._dataProvider.getItemIndex(_loc3_);
            if(_loc5_ >= 0)
            {
               _loc2_.push(_loc5_);
            }
            _loc4_++;
         }
         this.selectedIndices = _loc2_;
      }
      
      public function getSelectedItems(param1:Vector.<Object> = null) : Vector.<Object>
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         if(param1)
         {
            param1.length = 0;
         }
         else
         {
            param1 = new Vector.<Object>(0);
         }
         if(!this._dataProvider)
         {
            return param1;
         }
         var _loc3_:int = this._selectedIndices.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._selectedIndices.getItemAt(_loc4_) as int;
            _loc2_ = this._dataProvider.getItemAt(_loc5_);
            param1[_loc4_] = _loc2_;
            _loc4_++;
         }
         return param1;
      }
      
      public function get itemRendererType() : Class
      {
         return this._itemRendererType;
      }
      
      public function set itemRendererType(param1:Class) : void
      {
         if(this._itemRendererType == param1)
         {
            return;
         }
         this._itemRendererType = param1;
         this.invalidate("styles");
      }
      
      public function get itemRendererFactory() : Function
      {
         return this._itemRendererFactory;
      }
      
      public function set itemRendererFactory(param1:Function) : void
      {
         if(this._itemRendererFactory === param1)
         {
            return;
         }
         this._itemRendererFactory = param1;
         this.invalidate("styles");
      }
      
      public function get typicalItem() : Object
      {
         return this._typicalItem;
      }
      
      public function set typicalItem(param1:Object) : void
      {
         if(this._typicalItem == param1)
         {
            return;
         }
         this._typicalItem = param1;
         this.invalidate("data");
      }
      
      public function get itemRendererName() : String
      {
         return this._itemRendererName;
      }
      
      public function set itemRendererName(param1:String) : void
      {
         if(this._itemRendererName == param1)
         {
            return;
         }
         this._itemRendererName = param1;
         this.invalidate("styles");
      }
      
      public function get itemRendererProperties() : Object
      {
         if(!this._itemRendererProperties)
         {
            this._itemRendererProperties = PropertyProxy.fromEmpty(childProperties_onChange);
         }
         return this._itemRendererProperties;
      }
      
      public function set itemRendererProperties(param1:Object) : void
      {
         var _loc2_:* = null;
         if(this._itemRendererProperties == param1)
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
         if(this._itemRendererProperties)
         {
            this._itemRendererProperties.removeOnChangeCallback(childProperties_onChange);
         }
         this._itemRendererProperties = PropertyProxy.asInstance(param1);
         if(this._itemRendererProperties)
         {
            this._itemRendererProperties.addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      override public function scrollToPosition(param1:Number, param2:Number, param3:Number = NaN) : void
      {
         this.pendingItemIndex = -1;
         super.scrollToPosition(param1,param2,param3);
      }
      
      override public function scrollToPageIndex(param1:int, param2:int, param3:Number = NaN) : void
      {
         this.pendingItemIndex = -1;
         super.scrollToPageIndex(param1,param2,param3);
      }
      
      public function scrollToDisplayIndex(param1:int, param2:Number = 0) : void
      {
         this.pendingHorizontalPageIndex = -1;
         this.pendingVerticalPageIndex = -1;
         this.pendingHorizontalScrollPosition = NaN;
         this.pendingVerticalScrollPosition = NaN;
         if(this.pendingItemIndex == param1 && this.pendingScrollDuration == param2)
         {
            return;
         }
         this.pendingItemIndex = param1;
         this.pendingScrollDuration = param2;
         this.invalidate("pendingScroll");
      }
      
      override public function dispose() : void
      {
         this._selectedIndices.removeEventListeners();
         this._selectedIndex = -1;
         this.dataProvider = null;
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = this._layout != null;
         super.initialize();
         if(!this.dataViewPort)
         {
            var _loc3_:* = new ListDataViewPort();
            this.dataViewPort = _loc3_;
            this.viewPort = _loc3_;
            this.dataViewPort.owner = this;
            this.viewPort = this.dataViewPort;
         }
         if(!_loc2_)
         {
            if(this._hasElasticEdges && this._verticalScrollPolicy == "auto" && this._scrollBarDisplayMode != "fixed")
            {
               this.verticalScrollPolicy = "on";
            }
            _loc1_ = new VerticalLayout();
            _loc1_.useVirtualLayout = true;
            _loc3_ = 0;
            _loc1_.paddingLeft = _loc3_;
            _loc3_ = _loc3_;
            _loc1_.paddingBottom = _loc3_;
            _loc3_ = _loc3_;
            _loc1_.paddingRight = _loc3_;
            _loc1_.paddingTop = _loc3_;
            _loc1_.gap = 0;
            _loc1_.horizontalAlign = "justify";
            _loc1_.verticalAlign = "top";
            this._layout = _loc1_;
         }
      }
      
      override protected function draw() : void
      {
         this.refreshDataViewPortProperties();
         super.draw();
         this.refreshFocusIndicator();
      }
      
      protected function refreshDataViewPortProperties() : void
      {
         this.dataViewPort.isSelectable = this._isSelectable;
         this.dataViewPort.allowMultipleSelection = this._allowMultipleSelection;
         this.dataViewPort.selectedIndices = this._selectedIndices;
         this.dataViewPort.dataProvider = this._dataProvider;
         this.dataViewPort.itemRendererType = this._itemRendererType;
         this.dataViewPort.itemRendererFactory = this._itemRendererFactory;
         this.dataViewPort.itemRendererProperties = this._itemRendererProperties;
         this.dataViewPort.itemRendererName = this._itemRendererName;
         this.dataViewPort.typicalItem = this._typicalItem;
         this.dataViewPort.layout = this._layout;
      }
      
      override protected function handlePendingScroll() : void
      {
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.pendingItemIndex >= 0)
         {
            _loc1_ = this._dataProvider.getItemAt(this.pendingItemIndex);
            if(_loc1_ is Object)
            {
               this.dataViewPort.getScrollPositionForIndex(this.pendingItemIndex,HELPER_POINT);
               this.pendingItemIndex = -1;
               _loc2_ = HELPER_POINT.x;
               if(_loc2_ < this._minHorizontalScrollPosition)
               {
                  _loc2_ = this._minHorizontalScrollPosition;
               }
               else if(_loc2_ > this._maxHorizontalScrollPosition)
               {
                  _loc2_ = this._maxHorizontalScrollPosition;
               }
               _loc3_ = HELPER_POINT.y;
               if(_loc3_ < this._minVerticalScrollPosition)
               {
                  _loc3_ = this._minVerticalScrollPosition;
               }
               else if(_loc3_ > this._maxVerticalScrollPosition)
               {
                  _loc3_ = this._maxVerticalScrollPosition;
               }
               this.throwTo(_loc2_,_loc3_,this.pendingScrollDuration);
            }
         }
         super.handlePendingScroll();
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
      
      protected function stage_keyDownHandler(param1:KeyboardEvent) : void
      {
         if(!this._dataProvider)
         {
            return;
         }
         if(param1.keyCode == 36)
         {
            if(this._dataProvider.length > 0)
            {
               this.selectedIndex = 0;
            }
         }
         else if(param1.keyCode == 35)
         {
            this.selectedIndex = this._dataProvider.length - 1;
         }
         else if(param1.keyCode == 38)
         {
            this.selectedIndex = Math.max(0,this._selectedIndex - 1);
         }
         else if(param1.keyCode == 40)
         {
            this.selectedIndex = Math.min(this._dataProvider.length - 1,this._selectedIndex + 1);
         }
      }
      
      protected function dataProvider_changeHandler(param1:Event) : void
      {
         this.invalidate("data");
      }
      
      protected function dataProvider_resetHandler(param1:Event) : void
      {
         this.horizontalScrollPosition = 0;
         this.verticalScrollPosition = 0;
      }
      
      protected function selectedIndices_changeHandler(param1:Event) : void
      {
         if(this._selectedIndices.length > 0)
         {
            this._selectedIndex = this._selectedIndices.getItemAt(0) as int;
         }
         else
         {
            if(this._selectedIndex < 0)
            {
               return;
            }
            this._selectedIndex = -1;
         }
         this.dispatchEventWith("change");
      }
   }
}

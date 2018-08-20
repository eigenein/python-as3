package feathers.controls.supportClasses
{
   import feathers.controls.List;
   import feathers.controls.Scroller;
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.core.FeathersControl;
   import feathers.core.IFeathersControl;
   import feathers.core.PropertyProxy;
   import feathers.data.ListCollection;
   import feathers.layout.ILayout;
   import feathers.layout.ITrimmedVirtualLayout;
   import feathers.layout.IVariableVirtualLayout;
   import feathers.layout.IVirtualLayout;
   import feathers.layout.LayoutBoundsResult;
   import feathers.layout.ViewPortBounds;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class ListDataViewPort extends FeathersControl implements IViewPort
   {
      
      private static const INVALIDATION_FLAG_ITEM_RENDERER_FACTORY:String = "itemRendererFactory";
      
      private static const HELPER_POINT:Point = new Point();
      
      private static const HELPER_VECTOR:Vector.<int> = new Vector.<int>(0);
       
      
      private var touchPointID:int = -1;
      
      private var _viewPortBounds:ViewPortBounds;
      
      private var _layoutResult:LayoutBoundsResult;
      
      private var _minVisibleWidth:Number = 0;
      
      private var _maxVisibleWidth:Number = Infinity;
      
      private var actualVisibleWidth:Number = 0;
      
      private var explicitVisibleWidth:Number = NaN;
      
      private var _minVisibleHeight:Number = 0;
      
      private var _maxVisibleHeight:Number = Infinity;
      
      private var actualVisibleHeight:Number = 0;
      
      private var explicitVisibleHeight:Number = NaN;
      
      protected var _contentX:Number = 0;
      
      protected var _contentY:Number = 0;
      
      private var _typicalItemIsInDataProvider:Boolean = false;
      
      private var _typicalItemRenderer:IListItemRenderer;
      
      private var _unrenderedData:Array;
      
      private var _layoutItems:Vector.<DisplayObject>;
      
      private var _inactiveRenderers:Vector.<IListItemRenderer>;
      
      private var _activeRenderers:Vector.<IListItemRenderer>;
      
      private var _rendererMap:Dictionary;
      
      private var _layoutIndexOffset:int = 0;
      
      private var _isScrolling:Boolean = false;
      
      private var _owner:List;
      
      private var _updateForDataReset:Boolean = false;
      
      private var _dataProvider:ListCollection;
      
      private var _itemRendererType:Class;
      
      private var _itemRendererFactory:Function;
      
      private var _itemRendererName:String;
      
      private var _typicalItem:Object = null;
      
      private var _itemRendererProperties:PropertyProxy;
      
      private var _ignoreLayoutChanges:Boolean = false;
      
      private var _ignoreRendererResizing:Boolean = false;
      
      private var _layout:ILayout;
      
      private var _horizontalScrollPosition:Number = 0;
      
      private var _verticalScrollPosition:Number = 0;
      
      private var _ignoreSelectionChanges:Boolean = false;
      
      private var _isSelectable:Boolean = true;
      
      private var _allowMultipleSelection:Boolean = false;
      
      private var _selectedIndices:ListCollection;
      
      public function ListDataViewPort()
      {
         _viewPortBounds = new ViewPortBounds();
         _layoutResult = new LayoutBoundsResult();
         _unrenderedData = [];
         _layoutItems = new Vector.<DisplayObject>(0);
         _inactiveRenderers = new Vector.<IListItemRenderer>(0);
         _activeRenderers = new Vector.<IListItemRenderer>(0);
         _rendererMap = new Dictionary(true);
         super();
         this.addEventListener("removedFromStage",removedFromStageHandler);
         this.addEventListener("touch",touchHandler);
      }
      
      public function get minVisibleWidth() : Number
      {
         return this._minVisibleWidth;
      }
      
      public function set minVisibleWidth(param1:Number) : void
      {
         if(this._minVisibleWidth == param1)
         {
            return;
         }
         if(param1 !== param1)
         {
            throw new ArgumentError("minVisibleWidth cannot be NaN");
         }
         this._minVisibleWidth = param1;
         this.invalidate("size");
      }
      
      public function get maxVisibleWidth() : Number
      {
         return this._maxVisibleWidth;
      }
      
      public function set maxVisibleWidth(param1:Number) : void
      {
         if(this._maxVisibleWidth == param1)
         {
            return;
         }
         if(param1 !== param1)
         {
            throw new ArgumentError("maxVisibleWidth cannot be NaN");
         }
         this._maxVisibleWidth = param1;
         this.invalidate("size");
      }
      
      public function get visibleWidth() : Number
      {
         return this.actualVisibleWidth;
      }
      
      public function set visibleWidth(param1:Number) : void
      {
         if(this.explicitVisibleWidth == param1 || param1 !== param1 && this.explicitVisibleWidth !== this.explicitVisibleWidth)
         {
            return;
         }
         this.explicitVisibleWidth = param1;
         this.invalidate("size");
      }
      
      public function get minVisibleHeight() : Number
      {
         return this._minVisibleHeight;
      }
      
      public function set minVisibleHeight(param1:Number) : void
      {
         if(this._minVisibleHeight == param1)
         {
            return;
         }
         if(param1 !== param1)
         {
            throw new ArgumentError("minVisibleHeight cannot be NaN");
         }
         this._minVisibleHeight = param1;
         this.invalidate("size");
      }
      
      public function get maxVisibleHeight() : Number
      {
         return this._maxVisibleHeight;
      }
      
      public function set maxVisibleHeight(param1:Number) : void
      {
         if(this._maxVisibleHeight == param1)
         {
            return;
         }
         if(param1 !== param1)
         {
            throw new ArgumentError("maxVisibleHeight cannot be NaN");
         }
         this._maxVisibleHeight = param1;
         this.invalidate("size");
      }
      
      public function get visibleHeight() : Number
      {
         return this.actualVisibleHeight;
      }
      
      public function set visibleHeight(param1:Number) : void
      {
         if(this.explicitVisibleHeight == param1 || param1 !== param1 && this.explicitVisibleHeight !== this.explicitVisibleHeight)
         {
            return;
         }
         this.explicitVisibleHeight = param1;
         this.invalidate("size");
      }
      
      public function get contentX() : Number
      {
         return this._contentX;
      }
      
      public function get contentY() : Number
      {
         return this._contentY;
      }
      
      public function get owner() : List
      {
         return this._owner;
      }
      
      public function set owner(param1:List) : void
      {
         if(this._owner == param1)
         {
            return;
         }
         if(this._owner)
         {
            this._owner.removeEventListener("scrollStart",owner_scrollStartHandler);
         }
         this._owner = param1;
         if(this._owner)
         {
            this._owner.addEventListener("scrollStart",owner_scrollStartHandler);
         }
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
            this._dataProvider.removeEventListener("change",dataProvider_changeHandler);
            this._dataProvider.removeEventListener("reset",dataProvider_resetHandler);
            this._dataProvider.removeEventListener("addItem",dataProvider_addItemHandler);
            this._dataProvider.removeEventListener("removeItem",dataProvider_removeItemHandler);
            this._dataProvider.removeEventListener("replaceItem",dataProvider_replaceItemHandler);
            this._dataProvider.removeEventListener("updateItem",dataProvider_updateItemHandler);
         }
         this._dataProvider = param1;
         if(this._dataProvider)
         {
            this._dataProvider.addEventListener("change",dataProvider_changeHandler);
            this._dataProvider.addEventListener("reset",dataProvider_resetHandler);
            this._dataProvider.addEventListener("addItem",dataProvider_addItemHandler);
            this._dataProvider.addEventListener("removeItem",dataProvider_removeItemHandler);
            this._dataProvider.addEventListener("replaceItem",dataProvider_replaceItemHandler);
            this._dataProvider.addEventListener("updateItem",dataProvider_updateItemHandler);
         }
         if(this._layout is IVariableVirtualLayout)
         {
            IVariableVirtualLayout(this._layout).resetVariableVirtualCache();
         }
         this._updateForDataReset = true;
         this.invalidate("data");
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
         this.invalidate("itemRendererFactory");
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
         this.invalidate("itemRendererFactory");
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
         this.invalidate("itemRendererFactory");
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
      
      public function get itemRendererProperties() : PropertyProxy
      {
         return this._itemRendererProperties;
      }
      
      public function set itemRendererProperties(param1:PropertyProxy) : void
      {
         if(this._itemRendererProperties == param1)
         {
            return;
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
         if(this._layout)
         {
            EventDispatcher(this._layout).removeEventListener("change",layout_changeHandler);
         }
         this._layout = param1;
         if(this._layout)
         {
            if(this._layout is IVariableVirtualLayout)
            {
               IVariableVirtualLayout(this._layout).resetVariableVirtualCache();
            }
            EventDispatcher(this._layout).addEventListener("change",layout_changeHandler);
         }
         this.invalidate("layout");
      }
      
      public function get horizontalScrollStep() : Number
      {
         if(this._activeRenderers.length == 0)
         {
            return 0;
         }
         var _loc1_:IListItemRenderer = this._activeRenderers[0];
         var _loc2_:Number = _loc1_.width;
         var _loc3_:Number = _loc1_.height;
         if(_loc2_ < _loc3_)
         {
            return _loc2_;
         }
         return _loc3_;
      }
      
      public function get verticalScrollStep() : Number
      {
         if(this._activeRenderers.length == 0)
         {
            return 0;
         }
         var _loc1_:IListItemRenderer = this._activeRenderers[0];
         var _loc2_:Number = _loc1_.width;
         var _loc3_:Number = _loc1_.height;
         if(_loc2_ < _loc3_)
         {
            return _loc2_;
         }
         return _loc3_;
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return this._horizontalScrollPosition;
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
         if(this._horizontalScrollPosition == param1)
         {
            return;
         }
         this._horizontalScrollPosition = param1;
         this.invalidate("scroll");
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._verticalScrollPosition;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         if(this._verticalScrollPosition == param1)
         {
            return;
         }
         this._verticalScrollPosition = param1;
         this.invalidate("scroll");
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
         if(!param1)
         {
            this.selectedIndices = null;
         }
      }
      
      public function get allowMultipleSelection() : Boolean
      {
         return this._allowMultipleSelection;
      }
      
      public function set allowMultipleSelection(param1:Boolean) : void
      {
         this._allowMultipleSelection = param1;
      }
      
      public function get selectedIndices() : ListCollection
      {
         return this._selectedIndices;
      }
      
      public function set selectedIndices(param1:ListCollection) : void
      {
         if(this._selectedIndices == param1)
         {
            return;
         }
         if(this._selectedIndices)
         {
            this._selectedIndices.removeEventListener("change",selectedIndices_changeHandler);
         }
         this._selectedIndices = param1;
         if(this._selectedIndices)
         {
            this._selectedIndices.addEventListener("change",selectedIndices_changeHandler);
         }
         this.invalidate("selected");
      }
      
      public function getScrollPositionForIndex(param1:int, param2:Point = null) : Point
      {
         if(!param2)
         {
            param2 = new Point();
         }
         return this._layout.getScrollPositionForIndex(param1,this._layoutItems,0,0,this.actualVisibleWidth,this.actualVisibleHeight,param2);
      }
      
      override public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function draw() : void
      {
         var _loc12_:Boolean = false;
         var _loc7_:Boolean = this.isInvalid("data");
         var _loc10_:Boolean = this.isInvalid("scroll");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc5_:Boolean = this.isInvalid("selected");
         var _loc2_:Boolean = this.isInvalid("itemRendererFactory");
         var _loc8_:Boolean = this.isInvalid("styles");
         var _loc4_:Boolean = this.isInvalid("state");
         var _loc3_:Boolean = this.isInvalid("layout");
         if(!_loc3_ && _loc10_ && this._layout && this._layout.requiresLayoutOnScroll)
         {
            _loc3_ = true;
         }
         var _loc6_:Boolean = _loc1_ || _loc7_ || _loc3_ || _loc2_;
         var _loc9_:Boolean = this._ignoreRendererResizing;
         this._ignoreRendererResizing = true;
         var _loc11_:Boolean = this._ignoreLayoutChanges;
         this._ignoreLayoutChanges = true;
         if(_loc10_ || _loc1_)
         {
            this.refreshViewPortBounds();
         }
         if(_loc6_)
         {
            this.refreshInactiveRenderers(_loc2_);
         }
         if(_loc7_ || _loc3_ || _loc2_)
         {
            this.refreshLayoutTypicalItem();
         }
         if(_loc6_)
         {
            this.refreshRenderers();
         }
         if(_loc8_ || _loc6_)
         {
            this.refreshItemRendererStyles();
         }
         if(_loc5_ || _loc6_)
         {
            _loc12_ = this._ignoreSelectionChanges;
            this._ignoreSelectionChanges = true;
            this.refreshSelection();
            this._ignoreSelectionChanges = _loc12_;
         }
         if(_loc4_ || _loc6_)
         {
            this.refreshEnabled();
         }
         this._ignoreLayoutChanges = _loc11_;
         if(_loc4_ || _loc5_ || _loc8_ || _loc6_)
         {
            if(this._layout)
            {
               this._layout.layout(this._layoutItems,this._viewPortBounds,this._layoutResult);
            }
            else
            {
               return;
            }
         }
         this._ignoreRendererResizing = _loc9_;
         this._contentX = this._layoutResult.contentX;
         this._contentY = this._layoutResult.contentY;
         this.setSizeInternal(this._layoutResult.contentWidth,this._layoutResult.contentHeight,false);
         this.actualVisibleWidth = this._layoutResult.viewPortWidth;
         this.actualVisibleHeight = this._layoutResult.viewPortHeight;
         this.validateItemRenderers();
      }
      
      private function invalidateParent(param1:String = "all") : void
      {
         Scroller(this.parent).invalidate(param1);
      }
      
      private function validateItemRenderers() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = this._activeRenderers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._activeRenderers[_loc3_];
            _loc2_.validate();
            _loc3_++;
         }
      }
      
      private function refreshLayoutTypicalItem() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = false;
         var _loc6_:IVirtualLayout = this._layout as IVirtualLayout;
         if(!_loc6_ || !_loc6_.useVirtualLayout)
         {
            if(!this._typicalItemIsInDataProvider && this._typicalItemRenderer)
            {
               this.destroyRenderer(this._typicalItemRenderer);
               this._typicalItemRenderer = null;
            }
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = false;
         var _loc1_:Object = this._typicalItem;
         if(_loc1_)
         {
            if(this._dataProvider)
            {
               _loc3_ = this._dataProvider.getItemIndex(_loc1_);
               _loc2_ = _loc3_ >= 0;
            }
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
         }
         else
         {
            _loc2_ = true;
            if(this._dataProvider && this._dataProvider.length > 0)
            {
               _loc1_ = this._dataProvider.getItemAt(0);
            }
         }
         if(_loc1_)
         {
            _loc4_ = IListItemRenderer(this._rendererMap[_loc1_]);
            if(!_loc4_ && this._typicalItemRenderer)
            {
               _loc5_ = !this._typicalItemIsInDataProvider;
               if(!_loc5_)
               {
                  _loc5_ = this._dataProvider.getItemIndex(this._typicalItemRenderer.data) < 0;
               }
               if(_loc5_)
               {
                  if(this._typicalItemIsInDataProvider)
                  {
                     delete this._rendererMap[this._typicalItemRenderer.data];
                  }
                  _loc4_ = this._typicalItemRenderer;
                  _loc4_.data = _loc1_;
                  _loc4_.index = _loc3_;
                  if(_loc2_)
                  {
                     this._rendererMap[_loc1_] = _loc4_;
                  }
               }
            }
            if(!_loc4_)
            {
               _loc4_ = this.createRenderer(_loc1_,_loc3_,false,!_loc2_);
               if(!this._typicalItemIsInDataProvider && this._typicalItemRenderer)
               {
                  this.destroyRenderer(this._typicalItemRenderer);
                  this._typicalItemRenderer = null;
               }
            }
         }
         _loc6_.typicalItem = DisplayObject(_loc4_);
         this._typicalItemRenderer = _loc4_;
         this._typicalItemIsInDataProvider = _loc2_;
      }
      
      private function refreshItemRendererStyles() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = this._activeRenderers;
         for each(var _loc1_ in this._activeRenderers)
         {
            this.refreshOneItemRendererStyles(_loc1_);
         }
      }
      
      private function refreshOneItemRendererStyles(param1:IListItemRenderer) : void
      {
         var _loc4_:* = null;
         var _loc2_:DisplayObject = DisplayObject(param1);
         var _loc6_:int = 0;
         var _loc5_:* = this._itemRendererProperties;
         for(var _loc3_ in this._itemRendererProperties)
         {
            _loc4_ = this._itemRendererProperties[_loc3_];
            _loc2_[_loc3_] = _loc4_;
         }
      }
      
      private function refreshSelection() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = this._activeRenderers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._activeRenderers[_loc3_];
            _loc2_.isSelected = this._selectedIndices.getItemIndex(_loc2_.index) >= 0;
            _loc3_++;
         }
      }
      
      private function refreshEnabled() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = this._activeRenderers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = IFeathersControl(this._activeRenderers[_loc3_]);
            _loc2_.isEnabled = this._isEnabled;
            _loc3_++;
         }
      }
      
      private function refreshViewPortBounds() : void
      {
         var _loc1_:int = 0;
         this._viewPortBounds.y = _loc1_;
         this._viewPortBounds.x = _loc1_;
         this._viewPortBounds.scrollX = this._horizontalScrollPosition;
         this._viewPortBounds.scrollY = this._verticalScrollPosition;
         this._viewPortBounds.explicitWidth = this.explicitVisibleWidth;
         this._viewPortBounds.explicitHeight = this.explicitVisibleHeight;
         this._viewPortBounds.minWidth = this._minVisibleWidth;
         this._viewPortBounds.minHeight = this._minVisibleHeight;
         this._viewPortBounds.maxWidth = this._maxVisibleWidth;
         this._viewPortBounds.maxHeight = this._maxVisibleHeight;
      }
      
      private function refreshInactiveRenderers(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:Vector.<IListItemRenderer> = this._inactiveRenderers;
         this._inactiveRenderers = this._activeRenderers;
         this._activeRenderers = _loc2_;
         if(param1)
         {
            while(_activeRenderers.length > 0)
            {
               this.destroyRenderer(_activeRenderers.pop());
            }
            this.recoverInactiveRenderers();
            this.freeInactiveRenderers(param1);
            if(this._typicalItemRenderer)
            {
               if(this._typicalItemIsInDataProvider)
               {
                  delete this._rendererMap[this._typicalItemRenderer.data];
               }
               this.destroyRenderer(this._typicalItemRenderer);
               this._typicalItemRenderer = null;
               this._typicalItemIsInDataProvider = false;
            }
         }
         else
         {
            while(_activeRenderers.length > 0)
            {
               _loc3_ = _activeRenderers.pop();
               _loc3_.owner = this._owner;
               this.addChild(DisplayObject(_loc3_));
               _inactiveRenderers.push(_loc3_);
            }
         }
         this._layoutItems.length = 0;
      }
      
      private function refreshRenderers() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(this._typicalItemRenderer)
         {
            if(this._typicalItemIsInDataProvider)
            {
               _loc2_ = this._inactiveRenderers.indexOf(this._typicalItemRenderer);
               if(_loc2_ >= 0)
               {
                  this._inactiveRenderers[_loc2_] = null;
               }
               _loc1_ = this._activeRenderers.length;
               if(_loc1_ == 0)
               {
                  this._activeRenderers[_loc1_] = this._typicalItemRenderer;
               }
            }
            this.refreshOneItemRendererStyles(this._typicalItemRenderer);
         }
         this.findUnrenderedData();
         this.recoverInactiveRenderers();
         this.renderUnrenderedData();
         this.freeInactiveRenderers(false);
         this._updateForDataReset = false;
      }
      
      private function findUnrenderedData() : void
      {
         var _loc16_:* = 0;
         var _loc14_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc10_:int = !!this._dataProvider?this._dataProvider.length:0;
         var _loc11_:IVirtualLayout = this._layout as IVirtualLayout;
         var _loc15_:Boolean = _loc11_ && _loc11_.useVirtualLayout;
         if(_loc15_)
         {
            _loc11_.measureViewPort(_loc10_,this._viewPortBounds,HELPER_POINT);
            _loc11_.getVisibleIndicesAtScrollPosition(this._horizontalScrollPosition,this._verticalScrollPosition,HELPER_POINT.x,HELPER_POINT.y,_loc10_,HELPER_VECTOR);
         }
         var _loc6_:int = !!_loc15_?HELPER_VECTOR.length:_loc10_;
         var _loc1_:Boolean = this._layout is ITrimmedVirtualLayout && _loc15_ && (!(this._layout is IVariableVirtualLayout) || !IVariableVirtualLayout(this._layout).hasVariableItemDimensions) && _loc6_ > 0;
         if(_loc1_)
         {
            _loc16_ = int(HELPER_VECTOR[0]);
            _loc14_ = _loc16_;
            _loc7_ = 1;
            while(_loc7_ < _loc6_)
            {
               _loc8_ = HELPER_VECTOR[_loc7_];
               if(_loc8_ < _loc16_)
               {
                  _loc16_ = _loc8_;
               }
               if(_loc8_ > _loc14_)
               {
                  _loc14_ = _loc8_;
               }
               _loc7_++;
            }
            _loc9_ = _loc16_ - 1;
            if(_loc9_ < 0)
            {
               _loc9_ = 0;
            }
            _loc12_ = _loc10_ - 1 - _loc14_;
            _loc13_ = ITrimmedVirtualLayout(this._layout);
            _loc13_.beforeVirtualizedItemCount = _loc9_;
            _loc13_.afterVirtualizedItemCount = _loc12_;
            this._layoutItems.length = _loc10_ - _loc9_ - _loc12_;
            this._layoutIndexOffset = -_loc9_;
         }
         else
         {
            this._layoutIndexOffset = 0;
            this._layoutItems.length = _loc10_;
         }
         var _loc17_:int = this._activeRenderers.length;
         var _loc4_:int = this._unrenderedData.length;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = !!_loc15_?HELPER_VECTOR[_loc7_]:int(_loc7_);
            if(!(_loc8_ < 0 || _loc8_ >= _loc10_))
            {
               _loc2_ = this._dataProvider.getItemAt(_loc8_);
               _loc3_ = IListItemRenderer(this._rendererMap[_loc2_]);
               if(_loc3_)
               {
                  _loc3_.index = _loc8_;
                  _loc3_.visible = true;
                  if(this._updateForDataReset)
                  {
                     _loc3_.data = null;
                     _loc3_.data = _loc2_;
                  }
                  if(this._typicalItemRenderer != _loc3_)
                  {
                     this._activeRenderers[_loc17_] = _loc3_;
                     _loc17_++;
                     _loc5_ = this._inactiveRenderers.indexOf(_loc3_);
                     if(_loc5_ >= 0)
                     {
                        this._inactiveRenderers[_loc5_] = null;
                     }
                     else
                     {
                        throw new IllegalOperationError("ListDataViewPort: renderer map contains bad data.");
                     }
                  }
                  this._layoutItems[_loc8_ + this._layoutIndexOffset] = DisplayObject(_loc3_);
               }
               else
               {
                  this._unrenderedData[_loc4_] = _loc2_;
                  _loc4_++;
               }
            }
            _loc7_++;
         }
         if(this._typicalItemRenderer)
         {
            if(_loc15_ && this._typicalItemIsInDataProvider)
            {
               _loc8_ = HELPER_VECTOR.indexOf(this._typicalItemRenderer.index);
               if(_loc8_ >= 0)
               {
                  this._typicalItemRenderer.visible = true;
               }
               else
               {
                  this._typicalItemRenderer.visible = false;
               }
            }
            else
            {
               this._typicalItemRenderer.visible = this._typicalItemIsInDataProvider;
            }
         }
         HELPER_VECTOR.length = 0;
      }
      
      private function renderUnrenderedData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = this._unrenderedData.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc1_ = this._unrenderedData.shift();
            _loc4_ = this._dataProvider.getItemIndex(_loc1_);
            _loc2_ = this.createRenderer(_loc1_,_loc4_,true,false);
            _loc2_.visible = true;
            this._layoutItems[_loc4_ + this._layoutIndexOffset] = DisplayObject(_loc2_);
            _loc3_++;
         }
      }
      
      private function recoverInactiveRenderers() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = this._inactiveRenderers.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this._inactiveRenderers[_loc2_];
            if(_loc1_)
            {
               this._owner.dispatchEventWith("rendererRemove",false,_loc1_);
               delete this._rendererMap[_loc1_.data];
            }
            _loc2_++;
         }
      }
      
      private function freeInactiveRenderers(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = this._inactiveRenderers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this._inactiveRenderers.shift();
            if(_loc2_)
            {
               if(param1)
               {
                  this.destroyRenderer(_loc2_);
               }
               else
               {
                  _loc2_.data = null;
                  _inactiveRenderers.push(_loc2_);
                  this.removeChild(DisplayObject(_loc2_),false);
               }
            }
            _loc3_++;
         }
      }
      
      private function createRenderer(param1:Object, param2:int, param3:Boolean, param4:Boolean) : IListItemRenderer
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         do
         {
            if(!param3 || param4 || this._inactiveRenderers.length == 0)
            {
               if(this._itemRendererFactory != null)
               {
                  _loc5_ = IListItemRenderer(this._itemRendererFactory());
               }
               else
               {
                  _loc5_ = new _itemRendererType();
               }
               _loc6_ = IFeathersControl(_loc5_);
               if(this._itemRendererName && this._itemRendererName.length > 0)
               {
                  _loc6_.styleNameList.add(this._itemRendererName);
               }
               this.addChild(DisplayObject(_loc5_));
            }
            else
            {
               _loc5_ = this._inactiveRenderers.shift();
            }
         }
         while(!_loc5_);
         
         _loc5_.data = param1;
         _loc5_.index = param2;
         _loc5_.owner = this._owner;
         if(!param4)
         {
            this._rendererMap[param1] = _loc5_;
            this._activeRenderers[this._activeRenderers.length] = _loc5_;
            _loc5_.addEventListener("change",renderer_changeHandler);
            _loc5_.addEventListener("resize",renderer_resizeHandler);
            this._owner.dispatchEventWith("rendererAdd",false,_loc5_);
         }
         return _loc5_;
      }
      
      private function destroyRenderer(param1:IListItemRenderer) : void
      {
         param1.removeEventListener("change",renderer_changeHandler);
         param1.removeEventListener("resize",renderer_resizeHandler);
         param1.owner = null;
         param1.data = null;
         if(param1.parent)
         {
            this.removeChild(DisplayObject(param1),true);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function childProperties_onChange(param1:PropertyProxy, param2:String) : void
      {
         this.invalidate("styles");
      }
      
      private function owner_scrollStartHandler(param1:Event) : void
      {
         this._isScrolling = true;
      }
      
      private function dataProvider_changeHandler(param1:Event) : void
      {
         this.invalidate("data");
      }
      
      private function dataProvider_addItemHandler(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = param1.data;
         var _loc3_:Boolean = false;
         var _loc8_:Vector.<int> = new Vector.<int>(0);
         var _loc4_:int = this._selectedIndices.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = this._selectedIndices.getItemAt(_loc6_) as int;
            if(_loc7_ >= _loc5_)
            {
               _loc7_++;
               _loc3_ = true;
            }
            _loc8_.push(_loc7_);
            _loc6_++;
         }
         if(_loc3_)
         {
            this._selectedIndices.data = _loc8_;
         }
         var _loc2_:IVariableVirtualLayout = this._layout as IVariableVirtualLayout;
         if(!_loc2_ || !_loc2_.hasVariableItemDimensions)
         {
            return;
         }
         _loc2_.addToVariableVirtualCacheAtIndex(_loc5_);
      }
      
      private function dataProvider_removeItemHandler(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = param1.data;
         var _loc3_:Boolean = false;
         var _loc8_:Vector.<int> = new Vector.<int>(0);
         var _loc4_:int = this._selectedIndices.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = this._selectedIndices.getItemAt(_loc6_) as int;
            if(_loc7_ == _loc5_)
            {
               _loc3_ = true;
            }
            else
            {
               if(_loc7_ > _loc5_)
               {
                  _loc7_--;
                  _loc3_ = true;
               }
               _loc8_.push(_loc7_);
            }
            _loc6_++;
         }
         if(_loc3_)
         {
            this._selectedIndices.data = _loc8_;
         }
         var _loc2_:IVariableVirtualLayout = this._layout as IVariableVirtualLayout;
         if(!_loc2_ || !_loc2_.hasVariableItemDimensions)
         {
            return;
         }
         _loc2_.removeFromVariableVirtualCacheAtIndex(_loc5_);
      }
      
      private function dataProvider_replaceItemHandler(param1:Event) : void
      {
         var _loc4_:int = param1.data;
         var _loc3_:int = this._selectedIndices.getItemIndex(_loc4_);
         if(_loc3_ >= 0)
         {
            this._selectedIndices.removeItemAt(_loc3_);
         }
         var _loc2_:IVariableVirtualLayout = this._layout as IVariableVirtualLayout;
         if(!_loc2_ || !_loc2_.hasVariableItemDimensions)
         {
            return;
         }
         _loc2_.resetVariableVirtualCacheAtIndex(_loc4_);
      }
      
      private function dataProvider_resetHandler(param1:Event) : void
      {
         this._selectedIndices.removeAll();
         this._updateForDataReset = true;
         var _loc2_:IVariableVirtualLayout = this._layout as IVariableVirtualLayout;
         if(!_loc2_ || !_loc2_.hasVariableItemDimensions)
         {
            return;
         }
         _loc2_.resetVariableVirtualCache();
      }
      
      private function dataProvider_updateItemHandler(param1:Event) : void
      {
         var _loc4_:int = param1.data;
         var _loc2_:Object = this._dataProvider.getItemAt(_loc4_);
         var _loc3_:IListItemRenderer = IListItemRenderer(this._rendererMap[_loc2_]);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.data = null;
         _loc3_.data = _loc2_;
      }
      
      private function layout_changeHandler(param1:Event) : void
      {
         if(this._ignoreLayoutChanges)
         {
            return;
         }
         this.invalidate("layout");
         this.invalidateParent("layout");
      }
      
      private function renderer_resizeHandler(param1:Event) : void
      {
         if(this._ignoreRendererResizing)
         {
            return;
         }
         var _loc2_:IVariableVirtualLayout = this._layout as IVariableVirtualLayout;
         if(!_loc2_ || !_loc2_.hasVariableItemDimensions)
         {
            return;
         }
         var _loc3_:IListItemRenderer = IListItemRenderer(param1.currentTarget);
         _loc2_.resetVariableVirtualCacheAtIndex(_loc3_.index,DisplayObject(_loc3_));
         this.invalidate("layout");
         this.invalidateParent("layout");
      }
      
      private function renderer_changeHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         if(this._ignoreSelectionChanges)
         {
            return;
         }
         var _loc2_:IListItemRenderer = IListItemRenderer(param1.currentTarget);
         if(!this._isSelectable || this._isScrolling)
         {
            _loc2_.isSelected = false;
            return;
         }
         var _loc3_:Boolean = _loc2_.isSelected;
         var _loc5_:int = _loc2_.index;
         if(this._allowMultipleSelection)
         {
            _loc4_ = this._selectedIndices.getItemIndex(_loc5_);
            if(_loc3_ && _loc4_ < 0)
            {
               this._selectedIndices.addItem(_loc5_);
            }
            else if(!_loc3_ && _loc4_ >= 0)
            {
               this._selectedIndices.removeItemAt(_loc4_);
            }
         }
         else if(_loc3_)
         {
            this._selectedIndices.data = new <int>[_loc5_];
         }
         else
         {
            this._selectedIndices.removeAll();
         }
      }
      
      private function selectedIndices_changeHandler(param1:Event) : void
      {
         this.invalidate("selected");
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         this.touchPointID = -1;
      }
      
      private function touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(!this._isEnabled)
         {
            this.touchPointID = -1;
            return;
         }
         if(this.touchPointID >= 0)
         {
            _loc2_ = param1.getTouch(this,"ended",this.touchPointID);
            if(!_loc2_)
            {
               return;
            }
            this.touchPointID = -1;
         }
         else
         {
            _loc2_ = param1.getTouch(this,"began");
            if(!_loc2_)
            {
               return;
            }
            this.touchPointID = _loc2_.id;
            this._isScrolling = false;
         }
      }
   }
}

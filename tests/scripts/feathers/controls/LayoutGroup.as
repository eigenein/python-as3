package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.IFeathersControl;
   import feathers.core.IValidating;
   import feathers.layout.ILayout;
   import feathers.layout.ILayoutDisplayObject;
   import feathers.layout.ILayoutableDisplayObject;
   import feathers.layout.IVirtualLayout;
   import feathers.layout.LayoutBoundsResult;
   import feathers.layout.ViewPortBounds;
   import feathers.skins.IStyleProvider;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class LayoutGroup extends FeathersControl
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      protected static const INVALIDATION_FLAG_MXML_CONTENT:String = "mxmlContent";
      
      protected static const INVALIDATION_FLAG_CLIPPING:String = "clipping";
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var items:Vector.<DisplayObject>;
      
      protected var viewPortBounds:ViewPortBounds;
      
      protected var _layoutResult:LayoutBoundsResult;
      
      protected var _layout:ILayout;
      
      protected var _mxmlContentIsReady:Boolean = false;
      
      protected var _mxmlContent:Array;
      
      protected var _clipContent:Boolean = false;
      
      protected var originalBackgroundWidth:Number = NaN;
      
      protected var originalBackgroundHeight:Number = NaN;
      
      protected var currentBackgroundSkin:DisplayObject;
      
      protected var _backgroundSkin:DisplayObject;
      
      protected var _backgroundDisabledSkin:DisplayObject;
      
      protected var _ignoreChildChanges:Boolean = false;
      
      public function LayoutGroup()
      {
         items = new Vector.<DisplayObject>(0);
         viewPortBounds = new ViewPortBounds();
         _layoutResult = new LayoutBoundsResult();
         super();
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return LayoutGroup.globalStyleProvider;
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
            this._layout.removeEventListener("change",layout_changeHandler);
         }
         this._layout = param1;
         if(this._layout)
         {
            if(this._layout is IVirtualLayout)
            {
               IVirtualLayout(this._layout).useVirtualLayout = false;
            }
            this._layout.addEventListener("change",layout_changeHandler);
            this.invalidate("layout");
         }
         this.invalidate("layout");
      }
      
      public function get mxmlContent() : Array
      {
         return this._mxmlContent;
      }
      
      public function set mxmlContent(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         if(this._mxmlContent == param1)
         {
            return;
         }
         if(this._mxmlContent && this._mxmlContentIsReady)
         {
            _loc3_ = this._mxmlContent.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = DisplayObject(this._mxmlContent[_loc2_]);
               this.removeChild(_loc4_,true);
               _loc2_++;
            }
         }
         this._mxmlContent = param1;
         this._mxmlContentIsReady = false;
         this.invalidate("mxmlContent");
      }
      
      public function get clipContent() : Boolean
      {
         return this._clipContent;
      }
      
      public function set clipContent(param1:Boolean) : void
      {
         if(this._clipContent == param1)
         {
            return;
         }
         this._clipContent = param1;
         this.invalidate("clipping");
      }
      
      public function get backgroundSkin() : DisplayObject
      {
         return this._backgroundSkin;
      }
      
      public function set backgroundSkin(param1:DisplayObject) : void
      {
         if(this._backgroundSkin == param1)
         {
            return;
         }
         this._backgroundSkin = param1;
         this.invalidate("skin");
      }
      
      public function get backgroundDisabledSkin() : DisplayObject
      {
         return this._backgroundDisabledSkin;
      }
      
      public function set backgroundDisabledSkin(param1:DisplayObject) : void
      {
         if(this._backgroundDisabledSkin == param1)
         {
            return;
         }
         this._backgroundDisabledSkin = param1;
         this.invalidate("skin");
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(param1 is IFeathersControl)
         {
            param1.addEventListener("resize",child_resizeHandler);
         }
         if(param1 is ILayoutableDisplayObject)
         {
            param1.addEventListener("layoutDataChange",child_layoutDataChangeHandler);
         }
         var _loc3_:int = this.items.indexOf(param1);
         if(_loc3_ == param2)
         {
            return param1;
         }
         if(_loc3_ >= 0)
         {
            this.items.splice(_loc3_,1);
         }
         var _loc4_:int = this.items.length;
         if(param2 == _loc4_)
         {
            this.items[param2] = param1;
         }
         else
         {
            this.items.splice(param2,0,param1);
         }
         this.invalidate("layout");
         return super.addChildAt(param1,param2);
      }
      
      override public function removeChildAt(param1:int, param2:Boolean = false) : DisplayObject
      {
         var _loc3_:DisplayObject = super.removeChildAt(param1,param2);
         if(_loc3_ is IFeathersControl)
         {
            _loc3_.removeEventListener("resize",child_resizeHandler);
         }
         if(_loc3_ is ILayoutDisplayObject)
         {
            _loc3_.removeEventListener("layoutDataChange",child_layoutDataChangeHandler);
         }
         this.items.splice(param1,1);
         this.invalidate("layout");
         return _loc3_;
      }
      
      override public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         super.setChildIndex(param1,param2);
         var _loc3_:int = this.items.indexOf(param1);
         if(_loc3_ == param2)
         {
            return;
         }
         this.items.splice(_loc3_,1);
         this.items.splice(param2,0,param1);
         this.invalidate("layout");
      }
      
      override public function swapChildrenAt(param1:int, param2:int) : void
      {
         super.swapChildrenAt(param1,param2);
         var _loc4_:DisplayObject = this.items[param1];
         var _loc3_:DisplayObject = this.items[param2];
         this.items[param1] = _loc3_;
         this.items[param2] = _loc4_;
         this.invalidate("layout");
      }
      
      override public function sortChildren(param1:Function) : void
      {
         super.sortChildren(param1);
         this.items.sort(param1);
         this.invalidate("layout");
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         var _loc5_:Number = param1.x;
         var _loc4_:Number = param1.y;
         var _loc3_:DisplayObject = super.hitTest(param1,param2);
         if(_loc3_)
         {
            if(!this._isEnabled)
            {
               return this;
            }
            return _loc3_;
         }
         if(this.currentBackgroundSkin && this._hitArea.contains(_loc5_,_loc4_))
         {
            return this;
         }
         return null;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc3_:* = null;
         if(this.currentBackgroundSkin && this.currentBackgroundSkin.hasVisibleArea)
         {
            _loc3_ = this.blendMode;
            param1.pushMatrix();
            param1.transformMatrix(this.currentBackgroundSkin);
            param1.blendMode = this.currentBackgroundSkin.blendMode;
            this.currentBackgroundSkin.render(param1,param2 * this.alpha);
            param1.blendMode = _loc3_;
            param1.popMatrix();
         }
         super.render(param1,param2);
      }
      
      override public function dispose() : void
      {
         this.layout = null;
         super.dispose();
      }
      
      public function readjustLayout() : void
      {
         this.invalidate("layout");
      }
      
      override protected function initialize() : void
      {
         this.refreshMXMLContent();
      }
      
      override protected function draw() : void
      {
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:Boolean = this.isInvalid("layout");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc6_:Boolean = this.isInvalid("clipping");
         var _loc7_:Boolean = this.isInvalid("scroll");
         var _loc3_:Boolean = this.isInvalid("skin");
         var _loc4_:Boolean = this.isInvalid("state");
         if(!_loc2_ && _loc7_ && this._layout && this._layout.requiresLayoutOnScroll)
         {
            _loc2_ = true;
         }
         if(_loc3_ || _loc4_)
         {
            this.refreshBackgroundSkin();
         }
         if(_loc1_ || _loc2_ || _loc3_ || _loc4_)
         {
            this.refreshViewPortBounds();
            if(this._layout)
            {
               this._ignoreChildChanges = true;
               this._layout.layout(this.items,this.viewPortBounds,this._layoutResult);
               this._ignoreChildChanges = false;
            }
            else
            {
               this.handleManualLayout();
            }
            _loc5_ = this._layoutResult.contentWidth;
            if(this.originalBackgroundWidth === this.originalBackgroundWidth && this.originalBackgroundWidth > _loc5_)
            {
               _loc5_ = this.originalBackgroundWidth;
            }
            _loc8_ = this._layoutResult.contentHeight;
            if(this.originalBackgroundHeight === this.originalBackgroundHeight && this.originalBackgroundHeight > _loc8_)
            {
               _loc8_ = this.originalBackgroundHeight;
            }
            _loc1_ = this.setSizeInternal(_loc5_,_loc8_,false) || _loc1_;
            if(this.currentBackgroundSkin)
            {
               this.currentBackgroundSkin.width = this.actualWidth;
               this.currentBackgroundSkin.height = this.actualHeight;
            }
            this.validateChildren();
         }
         if(_loc1_ || _loc6_)
         {
            this.refreshClipRect();
         }
      }
      
      protected function refreshBackgroundSkin() : void
      {
         if(!this._isEnabled && this._backgroundDisabledSkin)
         {
            this.currentBackgroundSkin = this._backgroundDisabledSkin;
         }
         else
         {
            this.currentBackgroundSkin = this._backgroundSkin;
         }
         if(this.currentBackgroundSkin)
         {
            if(this.originalBackgroundWidth !== this.originalBackgroundWidth || this.originalBackgroundHeight !== this.originalBackgroundHeight)
            {
               if(this.currentBackgroundSkin is IValidating)
               {
                  IValidating(this.currentBackgroundSkin).validate();
               }
               this.originalBackgroundWidth = this.currentBackgroundSkin.width;
               this.originalBackgroundHeight = this.currentBackgroundSkin.height;
            }
         }
      }
      
      protected function refreshViewPortBounds() : void
      {
         this.viewPortBounds.x = 0;
         this.viewPortBounds.y = 0;
         this.viewPortBounds.scrollX = 0;
         this.viewPortBounds.scrollY = 0;
         this.viewPortBounds.explicitWidth = this.explicitWidth;
         this.viewPortBounds.explicitHeight = this.explicitHeight;
         this.viewPortBounds.minWidth = this._minWidth;
         this.viewPortBounds.minHeight = this._minHeight;
         this.viewPortBounds.maxWidth = this._maxWidth;
         this.viewPortBounds.maxHeight = this._maxHeight;
      }
      
      protected function handleManualLayout() : void
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc6_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:* = Number(this.viewPortBounds.explicitWidth);
         if(_loc4_ !== _loc4_)
         {
            _loc4_ = 0;
         }
         var _loc3_:* = Number(this.viewPortBounds.explicitHeight);
         if(_loc3_ !== _loc3_)
         {
            _loc3_ = 0;
         }
         this._ignoreChildChanges = true;
         var _loc7_:int = this.items.length;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc1_ = this.items[_loc5_];
            if(!(_loc1_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc1_).includeInLayout))
            {
               if(_loc1_ is IValidating)
               {
                  IValidating(_loc1_).validate();
               }
               _loc6_ = _loc1_.x + _loc1_.width;
               _loc2_ = _loc1_.y + _loc1_.height;
               if(_loc6_ === _loc6_ && _loc6_ > _loc4_)
               {
                  _loc4_ = _loc6_;
               }
               if(_loc2_ === _loc2_ && _loc2_ > _loc3_)
               {
                  _loc3_ = _loc2_;
               }
            }
            _loc5_++;
         }
         this._ignoreChildChanges = false;
         this._layoutResult.contentX = 0;
         this._layoutResult.contentY = 0;
         this._layoutResult.contentWidth = _loc4_;
         this._layoutResult.contentHeight = _loc3_;
         this._layoutResult.viewPortWidth = _loc4_;
         this._layoutResult.viewPortHeight = _loc3_;
      }
      
      protected function validateChildren() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(this.currentBackgroundSkin is IValidating)
         {
            IValidating(this.currentBackgroundSkin).validate();
         }
         var _loc3_:int = this.items.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.items[_loc2_];
            if(_loc1_ is IValidating)
            {
               IValidating(_loc1_).validate();
            }
            _loc2_++;
         }
      }
      
      protected function refreshMXMLContent() : void
      {
         var _loc1_:int = 0;
         var _loc3_:* = null;
         if(!this._mxmlContent || this._mxmlContentIsReady)
         {
            return;
         }
         var _loc2_:int = this._mxmlContent.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = DisplayObject(this._mxmlContent[_loc1_]);
            this.addChild(_loc3_);
            _loc1_++;
         }
         this._mxmlContentIsReady = true;
      }
      
      protected function refreshClipRect() : void
      {
         var _loc1_:* = null;
         if(this._clipContent)
         {
            if(!this.clipRect)
            {
               this.clipRect = new Rectangle();
            }
            _loc1_ = this.clipRect;
            _loc1_.x = 0;
            _loc1_.y = 0;
            _loc1_.width = this.actualWidth;
            _loc1_.height = this.actualHeight;
            this.clipRect = _loc1_;
         }
         else
         {
            this.clipRect = null;
         }
      }
      
      protected function layout_changeHandler(param1:Event) : void
      {
         this.invalidate("layout");
      }
      
      protected function child_resizeHandler(param1:Event) : void
      {
         if(this._ignoreChildChanges)
         {
            return;
         }
         this.invalidate("layout");
      }
      
      protected function child_layoutDataChangeHandler(param1:Event) : void
      {
         if(this._ignoreChildChanges)
         {
            return;
         }
         this.invalidate("layout");
      }
   }
}

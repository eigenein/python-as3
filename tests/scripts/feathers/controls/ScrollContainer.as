package feathers.controls
{
   import feathers.controls.supportClasses.LayoutViewPort;
   import feathers.layout.ILayout;
   import feathers.layout.IVirtualLayout;
   import feathers.skins.IStyleProvider;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   [Event(name="change",type="starling.events.Event")]
   public class ScrollContainer extends Scroller implements IScrollContainer
   {
      
      protected static const INVALIDATION_FLAG_MXML_CONTENT:String = "mxmlContent";
      
      public static const ALTERNATE_NAME_TOOLBAR:String = "feathers-toolbar-scroll-container";
      
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
       
      
      protected var displayListBypassEnabled:Boolean = true;
      
      protected var layoutViewPort:LayoutViewPort;
      
      protected var _layout:ILayout;
      
      protected var _mxmlContentIsReady:Boolean = false;
      
      protected var _mxmlContent:Array;
      
      public function ScrollContainer()
      {
         super();
         this.layoutViewPort = new LayoutViewPort();
         this.viewPort = this.layoutViewPort;
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return ScrollContainer.globalStyleProvider;
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
      
      override public function get numChildren() : int
      {
         if(!this.displayListBypassEnabled)
         {
            return super.numChildren;
         }
         return DisplayObjectContainer(this.viewPort).numChildren;
      }
      
      public function get numRawChildren() : int
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         var _loc1_:int = super.numChildren;
         this.displayListBypassEnabled = _loc2_;
         return _loc1_;
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.getChildByName(param1);
         }
         return DisplayObjectContainer(this.viewPort).getChildByName(param1);
      }
      
      public function getRawChildByName(param1:String) : DisplayObject
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         var _loc3_:DisplayObject = super.getChildByName(param1);
         this.displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      override public function getChildAt(param1:int) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.getChildAt(param1);
         }
         return DisplayObjectContainer(this.viewPort).getChildAt(param1);
      }
      
      public function getRawChildAt(param1:int) : DisplayObject
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         var _loc3_:DisplayObject = super.getChildAt(param1);
         this.displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      public function addRawChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         if(param1.parent == this)
         {
            super.setChildIndex(param1,super.numChildren);
         }
         else
         {
            param1 = super.addChildAt(param1,super.numChildren);
         }
         this.displayListBypassEnabled = _loc2_;
         return param1;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.addChildAt(param1,param2);
         }
         return DisplayObjectContainer(this.viewPort).addChildAt(param1,param2);
      }
      
      public function addRawChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         param1 = super.addChildAt(param1,param2);
         this.displayListBypassEnabled = _loc3_;
         return param1;
      }
      
      public function removeRawChild(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         var _loc3_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         var _loc4_:int = super.getChildIndex(param1);
         if(_loc4_ >= 0)
         {
            super.removeChildAt(_loc4_,param2);
         }
         this.displayListBypassEnabled = _loc3_;
         return param1;
      }
      
      override public function removeChildAt(param1:int, param2:Boolean = false) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.removeChildAt(param1,param2);
         }
         return DisplayObjectContainer(this.viewPort).removeChildAt(param1,param2);
      }
      
      public function removeRawChildAt(param1:int, param2:Boolean = false) : DisplayObject
      {
         var _loc3_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         var _loc4_:DisplayObject = super.removeChildAt(param1,param2);
         this.displayListBypassEnabled = _loc3_;
         return _loc4_;
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         if(!this.displayListBypassEnabled)
         {
            return super.getChildIndex(param1);
         }
         return DisplayObjectContainer(this.viewPort).getChildIndex(param1);
      }
      
      public function getRawChildIndex(param1:DisplayObject) : int
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         return super.getChildIndex(param1);
      }
      
      override public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         if(!this.displayListBypassEnabled)
         {
            super.setChildIndex(param1,param2);
            return;
         }
         DisplayObjectContainer(this.viewPort).setChildIndex(param1,param2);
      }
      
      public function setRawChildIndex(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         super.setChildIndex(param1,param2);
         this.displayListBypassEnabled = _loc3_;
      }
      
      public function swapRawChildren(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc3_:int = this.getRawChildIndex(param1);
         var _loc5_:int = this.getRawChildIndex(param2);
         if(_loc3_ < 0 || _loc5_ < 0)
         {
            throw new ArgumentError("Not a child of this container");
         }
         var _loc4_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         this.swapRawChildrenAt(_loc3_,_loc5_);
         this.displayListBypassEnabled = _loc4_;
      }
      
      override public function swapChildrenAt(param1:int, param2:int) : void
      {
         if(!this.displayListBypassEnabled)
         {
            super.swapChildrenAt(param1,param2);
            return;
         }
         DisplayObjectContainer(this.viewPort).swapChildrenAt(param1,param2);
      }
      
      public function swapRawChildrenAt(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         super.swapChildrenAt(param1,param2);
         this.displayListBypassEnabled = _loc3_;
      }
      
      override public function sortChildren(param1:Function) : void
      {
         if(!this.displayListBypassEnabled)
         {
            super.sortChildren(param1);
            return;
         }
         DisplayObjectContainer(this.viewPort).sortChildren(param1);
      }
      
      public function sortRawChildren(param1:Function) : void
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         super.sortChildren(param1);
         this.displayListBypassEnabled = _loc2_;
      }
      
      public function readjustLayout() : void
      {
         this.layoutViewPort.readjustLayout();
         this.invalidate("size");
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.refreshMXMLContent();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc5_:Boolean = this.isInvalid("styles");
         var _loc3_:Boolean = this.isInvalid("state");
         var _loc2_:Boolean = this.isInvalid("layout");
         var _loc4_:Boolean = this.isInvalid("mxmlContent");
         if(_loc4_)
         {
            this.refreshMXMLContent();
         }
         if(_loc2_)
         {
            if(this._layout is IVirtualLayout)
            {
               IVirtualLayout(this._layout).useVirtualLayout = false;
            }
            this.layoutViewPort.layout = this._layout;
         }
         super.draw();
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
   }
}

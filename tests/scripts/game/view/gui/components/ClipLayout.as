package game.view.gui.components
{
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import engine.core.clipgui.IClipLayout;
   import engine.core.clipgui.IGuiClip;
   import feathers.controls.LayoutGroup;
   import feathers.layout.AnchorLayout;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.ILayout;
   import feathers.layout.ILayoutableDisplayObject;
   import feathers.layout.TiledRowsLayout;
   import feathers.layout.VerticalLayout;
   import flash.utils.getQualifiedClassName;
   import game.assets.storage.AssetStorage;
   import starling.display.DisplayObject;
   import starling.display.Image;
   
   public class ClipLayout extends LayoutGroup implements IGuiClip, IClipLayout, ILayoutableDisplayObject
   {
       
      
      protected var children:Array;
      
      public function ClipLayout(param1:ILayout, param2:Array = null)
      {
         super();
         this.children = param2;
         layout = param1;
         if(param2 != null)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param2;
            for each(var _loc3_ in param2)
            {
               if(!_loc3_)
               {
                  trace(getQualifiedClassName(this),"constructor: один из детей не создан на момент создания layout\'a");
                  assert(false);
               }
            }
         }
      }
      
      public static function horizontalCentered(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "center";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalMiddle(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.verticalAlign = "middle";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalMiddleCentered(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "center";
         _loc3_.verticalAlign = "middle";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalBottomCentered(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "center";
         _loc3_.verticalAlign = "bottom";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalBottomLeft(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "left";
         _loc3_.verticalAlign = "bottom";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalLeft(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "left";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalRight(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "right";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalMiddleLeft(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "left";
         _loc3_.verticalAlign = "middle";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalMiddleRight(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "right";
         _loc3_.verticalAlign = "middle";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalDownLeft(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "left";
         _loc3_.verticalAlign = "bottom";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontalTopLeft(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.horizontalAlign = "left";
         _loc3_.verticalAlign = "top";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function horizontal(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function tiled(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:TiledRowsLayout = new TiledRowsLayout();
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function tiledMiddleCentered(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:TiledRowsLayout = new TiledRowsLayout();
         _loc3_.useSquareTiles = false;
         _loc3_.gap = param1;
         _loc3_.horizontalAlign = "center";
         _loc3_.verticalAlign = "middle";
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function anchor(... rest) : ClipLayout
      {
         var _loc2_:AnchorLayout = new AnchorLayout();
         return new ClipLayout(_loc2_,rest);
      }
      
      public static function none(... rest) : ClipLayout
      {
         return new ClipLayoutNone(rest);
      }
      
      public static function vertical(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function verticalCenter(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.gap = param1;
         _loc3_.horizontalAlign = "center";
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function verticalMiddleCenter(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.verticalAlign = "middle";
         _loc3_.horizontalAlign = "center";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function verticalMiddleLeft(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.verticalAlign = "middle";
         _loc3_.horizontalAlign = "left";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function verticalBottomCenter(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.verticalAlign = "bottom";
         _loc3_.horizontalAlign = "center";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      public static function verticalBottomRight(param1:Number, ... rest) : ClipLayout
      {
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.verticalAlign = "bottom";
         _loc3_.horizontalAlign = "right";
         _loc3_.gap = param1;
         return new ClipLayout(_loc3_,rest);
      }
      
      override public function dispose() : void
      {
         if(hasEventListener("disposed"))
         {
            broadcastEventWith("disposed");
         }
         super.dispose();
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function layoutChildren() : void
      {
         var _loc1_:* = undefined;
         if(children != null)
         {
            var _loc7_:int = 0;
            var _loc6_:* = children;
            for each(var _loc3_ in children)
            {
               if(_loc3_ is IGuiClip)
               {
                  addChild((_loc3_ as IGuiClip).graphics);
               }
               else if(_loc3_ is Vector.<*>)
               {
                  _loc1_ = _loc3_ as Vector.<*>;
                  var _loc5_:int = 0;
                  var _loc4_:* = _loc1_;
                  for each(var _loc2_ in _loc1_)
                  {
                     if(_loc2_ is IGuiClip)
                     {
                        addChild((_loc2_ as IGuiClip).graphics);
                     }
                  }
                  continue;
               }
            }
            children = null;
         }
      }
      
      override public function get includeInLayout() : Boolean
      {
         return visible && _includeInLayout;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(visible == param1)
         {
            return;
         }
         .super.visible = param1;
         this.dispatchEventWith("layoutDataChange");
      }
      
      public function setNode(param1:Node) : void
      {
         graphics.width = param1.clip.bounds.width;
         graphics.height = param1.clip.bounds.height;
         StarlingClipNode.applyState(graphics,param1.state);
      }
      
      private function drawLayout() : void
      {
         var _loc1_:Image = new Image(AssetStorage.rsx.missing);
         _loc1_.width = graphics.width;
         _loc1_.height = graphics.height;
         var _loc2_:LayoutGroup = new LayoutGroup();
         _loc2_.includeInLayout = false;
         addChildAt(_loc2_,0);
         _loc2_.addChild(_loc1_);
      }
   }
}

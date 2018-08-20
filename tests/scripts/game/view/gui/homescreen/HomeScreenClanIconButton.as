package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.IGuiClip;
   import game.view.gui.components.ClipLayout;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.filters.ColorMatrixFilter;
   
   public class HomeScreenClanIconButton extends HomeScreenGuiClipButton
   {
      
      public static const ALPHA_TRANSITION_DURATION:Number = 0.15;
       
      
      public var filteredObjects:Vector.<IGuiClip>;
      
      public var layout_banner:ClipLayout;
      
      public var default_flag:ClipSprite;
      
      public var clan_icon_bg:ClipSprite;
      
      public var to_home_screen:ClipSprite;
      
      public var circle_graphic:ClipSprite;
      
      public var animation_glow:GuiAnimation;
      
      public var layout_animation:ClipLayout;
      
      private var _enabledProperty:Number = 1;
      
      public function HomeScreenClanIconButton()
      {
         filteredObjects = new Vector.<IGuiClip>();
         layout_banner = ClipLayout.none();
         default_flag = new ClipSprite();
         clan_icon_bg = new ClipSprite();
         to_home_screen = new ClipSprite();
         circle_graphic = new ClipSprite();
         animation_glow = new GuiAnimation();
         layout_animation = ClipLayout.none(animation_glow);
         super();
      }
      
      public function get enabledProperty() : Number
      {
         return _enabledProperty;
      }
      
      public function set enabledProperty(param1:Number) : void
      {
         _enabledProperty = param1;
         var _loc2_:* = param1;
         to_home_screen.graphics.alpha = _loc2_;
         clan_icon_bg.graphics.alpha = _loc2_;
         default_flag.graphics.alpha = _loc2_;
         layout_banner.graphics.alpha = _loc2_;
         guiClipLabel.graphics.alpha = _loc2_;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         filteredObjects.push(to_home_screen);
         filteredObjects.push(labelBackground);
         filteredObjects.push(clan_icon_bg);
         filteredObjects.push(circle_graphic);
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         controller.isEnabled = param1;
         if(param1)
         {
            Starling.juggler.removeTweens(this);
            Starling.juggler.tween(this,0.15,{"enabledProperty":1});
         }
         else
         {
            Starling.juggler.removeTweens(this);
            Starling.juggler.tween(this,0.15,{"enabledProperty":0});
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            applyHighlight(true);
         }
         else
         {
            applyHighlight(false);
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      private function applyHighlight(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:int = filteredObjects.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = (filteredObjects[_loc4_] as IGuiClip).graphics;
            if(param1)
            {
               _loc5_ = new ColorMatrixFilter();
               _loc5_.adjustBrightness(0.1);
               _loc3_.filter = _loc5_;
            }
            else
            {
               if(_loc3_.filter)
               {
                  _loc3_.filter.dispose();
               }
               _loc3_.filter = null;
            }
            _loc4_++;
         }
      }
   }
}

package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   
   public class HomeScreenGuiClip extends ClipAnimatedContainer
   {
       
      
      public var meteor_front:GuiAnimation;
      
      public var btn_shop:HomeScreenShopBuildingButton;
      
      public var btn_portal:HomeScreenPortalGuiClipButton;
      
      public var btn_arena:HomeScreenArenaButton;
      
      public var btn_grand_arena:HomeScreenGrandArenaButton;
      
      public var btn_vagon:HomeScreenVagonButton;
      
      public var btn_ny_vagon:HomeScreenNYVagonButton;
      
      public var btn_expeditions:HomeScreenExpeditionsButton;
      
      public var btn_tower:HomeScreenTowerButton;
      
      public var btn_chest:HomeScreenGuiChestClipButton;
      
      public var vector:Vector.<HomeScreenGuiClipButton>;
      
      public var hero_team_marker:GuiClipContainer;
      
      public var ground_image:ClipSprite;
      
      public var event_anim:Vector.<GuiAnimation>;
      
      public function HomeScreenGuiClip()
      {
         btn_grand_arena = new HomeScreenGrandArenaButton();
         event_anim = new Vector.<GuiAnimation>();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         super.setNode(param1);
         ground_image.graphics.touchable = false;
         var _loc2_:int = event_anim.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(event_anim[_loc3_].graphics)
            {
               event_anim[_loc3_].graphics.touchable = false;
            }
            _loc3_++;
         }
      }
   }
}

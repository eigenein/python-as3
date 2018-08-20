package game.view.popup.tower.complete
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class TowerCompletePanel extends ClipAnimatedContainer
   {
       
      
      public var animation_EpicRays_inst0:GuiAnimation;
      
      public var rays_inst1:GuiAnimation;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var button_browes:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_message:SpecialClipLabel;
      
      public var tf_message_canFullSkipTomorrow:SpecialClipLabel;
      
      public var tf_reward_title:ClipLabel;
      
      public var reward_title_container:ClipLayout;
      
      public var reward_list_container:ClipLayout;
      
      public var line:GuiClipScale3Image;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var tf_skip_tower_desc:ClipLabel;
      
      public function TowerCompletePanel()
      {
         animation_EpicRays_inst0 = new GuiAnimation();
         rays_inst1 = new GuiAnimation();
         ribbon_154_154_2_inst0 = new ClipSprite();
         button_browes = new ClipButton();
         tf_header = new ClipLabel();
         tf_message = new SpecialClipLabel();
         tf_message_canFullSkipTomorrow = new SpecialClipLabel();
         tf_reward_title = new ClipLabel(true);
         reward_title_container = ClipLayout.horizontalMiddleCentered(10,tf_reward_title,button_browes);
         reward_list_container = ClipLayout.horizontalCentered(5);
         line = new GuiClipScale3Image(148,1);
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         tf_skip_tower_desc = new ClipLabel();
         super();
      }
      
      override public function dispose() : void
      {
         animation_EpicRays_inst0.dispose();
         rays_inst1.dispose();
         graphics.dispose();
      }
   }
}

package game.mechanics.boss.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class BossVictoryPopupClip extends GuiClipNestedContainer
   {
       
      
      public var bounds_layout_container:GuiClipLayoutContainer;
      
      public var tf_label_header:ClipLabel;
      
      public var tf_label_description:ClipLabel;
      
      public var button_ok:ClipButtonLabeled;
      
      public var button_stats:ClipButtonLabeled;
      
      public var star_animation:Vector.<GuiAnimation>;
      
      public var star_empty_1:ClipSprite;
      
      public var star_empty_2:ClipSprite;
      
      public var star_empty_3:ClipSprite;
      
      public var tf_reward:ClipLabel;
      
      public var layout_rewards:ClipLayout;
      
      public function BossVictoryPopupClip()
      {
         tf_label_header = new ClipLabel();
         tf_label_description = new ClipLabel();
         star_empty_1 = new ClipSprite();
         star_empty_2 = new ClipSprite();
         star_empty_3 = new ClipSprite();
         tf_reward = new ClipLabel();
         layout_rewards = ClipLayout.horizontalMiddleCentered(5);
         super();
      }
   }
}

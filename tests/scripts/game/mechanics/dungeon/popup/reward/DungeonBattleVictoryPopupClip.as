package game.mechanics.dungeon.popup.reward
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class DungeonBattleVictoryPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_header:ClipLabel;
      
      public var tf_reward_label:ClipLabel;
      
      public var rays_inst0:GuiAnimation;
      
      public var star_animation_1:GuiAnimation;
      
      public var star_animation_2:GuiAnimation;
      
      public var star_animation_3:GuiAnimation;
      
      public var star_empty_1:ClipSprite;
      
      public var star_empty_2:ClipSprite;
      
      public var star_empty_3:ClipSprite;
      
      public var bounds_layout_container:GuiClipLayoutContainer;
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var okButton:ClipButtonLabeled;
      
      public var layout_item_list:ClipLayout;
      
      public var hero_list_layout_container:ClipLayout;
      
      public var layout_reward_label:ClipLayout;
      
      public function DungeonBattleVictoryPopupClip()
      {
         tf_label_header = new ClipLabel();
         tf_reward_label = new ClipLabel();
         rays_inst0 = new GuiAnimation();
         star_animation_1 = new GuiAnimation();
         star_animation_2 = new GuiAnimation();
         star_animation_3 = new GuiAnimation();
         star_empty_1 = new ClipSprite();
         star_empty_2 = new ClipSprite();
         star_empty_3 = new ClipSprite();
         bounds_layout_container = new GuiClipLayoutContainer();
         layout_item_list = ClipLayout.horizontalMiddleCentered(4);
         hero_list_layout_container = ClipLayout.horizontalMiddleCentered(4);
         layout_reward_label = ClipLayout.verticalMiddleCenter(10,tf_reward_label);
         super();
      }
   }
}

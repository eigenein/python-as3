package game.mechanics.grand.popup
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class GrandBattleResultFinalPopupClip extends PopupClipBase
   {
       
      
      public var panel_attacker:GrandBattleResultPlayerPanelClip;
      
      public var panel_defender:GrandBattleResultPlayerPanelClip;
      
      public var container_header:ClipLayout;
      
      public var GlowRed_100_100_2_inst0:ClipSprite;
      
      public var tf_caption:ClipLabel;
      
      public var tf_place_after:ClipLabel;
      
      public var tf_place_before:ClipLabel;
      
      public var double_arrow_place:ClipSprite;
      
      public var layout_place:ClipLayout;
      
      public var container_place:ClipLayout;
      
      public var tf_label_reward:ClipLabel;
      
      public var reward_list_layout_container:GuiClipLayoutContainer;
      
      public var flatGlow_reward:ClipSprite;
      
      public var glowspot_reward:ClipSprite;
      
      public var container_reward:ClipLayout;
      
      public var battles:Vector.<GrandBattleResultBattleClip>;
      
      public var container_battles:ClipLayout;
      
      public var button_stats:ClipButtonLabeled;
      
      public var button_continue:ClipButtonLabeled;
      
      public var container_buttons:ClipLayout;
      
      public var container_all:ClipLayout;
      
      public function GrandBattleResultFinalPopupClip()
      {
         container_header = ClipLayout.none();
         GlowRed_100_100_2_inst0 = new ClipSprite();
         tf_caption = new ClipLabel();
         tf_place_after = new ClipLabel(true);
         tf_place_before = new ClipLabel(true);
         double_arrow_place = new ClipSprite();
         layout_place = ClipLayout.horizontalCentered(10,tf_place_before,double_arrow_place,tf_place_after);
         container_place = ClipLayout.none(GlowRed_100_100_2_inst0,tf_caption,layout_place);
         tf_label_reward = new ClipLabel();
         reward_list_layout_container = new GuiClipLayoutContainer();
         flatGlow_reward = new ClipSprite();
         glowspot_reward = new ClipSprite();
         container_reward = ClipLayout.none(tf_label_reward,reward_list_layout_container,flatGlow_reward,glowspot_reward);
         container_battles = ClipLayout.verticalMiddleCenter(2);
         button_stats = new ClipButtonLabeled();
         button_continue = new ClipButtonLabeled();
         container_buttons = ClipLayout.none(button_stats,button_continue);
         container_all = ClipLayout.verticalCenter(5,container_header,container_place,container_reward,container_battles,container_buttons);
         super();
      }
   }
}
